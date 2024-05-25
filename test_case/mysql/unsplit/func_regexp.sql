drop table if exists t1;
create table t1 (xxx char(128));
insert into t1 (xxx) values('this is a test of some long text to see what happens');
select * from t1 where xxx regexp('is a test of some long text to');
select * from t1 where xxx regexp('is a test of some long text to ');
select * from t1 where xxx regexp('is a test of some long text to s');
select * from t1 where xxx regexp('is a test of some long text to se');
drop table t1;
create table t1 (xxx char(128));
insert into t1 (xxx) values('this is some text: to test - out.reg exp (22/45)');
drop table t1;
select _latin1 0xFF regexp _latin1 '[[:lower:]]' COLLATE latin1_bin;
select _koi8r  0xFF regexp _koi8r  '[[:lower:]]' COLLATE koi8r_bin;
select _latin1 0xFF regexp _latin1 '[[:upper:]]' COLLATE latin1_bin;
select _koi8r  0xFF regexp _koi8r  '[[:upper:]]' COLLATE koi8r_bin;
select _latin1 0xF7 regexp _latin1 '[[:alpha:]]';
select _koi8r  0xF7 regexp _koi8r  '[[:alpha:]]';
select _latin1'a' regexp _latin1'A' collate latin1_general_ci;
select _latin1'a' regexp _latin1'A' collate latin1_bin;
create table t1 (a varchar(40));
insert into t1 values ('C1'),('C2'),('R1'),('C3'),('R2'),('R3');
prepare stmt1 from 'select a from t1 where a rlike ? order by a';
deallocate prepare stmt1;
drop table t1;
SELECT 1 REGEXP NULL;
SELECT NULL REGEXP BINARY NULL;
CREATE TABLE t1(a INT, b CHAR(4));
INSERT INTO t1 VALUES (1, '6.1'), (1, '7.0'), (1, '8.0');
PREPARE stmt1 FROM "SELECT a FROM t1 WHERE a=1 AND '7.0' REGEXP b LIMIT 1";
DEALLOCATE PREPARE stmt1;
DROP TABLE t1;
SELECT ' '  REGEXP '[[:blank:]]';
SELECT '\t' REGEXP '[[:blank:]]';
SELECT ' '  REGEXP '[[:space:]]';
SELECT '\t' REGEXP '[[:space:]]';
SELECT REGEXP_INSTR(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);
SELECT REGEXP_LIKE(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);
SELECT REGEXP_REPLACE(e, 'pattern', 'xyz')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);
SELECT REGEXP_SUBSTR(e, 'pattern')
FROM (VALUES ROW('Find pattern'), ROW(NULL), ROW('Find pattern')) AS v(e);
