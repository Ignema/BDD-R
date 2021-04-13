#!bin/bash

# Cleaning the container SQL directory
docker exec -it $(docker ps -q -f name=db$) rm -rf /sql 2> /dev/null
docker exec -it $(docker ps -q -f name=db1) rm -rf /sql 2> /dev/null
docker exec -it $(docker ps -q -f name=db2) rm -rf /sql 2> /dev/null

# Creating a new SQL directory in all our containers
docker cp ../../sql $(docker ps -q -f name=db$):/sql
docker cp ../../sql $(docker ps -q -f name=db1):/sql
docker cp ../../sql $(docker ps -q -f name=db2):/sql

# Creating a new SQL directory in all our containers

docker exec -it $(docker ps -q -f name=db$) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/oracle@DB @/sql/db/admin.sql << EOF"
docker exec -it $(docker ps -q -f name=db1) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/oracle@DB1 @/sql/db1/admin.sql << EOF"
docker exec -it $(docker ps -q -f name=db2) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus system/oracle@DB2 @/sql/db2/admin.sql << EOF"

docker exec -it $(docker ps -q -f name=db1) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus admin1/oracle@DB1 @/sql/db1/creationBaseComptes.sql << EOF"

docker exec -it $(docker ps -q -f name=db1) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus admin1/oracle@DB1 @/sql/db1/db1.sql << EOF"
docker exec -it $(docker ps -q -f name=db2) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus admin2/oracle@DB2 @/sql/db2/db2.sql << EOF"

docker exec -it $(docker ps -q -f name=db$) bash -c "ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe /u01/app/oracle/product/11.2.0/xe/bin/sqlplus admin/oracle@DB @/sql/db/db.sql << EOF"