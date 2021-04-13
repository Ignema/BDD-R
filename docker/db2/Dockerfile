FROM oracleinanutshell/oracle-xe-11g:latest

WORKDIR /u01/app/oracle/product/11.2.0/xe/network/admin/

RUN sed -i '3, 10 s/^/#/' tnsnames.ora

COPY ./config/tnsnames.txt tnsnames.txt

RUN cat tnsnames.txt >> tnsnames.ora
RUN rm tnsnames.txt

WORKDIR /
EXPOSE 1521