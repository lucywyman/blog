Running Weechat in a Screen Session in a Container
==================================================
:date: 2017-07-10
:tags: tech, docker, containers
:category: Tech
:slug: running-weechat-in-a-screen-session-in-a-container
:author: Lucy Wyman
:image:

Hello! I currently have `Weechat`_ (an irc client) running in a `Digital Ocean droplet`_ screen session, so that `my irc is persistent`_. In an effort to learn more about containers and familiarize myself with Docker, I thought I would try to "containerize" my irc session. And further, since I hope future me can use this information and since I wasn't sure if I even could run a screen session in a container to begin with, I thought I'd write about the experience!

.. _Weechat: http://lug.oregonstate.edu/blog/weechat-intro/
.. _Digital Ocean droplet: https://wp-dreams.com/articles/2015/01/droplet-setup-beginners-guide-to-digital-ocean/
.. _my irc is persistent: http://lug.oregonstate.edu/blog/irc/

Doing The Thing
---------------

Since I've had this droplet for about a year now and have neglected to update it (woops), step 0 was to update my Ubuntu 16.04 droplet.

.. code-block:: none

    sudo apt-get update
    sudo apt-get upgrade

The next thing I wanted to do was write a `Dockerfile`_ that would:
1. Install weechat and screen
2. Add a non-root user and use that user
3. Copy my weechat config files
4. Start a screen session with weechat inside it

After a few (but honestly not too many) rounds of trial + error, I ended up with this:

.. code-block:: none

    FROM ubuntu
    # Update base image
    RUN apt-get update && apt-get -y upgrade
    RUN apt-get -y install screen weechat weechat-scripts
    # Add user
    RUN adduser --disabled-login --gecos '' irc-user
    USER irc-user
    WORKDIR /home/irc-user
    # Copy weechat configuration
    COPY .weechat ~
    # Start screen session with weechat in it
    RUN screen -mdS irc weechat

Now that I had defined what my container should be doing, 

Resources
---------

- `Intro to Weechat`_
- `Screen wiki`_
