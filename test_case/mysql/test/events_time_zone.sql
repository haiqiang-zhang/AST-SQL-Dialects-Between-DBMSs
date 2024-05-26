SELECT * FROM t1 ORDER BY count, comment;
DROP TABLE t1, t2;
CREATE TABLE t1 (event CHAR(2), dt DATE, offset INT);
SELECT * FROM t1 ORDER BY dt, event;
DROP TABLE t1;
DROP TABLE t_step;
DROP DATABASE mysqltest_db1;
SELECT COUNT(*) = 0 FROM information_schema.processlist
  WHERE db='mysqltest_db1' AND command = 'Connect' AND user=current_user();
