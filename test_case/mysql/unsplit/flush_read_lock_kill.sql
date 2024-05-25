DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (kill_id INT) engine = InnoDB;
INSERT INTO t1 VALUES(connection_id());
INSERT INTO t1 VALUES(connection_id());
SELECT ((@id := kill_id) - kill_id) FROM t1 LIMIT 1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock"
  and info = "flush tables with read lock";
DROP TABLE t1;
