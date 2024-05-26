drop table if exists t1,t2;
create table t1 (name char(20) not null, primary key (name)) charset latin1;
create table t2 (name char(20) collate utf8mb4_bin not null, primary key (name));
insert into t2 select * from t1;
