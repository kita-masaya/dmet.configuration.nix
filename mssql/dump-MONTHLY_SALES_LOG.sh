#!/bin/sh
DESTDIR="売上明細履歴"
YM=`date +%Y-%m -d 'last month'`
OUTCSV="${DESTDIR}-${YM}.csv"

docker exec -it kikan_snap \
 /opt/mssql-tools/bin/sqlcmd -S . -d Kikan -U sa -P MetaMeta123 -s, -W -u \
 -Q "SET NOCOUNT ON; EXEC P_MONTHLY_SALES_LOG @P_DATE = '${YM}-1'" \
| sed -e '2d' | iconv -f UTF-8 -t SHIFT_JISX0213 > ${OUTCSV}

smbclient //192.168.1.219/share/ metalics -U metalics -c "cd ${DESTDIR}; put ${OUTCSV}"

rm -f ${OUTCSV}

