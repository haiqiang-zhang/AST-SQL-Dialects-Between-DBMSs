drop database if exists db_01294;
create database db_01294;
set distributed_ddl_output_mode='throw';
drop table if exists db_01294.dist_01294;
system stop distributed sends db_01294.dist_01294;
system start distributed sends db_01294.dist_01294;
drop database db_01294;
