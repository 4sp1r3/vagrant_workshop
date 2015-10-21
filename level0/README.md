Level 0: Installing Vagrant + Virtualbox
----------------------------------------

We have to install the latest version of:
    * vagrant from http://www.vagrantup.com/downloads.html (this workshop can be executed on Linux/Windows/Mac)
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

We now have vagrant installed but no Vagrant file, run 'vagrant init'

    edux@epicfail01:~/vagrant_workshop/level0$ vagrant init ubuntu/trusty64
    A `Vagrantfile` has been placed in this directory. You are now
    ready to `vagrant up` your first virtual environment! Please read
    the comments in the Vagrantfile as well as documentation on
    `vagrantup.com` for more information on using Vagrant.

Let's check the Vagrantfile we created...

    cat Vagrantfile
