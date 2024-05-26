create temporary table ta (i int not null) engine=archive;
create temporary table tb (i int not null) engine=blackhole;
create temporary table tc (i int not null) engine=csv;
create temporary table th (i int not null) engine=heap;
create temporary table ti (i int not null) engine=innodb;
create temporary table tm (i int not null) engine=myisam;
create temporary table tg (i int not null) engine=merge union=();
create database mysqltest;
create table mysqltest.t1 (i int not null) engine=myisam;
