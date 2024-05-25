SELECT 1;
UNLOCK TABLES;
DROP TABLE t1;
create table t1 (a int) engine=innodb;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1)";
unlock tables;
drop table t1;
