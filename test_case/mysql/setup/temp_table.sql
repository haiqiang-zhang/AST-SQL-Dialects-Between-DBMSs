drop table if exists t1,t2;
drop view if exists v1;
CREATE TABLE t1 (c int not null, d char (10) not null);
insert into t1 values(1,""),(2,"a"),(3,"b");
CREATE TEMPORARY TABLE t1 (a int not null, b char (10) not null);
insert into t1 values(4,"e"),(5,"f"),(6,"g");
alter table t1 rename t2;
