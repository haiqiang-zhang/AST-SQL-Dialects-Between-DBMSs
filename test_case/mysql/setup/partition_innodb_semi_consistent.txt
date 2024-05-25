create table t1(a int not null)
engine=innodb
DEFAULT CHARSET=latin1
PARTITION BY RANGE(a)
(PARTITION p0 VALUES LESS THAN (20),
 PARTITION p1 VALUES LESS THAN MAXVALUE);
insert into t1 values (1),(2),(3),(4),(5),(6),(7);
