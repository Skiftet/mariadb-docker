#!/bin/bash
set -e

RANDOM_PASSWORD=$(cat /dev/urandom | tr -dc A-Za-z0-9 | fold -w 16 | head -n 1)

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<-EOSQL
    CREATE USER '$1'@'localhost' IDENTIFIED BY '$RANDOM_PASSWORD';
    CREATE DATABASE $1;
    GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost';
    FLUSH PRIVILEGES;
EOSQL

echo $RANDOM_PASSWORD
