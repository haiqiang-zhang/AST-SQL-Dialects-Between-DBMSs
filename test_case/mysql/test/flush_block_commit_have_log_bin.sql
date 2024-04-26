
-- FLUSH TABLES WITH READ LOCK should block writes to binlog too
--echo -- Switch to connection con1
connection con1;
CREATE TABLE t1 (a INT) ENGINE=innodb;
SET AUTOCOMMIT=0;
SELECT 1;
DROP TABLE t1;
SET AUTOCOMMIT=1;

-- GLR blocks new transactions
create table t1 (a int) engine=innodb;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for global read lock" and
        info = "insert into t1 values (1)";
drop table t1;
