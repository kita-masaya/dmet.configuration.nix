#!/bin/sh
CID=`docker-compose -f ${HOME}/docker-compose.yml ps -q postgres`
docker exec ${CID} /bin/bash -c 'pg_dump -U postgres postgres | gzip > /usr/local/redash_backup.gz'
docker cp ${CID}:/usr/local/redash_backup.gz redash_backup.gz

