How to Deploy a Private Git Repo to Openshift
=============================================
:date: 2017-06-15
:tags: tech, openshift
:category: Tech
:slug: deploy-private-git-repo-to-openshift
:author: Lucy Wyman

`Openshift`_ is `Redhat's`_ platform as a service, aka a place for you
to deploy your application to (think Heroku, Google App Engine, or AWS
Beanstalk). They have a tool called `Source 2 Image (S2I)`_ that
allows you to pass in a `source`_ (in the form of a docker image, git
repo, or binary) and then builds an Openshift docker image from that.
Because I'm using this as a project for work, and my application
already lives on `Github`_, I decided to use a private Git repo as my
source for deploying my application to Openshift. Deploying public Git
repos is `well-documented`_, and while private repos don't require too
much additional setup there were a few hiccups along the road, and no
great step-by-step resource. So...I decided to write my own! 

.. _Openshift: https://openshift.com
.. _Redhat's: http://www.redhat.com/en
.. _Source 2 Image (S2I): https://docs.openshift.com/enterprise/3.1/architecture/core_concepts/builds_and_image_streams.html#source-build
.. _source: https://docs.openshift.org/latest/dev_guide/builds/index.html
.. _Github: https://github.com
.. _well-documented: https://docs.openshift.org/latest/dev_guide/application_lifecycle/new_app.html#specifying-source-code

Notes
-----

* This assumes that you already know `what Openshift is`_, and have some basic Git and web application knowledge. I essentially wrote what I wish I had read 2 days ago -- if there's any context you're missing I've tried to provide as many resources I think would be useful at the end of this article. 
* This also assumes you're on Linux, and I am far too lazy to find how to do all of this on other systems. If these don't work on OSX or Windows, maybe you should consider a different operating system?

.. _what Openshift is: https://developers.openshift.com/

Overview
--------

.. contents::

`Install the Openshift CLI`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Step 0 is to install the Openshift CLI. I generally find CLIs easier
to use + understand, but Openshift also has a nice GUI you can use
if you'd prefer.

**Note**: this assumes that you already have access to and Openshift
instance.

    - `Download`_
    - Untar :code:`tar -xvzf openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit.tar.gz`
    - Move binary into path :code:`mv openshift-origin-client-tools-v1.5.1-7b451fc-linux-64bit/oc /usr/local/bin`       

**Note**: If you're not sure what's in your path, run :code:`echo $PATH`

.. _Install the Openshift CLI: https://docs.openshift.org/latest/cli_reference/get_started_cli.html#cli-linux
.. _Download: https://github.com/openshift/origin/releases#Downloads

Create an `Openshift project`_
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This is where our applications, builds, etc. will live. I highly
recommend running :code:`oc new-project -h` first to see if there are
any flags or arguments you want to pass in! I just ran :code:`oc
new-project <project-name>`

.. _Openshift project: https://docs.openshift.org/latest/dev_guide/projects.html

Pause
~~~~~
Stop right here! Usually, the tutorials will tell you to make your
`Openshift application`_ next and pass in your Git URL. DON'T FALL FOR
IT. The problem is that for private repos, you need to have a deploy
key so Openshift can authenticate with the repo. However, the only way
to tell Openshift it needs the SSH key is in the `buildconfig`_. And
the buildconfig isn't generated until you either:

1. Try to create an application (the first build will fail then you can
   modify the buildconfig) OR
2. Have a template (basically write your own reusable buildconfig).

I ended up using a template, because it drove me nuts to have the
first build of the application fail. But you can see a `step-by-step
guide for option 1 here
<https://blog.openshift.com/using-ssh-key-for-s2i-builds/>`_
if you'd prefer to modify an existing buildconfig. 

.. _Openshift application: https://developers.openshift.com/managing-your-applications/creating-applications.html
.. _buildconfig: https://docs.openshift.org/latest/dev_guide/builds/index.html#defining-a-buildconfig 

Create an SSH Key
~~~~~~~~~~~~~~~~~
Ok, so, adding a deploy key to both our Github and Openshift. First things
first, lets make a special key (Don't use your own personal SSH key!
Make a new one!)

:code:`ssh-keygen -t rsa -b 4096 -C "openshift-key"`. 

**Note**: Make sure you give it a unique path, so that it doesn't
overwrite any existing SSH key(s)!

Add Public Key as a Deploy Key to Repo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Now we'll add the public key to our private Git repo as a deploy key,
so that it can verify communications with Openshift. See Git's
slightly more helpful documentation on how to do this `here
<https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys>`_ 

