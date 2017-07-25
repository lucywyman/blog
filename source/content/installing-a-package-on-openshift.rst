Installing a Package in an Openshift Container (Kind Of)
========================================================
:date: 2017-07-25
:tags: tech, Openshift
:category: Tech
:slug: installing-a-package-in-an-openshift-container
:author: Lucy Wyman
:image:

**TODO Better title. Ping me with ideas!**

Fair warning: This article assumes that you have a decent
understanding of Openshift from the outset, because explaining all the
concepts used here would take too much space. I'll try to link to
resources where applicable though, so that words don't go undefined.

The typical happy path for using `Openshift`_ is to use it's `Source
to Image (s2i)`_ builder to take a `git repo`_ or `dockerfile`_ and
turn it into a container running on Openshift. In general, this works
just fine. The s2i builder `detects which language your app is using`_
and deploys that application appropriately, including starting the
webserver. However, if your project needs more dependencies than
Openshift expects, it's very difficult to add those dependencies to
the container. For good reason, your user in the container is pretty
neutered, which means installing a package is impossible.  And you
don't have access to the processes that are installing dependencies
for your application, since those come from the default (probably
CentOS or RHEL) base image that Openshift uses. So, what do you need
if you need to install a package in your container? We'll explain!

In short, you'll need to:

1. Copy the s2i builder that your application is using (based on it's language)
2. Modify it as necessary for your application
3. Create a new application in Openshift that uses your Dockerfile to create an image
4. Create your "real" application in Openshift, using the image you just created as a base and the Source strategy

We'll go through it step by step!

.. _Openshift: http://docs.openshift.org/
.. _Source to Image (s2i): https://docs.openshift.org/latest/architecture/core_concepts/builds_and_image_streams.html#source-build
.. _git repo: https://docs.openshift.com/enterprise/3.2/dev_guide/builds.html#source-code
.. _dockerfile: https://docs.openshift.com/enterprise/3.2/dev_guide/builds.html#dockerfile-source
.. _detects which language your app is using: https://docs.Openshift.com/enterprise/3.1/dev_guide/new_app.html#language-detection

Copy the Default S2I Builder
----------------------------

The best way to find the s2i builder your application will need is to
reference the `Openshift S2I documentation`_, find the language your
application is in, and then in the first paragraph there should be a
link to the git repo where the default s2i builder for that language
lives. 

.. figure:: static/Openshift-s2i-docs.png

Searching for 'Openshift $LANG S2I builder'
also usually resulted in the first hit being the "official" s2i
builder, but the git repos don't make that clear so going through the
documentation should give you a little more certainty you found the
right one.

I personally cloned the whole repo, then copied the relevant files into a
subdirectory of my application so that everything I needed was
packaged together. Later on, this will make things a little easier. If you'd rather separate your concerns though, you
can also fork + download + modify the s2i builder and keep it separate
from your application.

Here's what my application directory ended up looking like, where everything
under :code:`openshift-build` is copied from the `Openshift ruby s2i`_ repo.

.. code:: 

    .
    ├── app.rb
    ├── config.ru
    ├── Gemfile
    ├── helpers
    │   └── helpers.rb
    ├── openshift-build
    │   ├── cccp.yml
    │   ├── Dockerfile
    │   ├── root
    │   │   └── opt
    │   │       └── app-root
    │   │           └── etc
    │   │               ├── generate_container_user
    │   │               ├── puma.cfg
    │   │               └── scl_enable
    │   ├── s2i
    │   │   └── bin
    │   │       ├── assemble
    │   │       ├── run
    │   │       └── usage
    │   └── test
    │       ├── puma-test-app
    │       │   ├── app.rb
    │       │   ├── config.ru
    │       │   ├── Gemfile
    │       │   └── Gemfile.lock
    │       ├── rack-test-app
    │       │   ├── app.rb
    │       │   ├── config.ru
    │       │   ├── Gemfile
    │       │   └── Gemfile.lock
    │       └── run
    ├── public
    │   └── images
    │       └── approval.gif
    ├── README.md
    ├── spec
    │   └── kukla
    │       ├── helper_spec.rb
    │       └── kukla_spec.rb
    └── views
        └── index.erb

**Key to Success**: Make sure you include everything in the :code:`s2i` and
:code:`root` directories from the default s2i builder! These files are
necessary for building your first image later on.

.. _Openshift S2I documentation: https://docs.Openshift.org/latest/using_images/s2i_images/ruby.html
.. _Openshift ruby s2i: https://github.com/sclorg/s2i-ruby-container/

Modify As Necessary
-------------------

I was trying to trick Git into thinking I had a user on Openshift, so
that I could clone some dependencies for my application. I also needed
`npm`_ for Reasons. I looked at the `nodejs s2i builder`_, which uses
`nss_wrapper`_ to achieve the Git-trick, and just copy-pasted the
important bits (apologies that the application isn't open source so I
can just reference it):

.. code-block:: none

    <     INSTALL_PKGS="rh-ruby24 rh-ruby24-ruby-devel rh-ruby24-rubygem-rake rh-ruby24-rubygem-bundler rh-nodejs6 rh-nodejs6-npm nss_wrapper" && \
    ---
    >     INSTALL_PKGS="rh-ruby24 rh-ruby24-ruby-devel rh-ruby24-rubygem-rake rh-ruby24-rubygem-bundler rh-nodejs6" && \

I also added `this file`_ from the nodejs builder to :code:`$APP_ROOT/openshift-build/root/opt/app-root/etc` so that my application could use nss_wrapper.

.. _npm: https://www.npmjs.com/ 
.. _nodejs s2i builder: https://github.com/sclorg/s2i-nodejs-container
.. _nss_wrapper: https://cwrap.org/nss_wrapper.html
.. _this file: https://github.com/sclorg/s2i-nodejs-container/blob/master/4/root/opt/app-root/etc/generate_container_user

Create Application from Dockerfile
----------------------------------

The next step is to create an image in the `Openshift internal
repository`_ from our special S2I build. This will be the base
image for our application, instead of the default Openshift builder
image. I personally found this a little bit easier to do in the UI
than on the CLI, but will explain both.

The key when you create this application is to use the `Docker source
strategy`_ using the Dockerfile (and all the other files!) you copied
from the default s2i builder. This is where it comes in handy to have
those files inside your application: if you point Openshift to where
those files are (:code:`spec.strategy.dockerStrategy.dockerfilePath`
in the buildConfig), Openshift will use that for it's Docker build
strategy. As I describe in `this blog post`_, it's difficult to create
a new application using your own buildConfig. I didn't feel like
messing with templates at this point, so I just:

* Created an application using the default image for ruby
* Edited the buildConfig
* Rebuilt the application. 
  
Here's how it went down:

**Note**: I recommend naming this first application 'myapp-builder',
or something along those lines.

In the CLI
~~~~~~~~~~

1. Run :code:`oc new-app <appropriate configurations>`. As previously mentioned, Openshift will detect the language your application is in and use that default image. I highly recommend running :code:`oc new-app --help` to see if there are any other options you'd like to use!
2. Run :code:`oc edit bc/myapp-builder` and modify the strategy section of the buildConfig to have the following:

.. code:: 
    
    strategy:
      type: Docker
      dockerStrategy:
        dockerfilePath: openshift-build/Dockerfile
        env:
          - name: MYVAR
            value: my_value

3. Close and save the buildconfig.
4. Run :code:`oc start-build myapp-builder`

In the UI
~~~~~~~~~

**Note: I believe the UI workflow only works if your file source is Github, not a Docker image**

1. Click 'Add to Project' in the header navigation

.. figure:: static/add-project.png

2. Select the language (and version, etc.) your app is in
3. Fill out the application details appropriately. There's nothing special you need to do on this page.
4. Now that you've created your application, go to 'Builds -> Builds' in the left navigation
5. Select the application you just created
6. In the top right, select 'Actions -> Edit Yaml'
7. Modify your buildConfig to use the Docker source strategy. The key changes here are under the :code:`strategy` section. You should end up with something that looks like this:

.. code::

    strategy:
      type: Docker
      dockerStrategy:
        dockerfilePath: openshift-build/Dockerfile
        env:
          - name: MYVAR
            value: my_value

Then save the config
8. In the top-right corner, click 'Start Build'

And you're done! The resulting image will be published to the internal container registry with the label 'app-name:latest'.

.. _this blog post: http://blog.lucywyman.me/deploy-private-git-repo-to-openshift.html
.. _Docker source strategy: https://docs.openshift.com/enterprise/3.2/dev_guide/builds.html#docker-strategy-options
.. _Openshift internal repository: https://docs.openshift.com/container-platform/3.3/dev_guide/managing_images.html#accessing-the-internal-registry


Create Application from Source, Using Image
-------------------------------------------

The final step, creating our application image from the image we just
created! The key when creating this application is to use the `source
strategy`_ with **your image** as the
:code:`source.strategy.sourceStrategy.name` value. This should be the
name of the application you just created. The steps for creating this
application are more or less the same as they were in the previous
step:

* Create an application using the default image in your language
* Edit the buildConfig
* Rebuild the application

You can follow the same steps enumerated above for the preferred
interface, and here's roughly what your buildConfig should look like
when you're finished:

.. code::

    strategy:
      sourceStrategy:
        env:
        - name: MYVAR
          value: my_value
        from:
          kind: ImageStreamTag
          name: myapp-builder:latest

That last line being the critical point! Make sure you're referencing your builder image. 

And there you have it! Once you've rebuilt your application, you're
all set.

.. _source strategy: https://docs.openshift.com/enterprise/3.2/dev_guide/builds.html#source-to-image-strategy-options

Making Changes
--------------

If you make changes to *your application*, you only need to rebuild
the application, not the application builder. However, if you make
changes to your Dockerfile or any other part of the underlying image
(say you need another package installed), then you will need to
rebuild the app-builder image *and* your application. 

Resources
---------

Openshift is in an interesting place developmentally, where they have
pretty good documentation, relatively mature technology, and awesome
tech support on IRC, but almost no community documentation (think blog
posts, stack overflow questions, etc.). I would often find myself
reading a post from the Openshift blog that was published in 2013, and
hope it was still relevant, or be looking through github issues and
irc logs for answers. But, there were still a number of resources I
found very helpful through this journey:

* First, I *highly* recommend asking any questions in #openshift
  (irc.freenode.net). Folks were kind, quick to respond, super
  helpful.
* The `Openshift book`_ is a great resource if you have the time. I would suggest only reading the first 1/3 of it or so to understand core concepts, then starting your own project.
* `This doc <https://docs.openshift.com/enterprise/3.2/dev_guide/builds.html>`_ is the best "Everything you need to know about Openshift builds" documentation
* `This <https://blog.openshift.com/create-s2i-builder-image/>`_ is a
  pretty good resource on the anatomy of an s2i builder, though
  definitely isn't required reading for this post. 

.. _Openshift book: https://www.openshift.com/promotions/for-developers.html
