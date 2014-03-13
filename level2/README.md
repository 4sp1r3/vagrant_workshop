Level 2: Network config, forwarding ports, provision, plugins and fun!
----------------------------------------------------------------------
In Vagrantfile:
    - Setup 1 port forward
    - Setup an internal static ip
    - Set hostname
    - install vagrant cachier, review purpose
    vagrant plugin install vagrant-cachier
    - install hostmanager
    vagrant plugin install vagrant-hostmanager
    - setup changes in the local /etc/hosts
    - provision, types of provision puppet, chef, ansible, shell script
    vagrant plugin install vagrant-vbox-snapshot

    - vagrant up
    - vagrant up --no-provision
    - vagrant provision

- lists of lots of plugins: https://github.com/mitchellh/vagrant/wiki/Available-Vagrant-Plugins
- Recommended plugins:
    -   https://github.com/pradels/vagrant-libvirt
    -   https://github.com/WinRB/vagrant-windows (i didn't use it YET! IE??VM environment?)
    -   https://github.com/mitchellh/vagrant-aws
    -   https://github.com/fgrehm/vagrant-lxc (tested, works but need some hacking in the net config)
