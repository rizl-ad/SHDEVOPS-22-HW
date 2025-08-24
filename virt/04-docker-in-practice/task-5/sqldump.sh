#!/bin/bash

source /opt/shvirtd-example-python/.env
docker exec -i db_w5_t3 mysql -uroot -p${MYSQL_ROOT_PASSWORD} < usr.sql
docker run \
        -d \
        --name mysqldump_w5_t5 \
        --network shvirtd-example-python_backend \
        --ip 172.20.0.15 \
        --rm --entrypoint "" \
        -v /opt/backup:/backup \
        schnitzler/mysqldump:3.18 \
        mysqldump --opt -h db -u ${DB_USER} -p${DB_PASSWORD} "--result-file=/backup/dumps_$(date +'%Y-%m-%d_%H:%M:%S').sql" ${DB_DATABASE}
