Puppet Orchestrator --application Example
=========================================
:date: 2016-10-26
:tags: tech, puppet, application, orchestrator, flag, example
:category: Tech
:slug: puppet-orchestrator-application-flag
:author: Lucy Wyman

As always, this technical blog post began when I was having a problem
and couldn't find the answer on the internet.  I'm writing tests for
Puppet's `application orchestrator`_ which involve setting up an
application remotely then running some variations of :code:`puppet job
run`.  In particular, I need to specify an environment (:code:`-e or
--environment`) and an application instance (:code:`-a or
--application`). 

Here's my directory structure:

.. code::

    [root@hostname environments]# tree
    .
    ├── production
    │   ├── environment.conf
    │   ├── hieradata
    │   ├── manifests
    │   │   └── site.pp
    │   └── modules
    └── tmpenv
        ├── manifests
        │   └── site.pp
        └── modules
            ├── app_one
            │   ├── manifests
            │   │   ├── db_component.pp
            │   │   ├── init.pp
            │   │   └── web_component.pp
            │   └── README.md
            ├── README.md
            └── shared_types_and_providers
                └── lib
                    └── puppet
                        ├── provider
                        │   ├── testhttp
                        │   │   └── test_file.rb
                        │   └── testsql
                        │       └── test_file.rb
                        └── type
                            ├── testhttp.rb
                            └── testsql.rb

And the output of running :code:`puppet app show -e tmpenv` is:

.. code::

    App_one[Health Check Test]
        App_one::Db_component[Health Check Test] => y21898u9zb3yin5.delivery.puppetlabs.net
            + produces Testsql[Health Check Test]
        App_one::Web_component[Health Check Test] => hzmjunpoua0mxeo.delivery.puppetlabs.net
            consumes Testsql[Health Check Test]


Ok, so, as I see it there are 2 strong candidates for what the
"<APPLICATION>" referred to in the `puppet orchestrator
documentation`_ could be: **app_one** or **App_one[Health Check
Test]**. Here's the output for each of those (using puppet job plan so
that I'm not creating new job id's and logs all over the place):

.. code::

    [root@hostname environments]# puppet job plan -e tmpenv -a app_one
    Failed to submit plan: puppetlabs.orchestrator/unknown-target: The target was not found in environment tmpenv: app_one

    [root@hostname environments]# puppet job plan -e tmpenv -a App_one[Health Check Test]
    terminate called after throwing an instance of 'HorseWhisperer::action_validation_error' what():  Validation Error: You supplied too many arguments to the run command. Only 1 is allowed.
      Aborted

In desperation, I decide to try a combination of the two **App_one**.

.. code::

    [root@hostname environments]# puppet job plan -e tmpenv -a
    App_one
    +-------------------+---------+
    | Environment       | tmpenv  |
    | Target            | App_one |
    | Concurrency Limit | None    |
    | Nodes             | 2       |
    +-------------------+---------+

    Application instances: 1
      - App_one[Health Check Test]

    Node run order (nodes in level 0 run before their dependent nodes in
    level 1, etc.):
    0 -----------------------------------------------------------------------
    y21898u9zb3yin5.delivery.puppetlabs.net
        App_one[Health Check Test] - App_one::Db_component[Health Check
        Test]

    1 -----------------------------------------------------------------------
    hzmjunpoua0mxeo.delivery.puppetlabs.net
        App_one[Health Check Test] - App_one::Web_component[Health
        Check Test]

    Use `puppet job run --application 'App_one' --environment
    tmpenv` to create and run a job like this.
    Node catalogs may have changed since this plan was
    generated.

Success!  I later discovered that :code:`puppet job plan -e tmpenv -a
"App_one[Health Check Test]"` also worked.  It's still unclear to me
why the name needs be capitalized, but I trust that there are good and
well thought out Reasons which just aren't documented.

So, if you don't know, now you know :)

.. _application orchestrator: https://docs.puppet.com/pe/latest/app_orchestration_overview.html
.. _puppet orchestrator documentation: https://docs.puppet.com/pe/latest/orchestrator_job_run.html
