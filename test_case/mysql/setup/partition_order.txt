drop table if exists t1;
CREATE TABLE t1 (
a int not null,
b int not null,
primary key(a),
index (b))
partition by range (a)
partitions 2
(partition x1 values less than (25),
 partition x2 values less than (100));
INSERT into t1 values (1, 1);
INSERT into t1 values (2, 5);
INSERT into t1 values (30, 4);
INSERT into t1 values (35, 2);
