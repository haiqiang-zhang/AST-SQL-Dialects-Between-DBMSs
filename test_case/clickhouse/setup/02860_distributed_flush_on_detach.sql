set prefer_localhost_replica=0;
drop table if exists data;
drop table if exists dist;
create table data (key Int) engine=Memory();
