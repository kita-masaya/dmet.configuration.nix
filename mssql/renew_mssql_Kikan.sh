#!/bin/sh

if [ ! "$(docker images -q microsoft/mssql-server-linux)" ]; then
	docker pull microsoft/mssql-server-linux:2017-latest
fi

if [ ! "$(docker ps -q -f name=kikan-snap -f status=running)" ]; then
	docker rm -f kikan-snap
	docker run --restart=always -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=<YourStrong!Passw0rd>' -p 1433:1433 -v${PWD}:/src/host --name kikan-snap -d microsoft/mssql-server-linux:2017-latest
	docker exec -it kikan-snap /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P '<YourStrong!Passw0rd>' -Q "ALTER LOGIN sa WITH PASSWORD='MetaMeta123'"
fi

BAKFILE=Kikan_`date +%Y%m%d --date=yesterday`.bak
smbclient '\\192.168.1.219\share' metalics -U metalics -c "prompt;cd MSSQL_Backup;mget ${BAKFILE}.zip"
unzip ${BAKFILE}.zip && rm -f ${BAKFILE}.zip
docker exec -it kikan-snap /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P MetaMeta123 -Q "RESTORE DATABASE [Kikan] FROM DISK = N'/src/host/${BAKFILE}' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5, MOVE 'master_20170203' TO '/var/opt/mssql/data/Kikan.mdf', MOVE 'master_20170203_log' TO '/var/opt/mssql/data/Kikan_log.ldf'"
rm -f ${BAKFILE}

