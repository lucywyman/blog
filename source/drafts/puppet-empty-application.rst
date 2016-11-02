Bare Bones Puppet Application
=============================
:date: 2016-10-20
:tags: tech, puppet, application, minimal
:category: Tech
:slug: bare-puppet-application
:author: Lucy Wyman

So I was testing Puppet using Puppet, and needed a bare bones
application with a fancy unicode name. But I didn't want the
application to actually *do* anything, I just needed it to be as
minimal as possible, while still guaranteed to run if it had an ascii
name (so that I would know if a failure was due to the unicode name).
What does a minimal application even look like in Puppet, though?  I
found lots of great tutorials for beginner applications, explaining
the concepts of Puppet and setting up web servers or load balancers or
whatnot as simply as possible.  But that wasn't what I needed.  I
needed minimal. Empty. Bare bones.

In puppet, application orchestration is just a way of defining
relationships between components of an application and ordering (or
orchestrating) the order in which they are set up. For example, if I
have a basic web application that has a database I need that database
to exist and be ready to rock & roll before bringing up my web
application.  These relationships are defined in the :code:`site.pp`
file, which for a bare bones app we want to be at 
:code:`/etc/puppetlabs/code/environments/production/manifests/site.pp`.
The components themselves are defined in a module, located at
`/etc/puppetlabs/code/environments/production/modules/`. Ok, so what
do these files look like?  Well, since we don't actually need the
application to *do* anything, we only need to use the :code:`site.pp`
file.  Mine looks like this:

.. code:: puppet

    node default {
        file { '/tmp/mylittlepony':
            ensure => present
        }
    }

I included the file so that I could verify that the application had
actually worked, and put 
