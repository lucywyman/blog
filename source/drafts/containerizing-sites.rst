Containerizing Multiple Static Sites on a Droplet
=================================================
:date: 2017-07-20
:tags: tech, containers, websites, docker
:category: Tech
:slug: containerizing-multiple-static-sites-on-a-droplet
:author: Lucy Wyman
:image:

Hello fearless reader! Because I'm giving a talk on puppetizing your container infrastructure `at puppetconf`_, I thought that hosting my `various`_ `static`_ `sites`_ on such an infrastructure was a good way to gain practical knowledge (and waaaaaaay overengineer a solution to a simple problem). As such, I'll be working up to having a `puppetized`_ `Kubernetes`_ cluster running on a `CoreOS`_ `Digital Ocean droplet`_. And because I'm cheap, hopefully I can run all of my sites on just one droplet. 

Since I have relatively little system administration experience, I wanted to start small and work my way up to this project. As such I'm going to containerize my sites on a single DO droplet using `docker compose`_ to begin, to try to iron out any problems with containers in general. Here's how I did it!


