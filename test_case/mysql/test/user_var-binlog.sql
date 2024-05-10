create table t1 (a varchar(50));
INSERT INTO t1 VALUES(@`a b`);
insert into t1 values (@var1),(@var2);
drop table t1;
