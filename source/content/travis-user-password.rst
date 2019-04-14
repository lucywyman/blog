Promting for Sudo Password in Travis
====================================
:date: 04-13-2019
:tags: tech
:category: Tech
:slug: prompting-for-sudo-in-travis
:author: Lucy Wyman
:img: travis.png

"Lucy, why would you want to do this? ARE YOU OK?"
It's true: making Travis print the sudo prompt and enter it's password
is not a common use case. We were testing a new feature in `Bolt`_
which opens a subprocess on the local machine and runs a command as a
different user (`code`_, `docs`_). We like to have as many tests in
Travis so that our users and contributors see if their own code breaks
tests (as opposed to our acceptance tests which run nightly in
Jenkins). So, to test this properly in Travis, I needed to make the
:code:`travis` user be prompted for sudo.

I initially tried creating a different user and running the test as
that user, so that I didn't have to mess with the sudo configuration
of :code:`travis`. This turned out to be more difficult than
expected, since switching the user opens a new login which stops the
tests from running.

So, we were stuck with :code:`travis`. Here's the magic lines I added
to the 'before_script' section of :code:`.travis.yml`:

.. code-block:: yaml

    - echo 'travis:travis' | sudo chpasswd
    - sudo sh -c "echo 'Defaults authenticate' >> /etc/sudoers"
    - sudo sh -c "echo 'travis  ALL=(ALL) PASSWD:ALL' >> /etc/sudoers"

By default Travis sets :code:`Defaults !authenticate` and
:code:`travis ALL=(ALL) NOPASSWD:ALL` in
:code:`/etc/sudoers.d/travis`. The first thing we needed to do was
give :code:`travis` a password so that we could still authenticate,
then undo this sudo config. Also worth noting: you must set the
:code:`NOPASSWD` line last, otherwise you won't be able to use sudo to
modify the sudo config!

Et voila! We can test prompting for a sudo password in Travis.

.. _Bolt: https://puppet.com/docs/bolt/
.. _code: https://github.com/puppetlabs/bolt/blob/master/lib/bolt/transport/local/shell.rb#L29-L45
.. _docs: https://puppet.com/docs/bolt/latest/bolt_configuration_options.html#local-transport-configuration-options
