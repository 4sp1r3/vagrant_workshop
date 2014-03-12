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

echo "192.168.200.11  slave.localhost" >> /etc/hosts

log() {
  /bin/echo "$(date) $*" 
  sleep 1
}

if [ ! -f /tmp/all-databases.sql.gz ]; then

    apt-get update
    apt-get install -q -y mysql-server

    # Insert test data...

    log "prepare replication"

    sed -i 's/#server-id/server-id/g' /etc/mysql/my.cnf
    sed -i 's/#log_bin/log_bin/g' /etc/mysql/my.cnf
    sed -i 's/bind-address/#bind-address/g' /etc/mysql/my.cnf
    

    service mysql restart

    mysql <<EOB
    CREATE USER 'replication'@'%' ;
    GRANT REPLICATION SLAVE ON *.* TO 'replication'@'%' ;
    flush privileges ;
    FLUSH TABLES ;
EOB

    mkdir -p /root/.ssh
    cat /vagrant/master.id_rsa >> /root/.ssh/id_rsa
    chmod o-rw /root/.ssh/id_rsa
    chmod g-rw /root/.ssh/id_rsa
    echo "StrictHostKeyChecking=no" >> /root/.ssh/config

    log "Dumping mysql databases"
    mysqldump -uroot --single-transaction --opt --master-data=1 --all-databases --events | gzip > /tmp/all-databases.sql.gz
else
    log "Skipping install..."
fi 

log "vagrant up slave"
sleep 5

# esperar a que rmaster responda ping, copiarle all-databases y hacer los restores.
while ! ping -c1 slave.localhost &>/dev/null; do sleep 5;log "Waiting for slave to be online..."; done
while ! ssh root@slave.localhost ls /tmp/slave.ready &>/dev/null; do sleep 5;log "Waiting for slave to be ready for the database..."; done

scp /tmp/all-databases.sql.gz root@slave.localhost:/tmp
ssh root@slave.localhost mv /tmp/all-databases.sql.gz /tmp/ready-all-databases.sql.gz

exit 0

