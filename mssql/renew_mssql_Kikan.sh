#!/bin/sh
BAKFILE=Kikan_`date +%Y%m%d --date=yesterday`.bak
smbclient '\\192.168.1.219\share' metalics -U metalics -c "prompt;cd MSSQL_Backup;mget ${BAKFILE}.zip"
unzip ${BAKFILE}.zip && rm -f ${BAKFILE}.zip
docker exec kikan_snap /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P MetaMeta123 -Q "
ALTER DATABASE [Kikan] SET SINGLE_USER WITH ROLLBACK AFTER 60
RESTORE DATABASE [Kikan] FROM DISK = N'/src/host/${BAKFILE}' WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 5, MOVE 'master_20170203' TO '/var/opt/mssql/data/Kikan.mdf', MOVE 'master_20170203_log' TO '/var/opt/mssql/data/Kikan_log.ldf'
ALTER DATABASE [Kikan] SET MULTI_USER
GO
"
rm -f ${BAKFILE}
docker exec kikan_snap /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P MetaMeta123 -i /src/host/P_MONTHLY_SALES_LOG.sql