* Go to the repos main page in Github
* Click the 'Settings' tab
* Go to 'Deploy keys'
* Give it a name (can be anything)
* Paste the **public** key (:code:`~/.ssh/id_rsa-openshift.pub`) into the textbox
* Click add key

Add Key as a Secret to Openshift
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Now we have to give Openshift the private key, and make it an
`Openshift secret`_. Openshift secrets "decouple sensitive content
from the pods that use it and can be mounted into containers using a
volume plug-in or used by the system to perform actions on behalf of a
pod", which is very useful!  Creating them requires a few steps (read
more about why in `this poorly named blog post`_).

.. code-block:: none

    oc secrets new-sshauth openshiftkey --ssh-privatekey=$HOME/.ssh/id_rsa-openshift
    oc secrets add serviceaccount/builder secrets/openshiftkey

If you accidentally add the public key like I did, you can remove
secrets using :code:`oc delete secret openshiftkey`

.. _Openshift secret: https://docs.openshift.com/enterprise/3.0/dev_guide/secrets.html
.. _this poorly named blog post: https://blog.openshift.com/deploying-from-private-git-repositories/

Create Openshift Application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ok, *now* that our keys are all squared away, we can create an
application using a private git repo as our source! Unfortunately,
there's currently no way to use the :code:`oc new-app` command
directly to build an image from a private repo. What we'll do instead
is create an `application template`_ that includes the necessary
secret and use that template to create our app.  

* Create a template for our git repo using the new-app command

  .. code-block:: none

      oc new-app ssh://git@github.com:mygituser/mygitrepo --name app-name -o json >> my-template.json

* Open the JSON file and change "List" to "Template", and "items" to "objects". 
* Add a :code:`"name": "my-app-name"` to the :code:`metadata` object

  .. code-block:: none

    "metadata": {"name": "my-app-name"},

* This part is tricky and I'm not sure how best to describe it, but in :code:`"spec": {"source":{}}` object add

  .. code-block:: none

    "sourceSecret": {
        "name": "openshiftkey"
    }

So you should end up with a block that looks like:

  .. code-block:: none

    foo bar baz

`This is what my JSON template ended up looking like`_ (with sensitive
information removed)

.. _This is what my JSON template ended up looking like: https://gist.github.com/lucywyman/145aebfe1897d91d4cd5337e5baa7379

* Create a template based on this json file
 
  .. code-block:: none

    oc create -f my-template.json

* Finally, create an application using the template!
  
  .. code-block:: none

    oc new-app --template app-name

Again, I highly recommend you run :code:`oc new-app -h` first to see if there are any special configurations you want to use.

.. _application template: https://docs.openshift.org/latest/dev_guide/templates.html

Make Sure It Worked
~~~~~~~~~~~~~~~~~~~

Run :code:`oc get builds`, and you should see output similar to this:

.. code-block:: none

    NAME      TYPE      FROM          STATUS     STARTED        DURATION
    my-app1   Source    Git@abcdefg   Complete   18 hours ago   29s


Issues I Ran In To
------------------

The Wrong Git URI
~~~~~~~~~~~~~~~~~

At first I was using the http Git URI, which obviously didn't use
the SSH deploy key. I then tried using
:code:`ssh://git@github.com:my-user/my-repo.git`, which also failed.
:code:`git@github.com:my-user/my-repo.git` is the right URI!

Application Already Exists
~~~~~~~~~~~~~~~~~~~~~~~~~~

Because I had to try building my application several times, I also had
to delete my failed attempts several times so there wouldn't be name
errors. I usually ran the following:

.. code-block:: none

    oc delete services --all
    oc delete deploymentconfig --all
    oc delete buildconfig --all
    oc delete imagestreams --all
    oc delete templates --all

This obviously won't work if you have services you're trying to
preserve, but you can just specify which services etc. to delete.

Resources
---------

* The `Openshift Origin`_ documentation was invaluable in
  troubleshooting various issues I had
* I asked a question in #openshift on irc, and someone answered within
  5 minutes and was very nice and helpful. 
* There's a `Free E-Book`_ (pdf format too) call "Openshift for
  Developer's" that explains more about what Openshift is and how it
  works. This was super helpful for understanding what all of the
  components were, and generally getting started.

.. _Openshift Origin: https://docs.openshift.org/latest/welcome/index.html
.. _Free E-Book: https://openshift.com/promotions/for-developers.html
