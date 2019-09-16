Cloud Provisioning with Terraform and Bolt
==========================================
:date: 01-23-2019
:tags: tech
:category: Tech
:slug: cloud-provisioning-with-terraform-and-bolt
:author: Lucy Wyman
:img:

.. figure:: theme/images/bolt-logo-dark.png
    :align: center
    :height: 200px

**NOTE**: Since writing this, we've added `inventory plugins`_ to Bolt, which allow you to dynamically load inventory from sources like Terraform, PuppetDB, and Azure. I recommend checking out `Tony Green's blog post`_ about using the Terraform plugin.

.. _inventory plugins: https://puppet.com/docs/bolt/latest/inventory_file_v2.html#plugins-and-dynamic-inventory
.. _Tony Green's blog post: https://albatrossflavour.com/2019/05/puppet-bolt-and-terraform/

`Terraform`_ is a cloud provisioning tool that's great at managing
low-level infrastructure components such as compute instances,
storage, and networking. While Terraform is great at creating the
infrastructure you need, it's not great at managing the state of your
resources over time or enforcing certain states. `Nathan Handler`_
described it in a talk at OSCON 2018 as a way to get boxes that you
can then go fill with the users, files, applications, and tools you
need.

.. figure:: theme/images/terraform-all-the-things.jpg
    :align: center
    :height: 400px

    Image from `'Terraform All The Things'`_ by Nathan Handler

.. _'Terraform All The Things': https://www.slideshare.net/NathanHandler/scale-16x-terraform-all-the-things-90277769
.. _Nathan Handler: https://www.slideshare.net/NathanHandler/scale-16x-terraform-all-the-things-90277769
.. _Terraform: https://www.terraform.io/intro/index.html

`Bolt`_ is an open source remote task runner that can run commands,
scripts, and puppet code across your infrastructure with a few
keystrokes. It combines the declarative Puppet language model with
familiar and convenient imperative code, making it easy to learn and
effective for both one-off tasks and long-term configuration
management.

.. _Bolt: https://puppet.com/docs/bolt

I want to demonstrate how powerful using these tools together is, and
how they each enable you quickly get the cloud resources you need and
provision them with minimal setup and code. We'll first create an AWS
EC2 instance with Terraform, the use Bolt to get the IP of the
instance and manage it using Puppet code (with zero Puppet knowledge
required[1]). Let's get started!

**Note:** If you want to follow along or see a more complete example
all my code is available `on github`_.

.. _on github: https://github.com/lucywyman/terraform-provision

Create Cloud Resources with Terraform
-------------------------------------

This step was simple: I followed the `Terraform Getting Started Guide`_ to set up a
t1.micro `EC2`_ instance, then added a few bits and bobs mostly around
ensuring we can SSH into the machine. Here's some key notes and the
code:

- **SSH Key**: We need to make sure there's a way to SSH into the
  boxes we create. I chose to do this with SSH key pairs, but you
  could also just have username + password set.
- **Outputs**: To make it easier to get the IP addresses for the
  instances we create I added an output to produce an array of the IPs
  of the instances. Parsing the default terraform json output in Bolt
  is equivalent.
- **Ubuntu Xenial AMI**: I'm totally new to AWS and wasn't sure how to
  create a user on my new instance, or more importantly whether Puppet
  would work on it. So I just used an ubuntu image instead of the
  usual Amazon Linux one.
- **Security Group**: This adds a security group to allow traffic into
  and out of the node so that we can, y'know, make use of it.

.. _Terraform Getting Started Guide: https://learn.hashicorp.com/terraform/getting-started/install.html
.. _EC2: https://aws.amazon.com/ec2/

**~/terraform-playground/example.tf**

.. code-block:: ruby

    provider "aws" {
      access_key = <ACCESS_KEY>
      secret_key = <SECRET_KEY>
      region     = "us-west-2"
    } 

    # Add a local SSH key
    resource "aws_key_pair" "example" {
      key_name    = "aws_key"
      public_key  = <PUBLIC_KEY>
    }

    # Add a permissive security group
    resource "aws_security_group" "allow_all" {
      name        = "allow_all"
      description = "Allow all inbound traffic"

      ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }

      egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     =
        ["0.0.0.0/0"]
      }
    }

    # Create EC2 instance
    resource "aws_instance" "xenial" {
      ami = "ami-076e276d85f524150"
      instance_type = "t1.micro"
      key_name = "aws_key"
      security_groups = ["allow_all"]
    }

    # Create output for public IPs
    # This is an array in case we create multiple instances, but for
    # now there's just one
    output "public_ips" {
      value = ["${aws_instance.xenial.*.public_ip}"]
    }

Configure Instances with Bolt Plans
-----------------------------------

Now that we've created a box with Terraform, we'll:

* Collect the public IP in a `Bolt Plan`_
* Add it to the `Bolt inventory`_ file so it picks up configuration
* And do anything we want with it - for example, deploy a small webpage

.. _Bolt plan: https://puppet.com/docs/bolt/latest/bolt_running_plans.html
.. _Bolt inventory: https://puppet.com/docs/bolt/latest/inventory_file.html
  
First let's create a Bolt inventory file with configuration that Bolt will
need to connect to the EC2 instance. This inventory includes 1 group
called 'terraform', which defaults to using the `SSH transport`_. It then
`configures`_ the ssh private key, user, and host key check for this
group.

.. _SSH transport: https://puppet.com/docs/bolt/latest/bolt_configuration_options.html#ssh-transport-configuration-options
.. _configures: https://puppet.com/docs/bolt/latest/bolt_configuration_options.html

**~/terraform_provision/inventory.yaml**

.. code-block:: yaml

    groups:
      - name: terraform
        nodes: [] # This will be populated by the Bolt plan
        config:
          transport: ssh
          ssh:
            private-key: ~/.ssh/id_rsa-phraseless
            user: ubuntu
            host-key-check: false

Next we'll write the Bolt plan to run :code:`terraform apply`, collect
the IPs of the instances it creates, and provision those instances.

**~/terraform_provision/plans/init.pp**

.. code-block:: puppet

    plan terraform_provision(String $tf_path) {
      $localhost = get_targets('localhost')

      # Create infrastructure with terraform apply
      run_command("cd ${$tf_path} && terraform apply", $localhost)
      $ip_string = run_command("cd ${$tf_path} && terraform output public_ips",
                                $localhost).map \|$r| { $r['stdout'] }
      $ips = Array($ip_string).map \|$ip| { $ip.strip }

      # Turn IPs into Bolt targets, and add to inventory
      $targets = $ips.map \|$ip| {
        Target.new("${$ip}").add_to_group('terraform')
      }

      # Deploy website
      apply_prep($targets)

      apply($targets, _run_as => 'root') {
        include apache

        file { '/var/www/html/index.html':
          ensure => 'file',
          source => "puppet:///modules/terraform_provision/site.html"
        }
      }

      return $ips
    }

In less than 30 lines of code we've got an apache server up and
running!

A few other files we'll need to support running Bolt:

A bolt configuration file, to tell it where to `find modules`_

**~/terraform_provision/bolt.yaml**

.. code-block:: yaml

    ---
    modulepath: ./modules:~/githubs/modules

.. _find modules: https://puppet.com/docs/bolt/1.x/bolt_configuration_options.html#global-configuration-options

A `Puppetfile`_ with dependencies:

**~/terraform_provision/Puppetfile**

.. code-block:: yaml

    mod 'puppetlabs-apache', '4.0.0'
    mod 'puppetlabs-stdlib', '5.2.0'
    mod 'puppetlabs-concat', '5.2.0'

.. _Puppetfile: https://puppet.com/docs/pe/latest/puppetfile.html

And lastly, an HTML page to serve:

**~/terraform_provision/files/site.html**

.. code-block:: html

    <!DOCTYPE html>
    <body>
      <h1>Hello from Terraform + Bolt!</h1>
    </body>
    </html>

Again, all these files are available in `this git repo`_, with a bit
more verbosity and structure!

.. _this git repo: https://github.com/lucywyman/terraform-provision

Running Bolt
------------

Phew! Now that all our files are in place, here's how easy it is to
deploy our server:

.. code-block:: bash

    $ bolt puppetfile install
    $ bolt plan run terraform_provision \
        -i ~/terraform_provision/inventory.yaml \
        tf_path=~/terraform-playground

And that's it! The plan should output something like:

.. code-block:: bash

  ["34.220.231.46"]

Visit the IP in your browser and check out your new site!

.. figure:: theme/images/index-html.jpg
    :align: center
    :height: 300px

Conclusion
----------

Terraform and Bolt are both great tools with different strengths.
Together they make automating your infrastructure so much easier, and
enable you to easily get resources, then configure and manage them
over time, without too much overhead or learning. This example, while
simple, is just the beginning - so what are you going to build?

[1] If you don't believe me, 6 months ago I took the Puppet
Certification test and got 48%, and I can do this. Really, I mean no
Puppet knowledge!
