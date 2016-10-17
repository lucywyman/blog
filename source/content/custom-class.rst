Minimal Programmatic Puppet Class Creation
==========================================
:date: 2016-10-13
:tags: tech, puppet
:category: Tech
:slug: programmatic-class-creation
:author: Lucy Wyman
:img:

This post began when I was trying to programmatically create my own
Puppet class, googled this exact title, and came up totally empty
handed. After wading through dozens of StackOverflow posts and puppet
docs, I still wasn't sure what I needed to accomplish this or how it
would fit into our Beaker tests. I admittedly don't have much
experience with Puppet, and ended up spending a few hours with a
coworker learning about the most efficient way to achieve this.  This
is essentially the post I wish I had found a week ago (or will wish
existed 6 months from now when I need to do the same thing and have
forgotten all of this). 

**WARNING**: This post is for n00bs, not l33t
puppet haxxors.  You've been warned.

**OTHER WARNING**: This post assumes that you already have a
remote puppet master, and are most likely using Beaker or some other
testing harness to interact with that master. You'll also need to make
sure $test_harness has root privileges on the master, as you'll be
writing to :code:`/etc`.

The Endgame
-----------

Specifically, I wanted to ensure that a UTF-8 encoded class (with non
:code:`\A[a-z][a-z0-9_]*\Z` characters) would not be displayed in the
Puppet Enterprise GUI (per `Puppet's acceptable character specs`_).  I
needed a bare module with a single class that I could programmatically
throw at a master, and then verify had successfully been applied.

The Solution(s)
---------------

Since it's impossible to verify that the unicode isn't showing up
because it's unicode, and not because I goofed on adding the class
(yeah, yeah, our logging could be improved), I first needed to get
this test working with a kosher name. 

Files
~~~~~

Ok, so really the crux of this problems is what files you need, and
where they need to go on your system.  Since this requires just *the one
class*, and none of the other infra around puppetized applications,
only a simple :code:`init.pp` is necessary.  Mine looks like this:

.. code:: puppet

    class myclass {
      file { '/tmp/make_sure_this_exists':
        ensure => present
      }
    }

A few important notes:

* No trailing whitespace! Anywhere!
* 2 spaces, not tab characters
* Single quotes

There are `more official style guideline`_, and even a
`puppet-linter`_ you can use to verify your :code:`init.pp` is
correct. 

Ok, so we've got this file, where does it go on the master?  As far as
I can tell most Puppet-y things that we humans deal with live in
:code:`/etc/puppetlabs/code/environments`, and since we're taking the
easy road here we're going to be working in the :code:`production`
environment. Before you do anything that directory should look
something like this:

.. code:: 

    .
    └── production
        ├── environment.conf
        ├── hieradata
        ├── manifests
        │   └── site.pp
        └── modules

**Modules** is going to be the directory we need to work with.  A
puppet module is a self-contained bundle of code you use to tell
puppet some part of how you want your system to look. There are huge,
widely used puppet modules such as `Apache`_, or there are cute little
5-line modules like ours, and both specify various related aspects of
a system state to achieve a goal.  That's as much as I'll say about
modules, but you can `read more here`_ if interested.  

**NOTE**: In order for agents to be classified by this class, it needs
to go on the master.  This might not be strictly true all of the time,
but it definitely wasn't going to show up in the GUI or get applied to
agents from another agent. 

Doing the Thing Manually
~~~~~~~~~~~~~~~~~~~~~~~~

1. **Make the directory**. To make our module, we'll need to make the
   following directory from the :code:`production` directory:

    .. code::

        mkdir -p modules/myclass/manifests`

    where :code:`myclass` matches the class name you have in your
    :code:`init.pp`. 
2. **Copy the file**. Then put the :code:`init.pp` in that directory,
   and your set! 
3. **Verify it worked**. There are a few ways to verify that you were
   successful:

    * SSH into the master, run :code:`puppet agent -t`, then SSH into your
      agent and verify that the file :code:`/tmp/make_sure_this_exists`
      does indeed exist
    * In the GUI, head to Nodes > Classification, create a new group, then
      go to $node_group_page > classes tab and verify your class is in the
      dropdown for adding a class.

Automate it
-----------

So now that we know what we're doing, automating it with Beaker is
pretty easy, especially if we're working in the production
environment.

1. **Make the directory**.

   .. code:: ruby

       @class_name = 'classy'
       @modules_path = "/etc/puppetlabs/code/environments/production/modules/#{@class_name}/manifests"
       on(master, "mkdir -p #{@modules_path}")

2. **Copy the file**. Please note, I needed to define my
   :code:`init.pp` content inside the file for reasons, but you can
   also have a local file and use ruby to read from it, which is a
   little more best-practice-y. Also note that you'll need to give the
   file proper permissions once you've made it!

   .. code:: ruby

           manifest =<<-EOS
         class #{@class_name} {
           file { '/tmp/make_sure_this_exists':
             ensure => present
           }
         }
           EOS
           create_remote_file(master,"#{@modules_path}/init.pp", manifest)
           on(master, "chmod 644 #{@modules_path}/init.pp")

3. **Verify that it worked**.

   .. code:: ruby

       on(master, 'puppet agent -t')
       agent = agents.find {|agent| not_controller agent}
       ls_output = on(agent, 'ls /tmp/make_sure_this_exists').stdout
       assert_equal(ls_output, '/tmp/make_sure_this_exists', error_message)

There are lots of ways to verify that it worked, this runs
:code:`puppet agent -t` on the master (which compiles the catalog and
applies it to all the agents), then verifies that the output of 'ls'
on the master includes the file our class put there.

Conclusion
----------

Hopefully this was helpful and what you are looking for! This is
really the *bare minimum*, need-to-know-basis level of creating a
custom class, for when you just need to get the thing done and don't
want to learn **All Of Puppet**.  If you do want to learn all of
puppet though, there are some links below!  Enjoy.

Puppet Resources
----------------

* `Learning VM`_
* `Puppet Tutorial`_ slide deck by Alessandro Franceschi
* `Learn Puppet with Vagrant`_ by Justin Weissig
* `Getting Started with Puppet`_ by Pindi Albert

.. _Apache: https://forge.puppet.com/puppetlabs/apache
.. _more official style guideline: https://docs.puppet.com/guides/style_guide.html
.. _puppet-linter: http://puppet-lint.com/
.. _Puppet's acceptable character specs: https://docs.puppet.com/puppet/latest/reference/lang_reserved.html#acceptable-characters-in-names
.. _read more here: https://docs.puppet.com/puppet/latest/reference/modules_fundamentals.html
.. _Learning VM: https://puppet.com/download-learning-vm
.. _Puppet Tutorial: http://www.example42.com/tutorials/PuppetTutorial/#slide-0
.. _Learn Puppet with Vagrant: https://sysadmincasts.com/episodes/8-learning-puppet-with-vagrant
.. _Getting Started with Puppet: http://www.pindi.us/blog/getting-started-puppet
