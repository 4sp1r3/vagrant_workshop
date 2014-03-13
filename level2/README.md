Level 2: Network config, forwarding ports, provision, plugins and fun!
----------------------------------------------------------------------
In Vagrantfile:

1. Setup 1 port forward
2. Setup an internal static ip
3. Set hostname
4. install vagrant cachier, review purpose

  vagrant plugin install vagrant-cachier

5. install hostmanager

  vagrant plugin install vagrant-hostmanager

6. setup changes in the local /etc/hosts
7. provision, types of provision puppet, chef, ansible, shell script
8. install vagrant-vbox-snapshot  

  vagrant plugin install vagrant-vbox-snapshot

Start the VM

  vagrant up

Diferences between: vagrant up and vagrant up --no-provision and vagrant provision

Lists of plugins: https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins
Recommended plugins:
* https://github.com/pradels/vagrant-libvirt
* https://github.com/WinRB/vagrant-windows (i didn't use it YET! IE??VM environment?)
* https://github.com/mitchellh/vagrant-aws
* https://github.com/fgrehm/vagrant-lxc (tested, works but need some hacking in the net config)


