SET send_logs_level = 'fatal';
drop database if exists db_hang;
drop database if exists db_hang_temp;
set allow_deprecated_database_ordinary=1;
create database db_hang engine=Ordinary;
