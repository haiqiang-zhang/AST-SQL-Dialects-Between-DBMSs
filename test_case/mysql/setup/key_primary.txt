drop table if exists t1;
create table t1 (t1 char(3) primary key) charset utf8mb4;
insert into t1 values("ABC");
insert into t1 values("ABA");
insert into t1 values("AB%");
