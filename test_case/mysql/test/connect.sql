create temporary table t2(id integer not null auto_increment primary key);
delete from t1 where id like @id;
SELECT COUNT(*) = 0
  FROM information_schema.processlist
  WHERE  id = '$connection_id';
drop table t1;
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
SELECT user FROM information_schema.processlist ORDER BY id;
SELECT COUNT(*) = 1
  FROM information_schema.processlist
  WHERE db = 'test';
SELECT COUNT(*) = 1 FROM information_schema.processlist
  WHERE user = 'event_scheduler' AND command = 'Daemon';
SELECT USER();
CREATE TABLE t1 (A INT);
CREATE PROCEDURE TEST_t1(new_a INT) INSERT INTO t1 VALUES (new_a);
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
SELECT USER();
DROP PROCEDURE test_t1;
DROP TABLE t1;
CREATE DATABASE test1;
DROP DATABASE test1;
