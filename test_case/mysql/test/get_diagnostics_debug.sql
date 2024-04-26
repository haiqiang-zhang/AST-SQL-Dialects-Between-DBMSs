CREATE TABLE t1 (f1 INT);
CREATE PROCEDURE p1()
BEGIN
  INSERT INTO t1 VALUES(1);
SET DEBUG='+d,simulate_max_reprepare_attempts_hit_case';
GET DIAGNOSTICS CONDITION 1 @varErrorMessage = message_text, @varErrorNo = mysql_errno;
SELECT @varErrorMessage, @varErrorNo;
GET DIAGNOSTICS CONDITION 1 @varErrorMessage = message_text, @varErrorNo = mysql_errno;
SELECT @varErrorMessage, @varErrorNo;

DROP TABLE t1;
DROP PROCEDURE p1;
DROP PREPARE stmt;
SET DEBUG='-d,simulate_max_reprepare_attempts_hit_case';
