vagrant_workshop
================

Vagrant workshop for NerdeARla 032014!

This workshop has levels, starting from level 0 to level XX we will explore the features of vagrant starting with basics and ending with a complex scenario.

Level 0: Installing Vagrant + Virtualbox
----------------------------------------

We have to install the latest version of:
    * vagrant from http://www.vagrantup.com/downloads.html (this workshop can be done runned on Linux/Windows/Mac)
    * Virtualbox and VirtualBox Extension Pack from https://www.virtualbox.org/wiki/Downloads

Download/clone this repo in order to get the files/configs/etc to follow this workshop.
    * git clone https://github.com/edux/vagrant_workshop.git
    or
    * wget https://github.com/edux/vagrant_workshop/archive/master.zip (don't forget to unzip it!)

Note: Vagrant can use LXC as provider (https://github.com/fgrehm/vagrant-lxc), however we are using Virtualbox as LXC is obviously not available in Windows/Mac

Test your Vagrant installation, open a console and run:

    edux@epicfail01:~$ vagrant status
    A Vagrant environment is required to run this command. Run `vagrant init`
    to set one up in this directory, or change to a directory with a
    Vagrantfile and try again.

We now have vagrant installed but no Vagrant file, so move to ~/vagrant_workshop/level0 and run 'vagrant init'

    edux@epicfail01:~/vagrant_workshop/level0$ vagrant init
    A `Vagrantfile` has been placed in this directory. You are now
    ready to `vagrant up` your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    `vagrantup.com` for more information on using Vagrant.

Let's check the Vagrantfile we created...

TODO: explicacion del vagrantfile

Level 1: Basics - Vagrant-101
----------------------------------------

Vagrant uses boxes as containers to import and export virtual machines. 

Download 'precise-server-cloudimg-i386-vagrant-disk1.box' to ~/vagrant_workshop/level1

    vagrant box list

Now we import this box to our Vagrant environment (boxes are shared between all Vagrantfiles in the host)

    vagrant box add base precise-server-cloudimg-i386-vagrant-disk1.box
    
    Downloading box from URL: file:/home/edux/vagrant_workshop/level1/precise-server-cloudimg-i386-vagrant-disk1.box
    Extracting box...te: 213M/s, Estimated time remaining: --:--:--)
    Successfully added box 'base' with provider 'virtualbox'!

We check that the box was successfuly imported:

    ~/vagrant_workshop/level1$ vagrant box list
    base (virtualbox)

Let's launch it!

    edux@epicfail01:~/vagrant_workshop/level1$ vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    [default] Importing base box 'base'...
    [default] Matching MAC address for NAT networking...
    [default] Setting the name of the VM...
    [default] Clearing any previously set forwarded ports...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Running 'pre-boot' VM customizations...
    [default] Booting VM...
    [default] Waiting for machine to boot. This may take a few minutes...
    [default] Machine booted and ready!
    [default] The guest additions on this VM do not match the installed version of
    VirtualBox! In most cases this is fine, but in rare cases it can
    prevent things such as shared folders from working properly. If you see
    shared folder errors, please make sure the guest additions within the
    virtual machine match the version of VirtualBox you have installed on
    your host and reload your VM.

    Guest Additions Version: 4.1.12
    VirtualBox Version: 4.3
    [default] Mounting shared folders...
    [default] -- /vagrant

If you open your Virtualbox Manager you can actually see the VM, something like 'level1_default_xxxxxxxxxxxxx_xxxxx'

Changing the default Memory configuration and the headless setting. Virtualbox UI may be usefull in some cases (testing maybe?), if you edit in your Vagrantfile 'vb.gui = true' and powercycle the vm (from vagrant) in the next start you will see the virtualbox window poping out. Also, in the same configuration block there is a line with '--memory' where you can change the memory assignment, running an X server might need much more ram than 256MB.

Edit the Vagrant file, and then halt,up the vm.

    edux@epicfail01:~/vagrant_workshop/level1$ vagrant halt
    [default] Attempting graceful shutdown of VM...
    
    edux@epicfail01:~/vagrant_workshop/level1$ vagrant up
    Bringing machine 'default' up with 'virtualbox' provider...
    [default] Clearing any previously set forwarded ports...
    [default] Clearing any previously set network interfaces...
    [default] Preparing network interfaces based on configuration...
    [default] Forwarding ports...
    [default] -- 22 => 2222 (adapter 1)
    [default] Running 'pre-boot' VM customizations...
    [default] Booting VM...
    [default] Waiting for machine to boot. This may take a few minutes...
    [default] Machine booted and ready!
    [default] The guest additions on this VM do not match the installed version of
    VirtualBox! In most cases this is fine, but in rare cases it can
    prevent things such as shared folders from working properly. If you see
    shared folder errors, please make sure the guest additions within the
    virtual machine match the version of VirtualBox you have installed on
    your host and reload your VM.

    Guest Additions Version: 4.1.12
    VirtualBox Version: 4.3
    [default] Mounting shared folders...
    [default] -- /vagrant
    [default] VM already provisioned. Run `vagrant provision` or use `--provision` to force it

Lets rollback the changes in the Vagrant file, to return the vm to 256Mb with the headless mode on.

Accessing the VM, you can acces the VM through ssh from the host server, just executing 'vagrant ssh'. As Vagrant uses keys the login is passwordless, however the password for the user vagrant is 'vagrant'.

    edux@epicfail01:~/vagrant_workshop/level1$ vagrant ssh
    Welcome to Ubuntu 12.04.4 LTS (GNU/Linux 3.2.0-59-generic i686)

     * Documentation:  https://help.ubuntu.com/

      System information as of Mon Mar 10 02:23:12 UTC 2014

      System load:  0.02              Processes:           64
      Usage of /:   2.6% of 39.37GB   Users logged in:     0
      Memory usage: 11%               IP address for eth0: 10.0.2.15
      Swap usage:   0%

      Graph this data and manage this system at:
        https://landscape.canonical.com/

      Get cloud support with Ubuntu Advantage Cloud Guest:
        http://www.ubuntu.com/business/services/cloud

    0 packages can be updated.
    0 updates are security updates.

    Last login: Sun Mar  9 15:23:23 2014 from 10.0.2.2
    vagrant@vagrant-ubuntu-precise-32:~$ 


To recap, the basic cycle of a vagrant vm is init,up,halt|suspend,destroy



Level 2: Network config, forwarding ports, some cool plugins.
-----------------------------------------------
- Setup some natted ports for apache
- use the hostmanager plugin to setup the hostname in the local pc and remote


Level 3: Provision, run provision scripts on a vm
-------------------------------------------------
- install a simple database and import some data.


Level 4: Multi-vm, multi-provision
----------------------------------
- install master-slave mysql with some frontend application using shares