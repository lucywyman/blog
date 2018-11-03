Managing CoreOS With Puppet
===========================
:date: 2017-10-03
:tags: tech, containers
:category: Tech
:slug: managing-coreos-with-puppet
:author: Lucy Wyman
:img:

Why
---

To be perfectly honest, the only reason I wanted to do this is because I
submitted a talk to `PuppetConf`_ on the subject and it got accepted. Woops.
Way to go past Lucy.

There are a few cases where managing CoreOS with Puppet makes sense though. 

.. _PuppetConf: https://puppet.com/puppetconf

How
---

Here's the basic steps we'll be taking to set up a puppet agent running on
CoreOS, all running in Vagrant (because I'm too cheap to buy cloud space for
this). 

Stand Up Puppet Master and Agent
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first thing I wanted to do was get some basic Puppet infrastructure up that
I could integrate my CoreOS nodes into. I used the following Vagrantfile and
provisioning scripts to get my VMs running.

I also installed the `vagrant-hosts`_ plugin to make sure the VMs could talk to
each other, and minimize the amount of networking voodoo I had to do:
:code:`vagrant plugin install vagrant-hosts`

.. _vagrant-hosts: https://github.com/oscar-stack/vagrant-hosts

.. code::

    $ tree
    .
    ├── puppet-agent-install.sh
    ├── puppet-master-install.sh
    └── Vagrantfile

Vagrantfile
+++++++++++

Configuration file for the virtual machines we'll install puppet master and agents on

.. code:: ruby

  Vagrant.configure("2") do |config|
    config.vm.define "puppetmaster" do |master|
      master.vm.box = "ubuntu/xenial64"
      master.vm.hostname = "puppet-master"
      master.vm.network :"private_network", ip: "10.20.1.80"
      master.vm.provision :hosts, :sync_hosts => true
      master.vm.provision "shell", path: "puppet-master-install.sh"
      master.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "4096"]
      end
    end

    config.vm.define "puppetagent" do |agent|
      agent.vm.box = "centos/7"
      agent.vm.hostname = "puppet-agent"
      agent.vm.network :"private_network", ip: "10.20.1.81"
      agent.vm.provision :hosts, :sync_hosts => true
      agent.vm.provision "shell", path: "puppet-agent-install.sh"    
    end
  end

puppet-master-install.sh
++++++++++++++++++++++++

Provisioning script for the vagrant VM with puppet master on it

.. code:: bash

  #!/bin/bash

  if ps aux | grep "puppet" | grep -v grep 2> /dev/null
  then
    echo "Puppet Master is already installed. Exiting..."
  else
    # Install puppet master
    wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
    sudo dpkg -i puppetlabs-release-pc1-xenial.deb
    sudo apt-get -yq update
    sudo apt-get -yq install puppetserver
    #sudo apt-get -yq install puppet
    sudo service puppetserver start

    # Configure /etc/hosts file
    echo "# Host config for Puppet Master and Agent Nodes
    192.168.33.10   puppet-master puppet-master
    192.168.33.11   puppet-agent puppet-agent" >> /etc/hosts

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    sudo echo "
    [main]
    dns_alt_names = puppet,puppet-master" >> /etc/puppetlabs/puppet/puppet.conf
  fi

puppet-agent-install.sh
+++++++++++++++++++++++

Provisioning script for the vagrant VM with puppet agent on it

.. code:: bash

  #!/bin/bash

  if ps aux | grep "puppet" | grep -v grep 2> /dev/null
  then
    echo "Puppet Agent is already installed. Moving on..."
  else
    # Install puppet agent 
    sudo rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    sudo yum install -y puppet-agent
    sudo /opt/puppetlabs/bin/puppet resource service puppet ensure=running enable=true

    # Configure /etc/hosts file
    sudo echo "# Host config for Puppet Master and Agent Nodes
    192.168.33.10   puppet-master puppet-master
    192.168.33.11   puppet-agent puppet-agent" >> /etc/hosts

    # Add optional alternate DNS names to /etc/puppet/puppet.conf
    sudo echo "[agent]
    server=puppet-master" >> /etc/puppetlabs/puppet/puppet.conf

    sudo /opt/puppetlabs/bin/puppet agent --enable
  fi

Once everything is in place, we'll start up the VMs:

.. code:: 
    
    vagrant up

And run puppet on the agent and master

.. code:: 

    vagrant ssh puppetagent
    sudo su -
    puppet agent -t
    exit && exit
    vagrant ssh puppetmaster
    sudo su -
    puppet agent -t
    puppet cert list --all
    puppet cert sign --all

Create CoreOS Agent Node
~~~~~~~~~~~~~~~~~~~~~~~~

