--# Save current state of slow log variables
SET @old_slow_query_log= @@global.slow_query_log;
SET @old_log_output= @@global.log_output;
SET @old_long_query_time= @@long_query_time;
SET GLOBAL log_output= "TABLE";
SET GLOBAL slow_query_log= ON;
SET SESSION long_query_time= 0;

CREATE TABLE t17059925 (a INT, KEY a(a));
CREATE TABLE t2 (b INT);
CREATE TABLE t3 (c INT);
INSERT INTO t17059925 VALUES (1);
INSERT INTO t2 VALUES (4), (5), (6);
INSERT INTO t3 VALUES (7), (8), (9);
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM t2 UNION SELECT * FROM t3;
SELECT sleep(0.5) FROM t17059925 UNION ALL SELECT * FROM t2 UNION ALL SELECT * FROM t3;

--# SELECT FROM NON TABLE.
CREATE FUNCTION t17059925_func1 (a INT)
  RETURNS INT DETERMINISTIC
  RETURN a;
SELECT t17059925_func1(1), sleep(0.5);
SELECT sleep(0.5) from t17059925 UNION SELECT t17059925_func1(1);

SELECT * FROM (SELECT t17059925_func1(1)) t WHERE 1= 0 UNION SELECT sleep(0.5);
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM (SELECT t17059925_func1(1)) t WHERE 1= 0 UNION SELECT t17059925_func1(1);

SELECT 1 FROM dual WHERE 1= 0 UNION SELECT sleep(0.5);
SELECT sleep(0.5) FROM t17059925 UNION SELECT 1 FROM dual WHERE 1= 0 UNION SELECT * FROM t2;

--# SELECT FROM CONST TABLE.
SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION SELECT sleep(0.5);
SELECT * FROM t17059925 WHERE a= 10 UNION SELECT sleep(0.5);
SELECT * FROM (SELECT * FROM t17059925 WHERE a= 10) t WHERE a = 10 UNION SELECT sleep(0.5);
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION SELECT * FROM t2;
SELECT sleep(0.5) FROM t17059925 UNION ALL SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION ALL SELECT * FROM t2;
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM (SELECT * FROM t17059925 WHERE a= 10) t WHERE a = 10 UNION SELECT * from t2;
SELECT sql_text, rows_examined FROM mysql.slow_log WHERE (sql_text LIKE '%SELECT%t17059925%'
       AND sql_text NOT LIKE '%EXPLAIN%') OR sql_text LIKE '%dual%';

DROP FUNCTION t17059925_func1;
DROP TABLE t17059925, t2, t3;

--# Reset to initial values
SET @@long_query_time= @old_long_query_time;
SET @@global.log_output= @old_log_output;
SET @@global.slow_query_log= @old_slow_query_log;
CREATE TABLE tbl_18335504(a INT, b INT, KEY i1(a));
INSERT INTO tbl_18335504 VALUES( 30, 1);
INSERT INTO tbl_18335504 VALUES( 20, 2);
INSERT INTO tbl_18335504 VALUES( 10, 3);

SET @old_slow_query_log=@@global.slow_query_log;
SET @old_log_output=@@global.log_output;
SET @old_long_query_time=@@session.long_query_time;

SET GLOBAL slow_query_log='on';
SET GLOBAL log_output='table';
SET SESSION long_query_time=1;
SELECT sql_text, rows_sent, rows_examined FROM mysql.slow_log WHERE sql_text LIKE '%tbl_18335504%';
DROP TABLE tbl_18335504;

SET @@global.slow_query_log=@old_slow_query_log;
SET @@global.log_output=@old_log_output;
SET @@session.long_query_time=@old_long_query_time;
