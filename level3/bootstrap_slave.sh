#!/usr/bin/env bash


#if [ -d "/opt/iatsreqs" ]; then
#    echo "iatsreqs already exists."
#    exit 0;
#fi

export HOME=/root
export USER=root
export DEBIAN_FRONTEND=noninteractive
export DEBIAN_PRIORITY=critical
export IATSREQS_DIR=/opt/iatsreqs

echo "192.168.200.10  master.localhost" >> /etc/hosts

log() {
  /bin/echo "$(date) $*" 
  sleep 1
}

log "SSH settings"
mkdir -p /root/.ssh
cat /vagrant/master.id_rsa.pub >> /root/.ssh/authorized_keys

apt-get update
apt-get install -q -y mysql-server

# Insert test data...

log "prepare replication"

sed -i '/server-id/c\server-id = 2' /etc/mysql/my.cnf
sed -i 's/#log_bin/log_bin/' /etc/mysql/my.cnf

service mysql restart

log "Setting up slave"

echo "
CHANGE MASTER TO
MASTER_HOST='master.localhost',
MASTER_USER='replication',
MASTER_SSL=0, 
MASTER_CONNECT_RETRY=10; " | mysql -u root

echo "Waiting master server"
touch /tmp/slave.ready
while !  ls /tmp/ready-all-databases.sql.gz &>/dev/null ; do sleep 5;log "Waiting for master to send the dump..."; done

zcat /tmp/ready-all-databases.sql.gz | mysql

echo "START SLAVE" | mysql -u root

echo "show slave status\G" | mysql | egrep 'Slave|Master'

log "Finish slave online!"

exit 0