The next step is to integrate a `CoreOS`_ node running `puppet agent`_ in a
container into our puppet infrastructure. This involves a lot of changes, so
let's break it down:

.. _CoreOS: https://coreos.com/
.. _puppet agent: https://docs.puppet.com/puppet/latest/about_agent.html

Add the following block to your Vagrantfile in the 'config' block

.. code:: ruby

    config.vm.define "coreosagent" do \|agent\|
      agent.ssh.insert_key = false
      agent.ssh.forward_agent = true
      agent.vm.box = "coreos-beta"
      agent.vm.box_url = "https://storage.googleapis.com/beta.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json"
      agent.vm.hostname = "coreos-agent"

      agent.vm.provider :virtualbox do \|v\| 
        # On VirtualBox, we don't have guest additions or functional vboxsf
        # in CoreOS, so tell Vagrant that so it can be smarter.
        v.check_guest_additions = false
        v.functional_vboxsf = false
        v.memory = 2048
        v.cpus = 1 
        v.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
      end 

      agent.vm.network :private_network, ip: "10.20.1.82"
      agent.vm.provision :hosts, :sync_hosts => true

      if File.exist?(CLOUD_CONFIG_PATH)
        agent.vm.provision :file, :source => "#{CLOUD_CONFIG_PATH}", :destination => "/tmp/vagrantfile-user-data"
        agent.vm.provision :shell, :inline => "mv /tmp/vagrantfile-user-data /var/lib/coreos-vagrant/", :privileged => true
      end
    end

You'll also need the following in a file called :code:`config.rb`

.. code:: ruby

  #Size of the CoreOS cluster created by Vagrant
  $num_instances=1
  # Used to fetch a new discovery token for a cluster of size $num_instances
  $new_discovery_url="https://discovery.etcd.io/new?size=#{$num_instances}"
  # Official CoreOS channel from which updates should be downloaded
  $update_channel='beta'

  # Automatically replace the discovery token on 'vagrant up'

  if File.exists?('user-data') && ARGV[0].eql?('up')
    require 'open-uri'
    require 'yaml'

    token = open($new_discovery_url).read

    data = YAML.load(IO.readlines('user-data')[1..-1].join)

    if data.key? 'coreos' and data['coreos'].key? 'etcd'
      data['coreos']['etcd']['discovery'] = token
    end

    if data.key? 'coreos' and data['coreos'].key? 'etcd2'
      data['coreos']['etcd2']['discovery'] = token
    end 

    # Fix for YAML.load() converting reboot-strategy from 'off' to `false`
    if data.key? 'coreos' and data['coreos'].key? 'update' and data['coreos']['update'].key? 'reboot-strategy'
      if data['coreos']['update']['reboot-strategy'] == false
        data['coreos']['update']['reboot-strategy'] = 'off'
      end 
    end 

    yaml = YAML.dump(data)
    File.open('user-data', 'w') { |file| file.write("#cloud-config\n\n#{yaml}") }
  end

And lastly add a :code:`user-data` file (your cloud-config file)

.. code:: 

  #cloud-config

  hostname: coreos-agent

  coreos:
    units:
    - name: puppet.service
      command: start
      content: |
        [Unit]
        Description=Puppet
        After=docker.service
        Requires=docker.service

        [Service]
        TimeoutStartSec=0
        ExecStartPre=-/usr/bin/docker kill puppet1
        ExecStartPre=-/usr/bin/docker rm puppet1
        ExecStartPre=/usr/bin/docker pull puppet/puppet-agent

        [Install]
        WantedBy=multi-user.target

    - name: 00-ens192.network
      runtime: true
      content: |
        [Match]
        Name=ens192

        [Network]
        DNS=10.20.1.82
        Domains=coreos-agent
        Address=10.20.1.82
        Gateway=10.0.2.2

Now we'll get that machine up and running:

.. code:: 

    vagrant up
    vagrant ssh coreosagent

And wham, you're in a coreos machine!

Connecting Agent to Master
~~~~~~~~~~~~~~~~~~~~~~~~~~

The only thing left to do is start our puppet agent container on the CoreOS VM and get it connected to the master. 

Add puppet.conf to agent
++++++++++++++++++++++++

Since our CoreOS machine doesn't know it's a puppet agent yet (or about puppet at all), we need to manually add :code:`/etc/puppetlabs/puppet/puppet.conf` to configure the agent that will run in a docker container. 


Test It Out
-----------

Ok, let's make sure our setup is actually working!

 
Resources
---------

http://www.admintome.com/blog/configure-puppet-on-coreos/
https://coreos.com/os/docs/latest/booting-on-vagrant.html#cloud-config
