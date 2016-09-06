Openstack Image Default Username Reference
==========================================
:date: 2016-09-06
:tags: tech, openstack
:category: Tech
:slug: openstack-image-default-username-reference
:author: Lucy Wyman

This seems like something that should exist on the internet and kind of
doesn't (or should at least be more searchable). These are only valid if you
obtain an official image from the respective projects repository, and may or
may not be the same if you use a manual image.

=======================  ===================
Image                    Default Username
=======================  ===================
centos_(6|7)_x86_64      centos
cirros_0.3.[0-4]_x86_64  cirros
debian_8.2.0_x86_64      debian
ubuntu_1(4|6).04_x86_64  ubuntu
fedora_23_x86_64         fedora
rhel_7.2_x86_64          cloud-user (snowflake much?)
=======================  ===================


If you're still not sure, I tend to find which user Openstack wants me to use by trying to login to the instance as root, and get a message similar to:
``
Please login as the user "cloud-user" rather than the user "root".
Connection to 10.32.161.253 closed.
``

Source: http://docs.openstack.org/image-guide/obtain-images.html
