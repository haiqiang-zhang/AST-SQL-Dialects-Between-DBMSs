select * from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1;
delete from t1;
drop table t1;
DROP TABLE IF EXISTS thread_status;
DROP EVENT IF EXISTS event_status;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);
DROP TABLE t1;
