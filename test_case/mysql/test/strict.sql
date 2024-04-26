
set @org_mode=@@sql_mode;
set @@sql_mode='ansi,traditional';
select @@sql_mode;
DROP TABLE IF EXISTS t1, t2;

-- Test INSERT with DATE

CREATE TABLE t1 (col1 date);
INSERT INTO t1 VALUES('2004-01-01'),('2004-02-29');
INSERT INTO t1 VALUES('0000-10-31');

-- All test cases expected to fail should return 
--      SQLSTATE 22007 <invalid date value>
--error 1292
INSERT INTO t1 VALUES('2004-0-31');
INSERT INTO t1 VALUES('2004-01-02'),('2004-0-31');
INSERT INTO t1 VALUES('2004-10-0');
INSERT INTO t1 VALUES('2004-09-31');
INSERT INTO t1 VALUES('2004-10-32');
INSERT INTO t1 VALUES('2003-02-29');
INSERT INTO t1 VALUES('2004-13-15');
INSERT INTO t1 VALUES('0000-00-00');
INSERT INTO t1 VALUES ('59');

-- Test the different related modes
set @@sql_mode='STRICT_ALL_TABLES';
INSERT INTO t1 VALUES('2004-01-03'),('2004-0-31');
set @@sql_mode='STRICT_ALL_TABLES,NO_ZERO_IN_DATE';
INSERT INTO t1 VALUES('2004-0-30');
INSERT INTO t1 VALUES('2004-01-04'),('2004-0-31'),('2004-01-05');

INSERT INTO t1 VALUES('0000-00-00');
INSERT IGNORE INTO t1 VALUES('2004-0-29');
set @@sql_mode='STRICT_ALL_TABLES,NO_ZERO_DATE';
INSERT INTO t1 VALUES('0000-00-00');
INSERT IGNORE INTO t1 VALUES('0000-00-00');
INSERT INTO t1 VALUES ('2004-0-30');
INSERT INTO t1 VALUES ('2004-2-30');
set @@sql_mode='STRICT_ALL_TABLES,ALLOW_INVALID_DATES';
INSERT INTO t1 VALUES ('2004-2-30');
set @@sql_mode='ansi,traditional';
INSERT IGNORE INTO t1 VALUES('2004-02-29'),('2004-13-15'),('0000-00-00');

select * from t1;
drop table t1;

-- Test difference in behaviour with InnoDB and MyISAM tables

set @@sql_mode='strict_trans_tables';
CREATE TABLE t1 (col1 date) engine=myisam;
INSERT INTO t1 VALUES('2004-13-31'),('2004-1-1');
INSERT INTO t1 VALUES ('2004-1-2'), ('2004-13-31'),('2004-1-3');
INSERT IGNORE INTO t1 VALUES('2004-13-31'),('2004-1-4');
INSERT INTO t1 VALUES ('2003-02-29');
INSERT ignore INTO t1 VALUES('2003-02-30');
set @@sql_mode='STRICT_ALL_TABLES,ALLOW_INVALID_DATES';
INSERT ignore INTO t1 VALUES('2003-02-31');
select * from t1;
drop table t1;

set @@sql_mode='strict_trans_tables';
CREATE TABLE t1 (col1 date) engine=innodb;
INSERT INTO t1 VALUES('2004-13-31'),('2004-1-1');
INSERT INTO t1 VALUES ('2004-1-2'), ('2004-13-31'),('2004-1-3');
INSERT IGNORE INTO t1 VALUES('2004-13-31'),('2004-1-4');
INSERT INTO t1 VALUES ('2003-02-29');
INSERT ignore INTO t1 VALUES('2003-02-30');
set @@sql_mode='STRICT_ALL_TABLES,ALLOW_INVALID_DATES';
INSERT ignore INTO t1 VALUES('2003-02-31');
select * from t1;
drop table t1;
set @@sql_mode='ansi,traditional';

-- Test INSERT with DATETIME

CREATE TABLE t1 (col1 datetime);
INSERT INTO t1 VALUES('2004-10-31 15:30:00'),('2004-02-29 15:30:00');
INSERT INTO t1 VALUES('0000-10-31 15:30:00');

-- All test cases expected to fail should return 
--      SQLSTATE 22007 <invalid datetime value>
--error 1292
INSERT INTO t1 VALUES('2004-0-31 15:30:00');
INSERT INTO t1 VALUES('2004-10-0 15:30:00');
INSERT INTO t1 VALUES('2004-09-31 15:30:00');
INSERT INTO t1 VALUES('2004-10-32 15:30:00');
INSERT INTO t1 VALUES('2003-02-29 15:30:00');
INSERT INTO t1 VALUES('2004-13-15 15:30:00');
INSERT INTO t1 VALUES('0000-00-00 15:30:00');
INSERT INTO t1 VALUES ('59');
select * from t1;
drop table t1;

-- Test INSERT with TIMESTAMP

CREATE TABLE t1 (col1 timestamp);
INSERT INTO t1 VALUES('2004-10-31 15:30:00'),('2004-02-29 15:30:00');

-- All test cases expected to fail should return 
--      SQLSTATE 22007 <invalid datetime value>
-- Standard says we should return ok, but we can't as this is out of range
--error 1292
INSERT INTO t1 VALUES('0000-10-31 15:30:00');
INSERT INTO t1 VALUES('2004-0-31 15:30:00');
INSERT INTO t1 VALUES('2004-10-0 15:30:00');
INSERT INTO t1 VALUES('2004-09-31 15:30:00');
INSERT INTO t1 VALUES('2004-10-32 15:30:00');
INSERT INTO t1 VALUES('2003-02-29 15:30:00');
INSERT INTO t1 VALUES('2004-13-15 15:30:00');
INSERT INTO t1 VALUES('2004-02-29 25:30:00');
INSERT INTO t1 VALUES('2004-02-29 15:65:00');
INSERT INTO t1 VALUES('2004-02-29 15:31:61');
INSERT INTO t1 VALUES('0000-00-00 15:30:00');
INSERT INTO t1 VALUES('0000-00-00 00:00:00');
INSERT IGNORE INTO t1 VALUES('0000-00-00 00:00:00');
INSERT INTO t1 VALUES ('59');

set @@sql_mode='STRICT_ALL_TABLES,ALLOW_INVALID_DATES';
INSERT INTO t1 VALUES('2004-0-31 15:30:00');
INSERT INTO t1 VALUES('2004-10-0 15:30:00');
INSERT INTO t1 VALUES('2004-10-32 15:30:00');
INSERT INTO t1 VALUES('2004-02-30 15:30:04');
INSERT IGNORE INTO t1 VALUES('0000-00-00 00:00:00');
set @@sql_mode='STRICT_ALL_TABLES,NO_ZERO_IN_DATE';
INSERT INTO t1 VALUES('0000-00-00 00:00:00');
set @@sql_mode='STRICT_ALL_TABLES,NO_ZERO_DATE';
INSERT INTO t1 VALUES('0000-00-00 00:00:00');
set @@sql_mode='ansi,traditional';
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (col1 date, col2 datetime, col3 timestamp);

INSERT INTO t1 (col1) VALUES (STR_TO_DATE('15.10.2004','%d.%m.%Y'));
INSERT INTO t1 (col2) VALUES (STR_TO_DATE('15.10.2004 10.15','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES (STR_TO_DATE('15.10.2004 10.15','%d.%m.%Y %H.%i'));

--# Test INSERT with STR_TO_DATE into DATE
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid date value>

--error 1411
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('31.10.0000 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('31.0.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('0.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('31.9.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('32.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('29.02.2003 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('15.13.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col1) VALUES(STR_TO_DATE('00.00.0000','%d.%m.%Y'));

--# Test INSERT with STR_TO_DATE into DATETIME
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>

--error 1411
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('31.10.0000 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('31.0.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('0.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('31.9.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('32.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('29.02.2003 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('15.13.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col2) VALUES(STR_TO_DATE('00.00.0000','%d.%m.%Y'));

--# Test INSERT with STR_TO_DATE into TIMESTAMP
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>

--error 1411
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('31.10.0000 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('31.0.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('0.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('31.9.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('32.10.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('29.02.2003 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('15.13.2004 15.30','%d.%m.%Y %H.%i'));
INSERT INTO t1 (col3) VALUES(STR_TO_DATE('00.00.0000','%d.%m.%Y'));

drop table t1;

CREATE TABLE t1 (col1 date, col2 datetime, col3 timestamp);

INSERT INTO t1 (col1) VALUES (CAST('2004-10-15' AS DATE));
INSERT INTO t1 (col2) VALUES (CAST('2004-10-15 10:15' AS DATETIME));
INSERT INTO t1 (col3) VALUES (CAST('2004-10-15 10:15' AS DATETIME));


--# Test INSERT with CAST AS DATE into DATE
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid date value>

INSERT INTO t1 (col1) VALUES(CAST('0000-10-31' AS DATE));
INSERT INTO t1 (col1) VALUES(CAST('2004-10-0' AS DATE));
INSERT INTO t1 (col1) VALUES(CAST('2004-0-10' AS DATE));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
-- --error 1292
-- INSERT INTO t1 (col1) VALUES(CAST('2004-9-31' AS DATE));

-- deactivated because of Bug#6145
--  Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col1) VALUES(CAST('0000-00-00' AS DATE));

--# Test INSERT with CAST AS DATETIME into DATETIME
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>

INSERT INTO t1 (col2) VALUES(CAST('0000-10-31 15:30' AS DATETIME));
INSERT INTO t1 (col2) VALUES(CAST('2004-10-0 15:30' AS DATETIME));
INSERT INTO t1 (col2) VALUES(CAST('2004-0-10 15:30' AS DATETIME));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
----error 1292
--INSERT INTO t1 (col2) VALUES(CAST('2004-9-31 15:30' AS DATETIME));

-- Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col2) VALUES(CAST('0000-00-00' AS DATETIME));

--# Test INSERT with CAST AS DATETIME into TIMESTAMP
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>
--error 1292
INSERT INTO t1 (col3) VALUES(CAST('0000-10-31 15:30' AS DATETIME));
INSERT INTO t1 (col3) VALUES(CAST('2004-10-0 15:30' AS DATETIME));
INSERT INTO t1 (col3) VALUES(CAST('2004-0-10 15:30' AS DATETIME));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
----error 1292
--INSERT INTO t1 (col3) VALUES(CAST('2004-9-31 15:30' AS DATETIME));

-- Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col3) VALUES(CAST('0000-00-00' AS DATETIME));

drop table t1;

CREATE TABLE t1 (col1 date, col2 datetime, col3 timestamp);

INSERT INTO t1 (col1) VALUES (CONVERT('2004-10-15',DATE));
INSERT INTO t1 (col2) VALUES (CONVERT('2004-10-15 10:15',DATETIME));
INSERT INTO t1 (col3) VALUES (CONVERT('2004-10-15 10:15',DATETIME));


--# Test INSERT with CONVERT to DATE into DATE
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid date value>

INSERT INTO t1 (col1) VALUES(CONVERT('0000-10-31' , DATE));
INSERT INTO t1 (col1) VALUES(CONVERT('2004-10-0' , DATE));
INSERT INTO t1 (col1) VALUES(CONVERT('2004-0-10' , DATE));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
----error 1292
--INSERT INTO t1 (col1) VALUES(CONVERT('2004-9-31' , DATE));

-- Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col1) VALUES(CONVERT('0000-00-00',DATE));

--# Test INSERT with CONVERT to DATETIME into DATETIME
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>

INSERT INTO t1 (col2) VALUES(CONVERT('0000-10-31 15:30',DATETIME));
INSERT INTO t1 (col2) VALUES(CONVERT('2004-10-0 15:30',DATETIME));
INSERT INTO t1 (col2) VALUES(CONVERT('2004-0-10 15:30',DATETIME));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
----error 1292
--INSERT INTO t1 (col2) VALUES(CONVERT('2004-9-31 15:30',DATETIME));

-- Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col2) VALUES(CONVERT('0000-00-00',DATETIME));

--# Test INSERT with CONVERT to DATETIME into DATETIME
--       All test cases expected to fail should return 
--       SQLSTATE 22007 <invalid datetime value>
--error 1292
INSERT INTO t1 (col3) VALUES(CONVERT('0000-10-31 15:30',DATETIME));
INSERT INTO t1 (col3) VALUES(CONVERT('2004-10-0 15:30',DATETIME));
INSERT INTO t1 (col3) VALUES(CONVERT('2004-0-10 15:30',DATETIME));

-- deactivated because of Bug#8294
-- Bug#8294 Traditional: Misleading error message for invalid CAST to DATE
----error 1292
--INSERT INTO t1 (col3) VALUES(CONVERT('2004-9-31 15:30',DATETIME));

-- Bug#6145: Traditional: CONVERT and CAST should reject zero DATE values
--error 1292
INSERT INTO t1 (col3) VALUES(CONVERT('0000-00-00',DATETIME));

drop table t1;


-- Test INSERT with TINYINT

CREATE TABLE t1(col1 TINYINT, col2 TINYINT UNSIGNED);
INSERT INTO t1 VALUES(-128,0),(0,0),(127,255),('-128','0'),('0','0'),('127','255'),(-128.0,0.0),(0.0,0.0),(127.0,255.0);
SELECT MOD(col1,0) FROM t1 WHERE col1 > 0 LIMIT 2;
INSERT INTO t1 (col1) VALUES(-129);
INSERT INTO t1 (col1) VALUES(128);
INSERT INTO t1 (col2) VALUES(-1);
INSERT INTO t1 (col2) VALUES(256);
INSERT INTO t1 (col1) VALUES('-129');
INSERT INTO t1 (col1) VALUES('128');
INSERT INTO t1 (col2) VALUES('-1');
INSERT INTO t1 (col2) VALUES('256');
INSERT INTO t1 (col1) VALUES(128.0);
INSERT INTO t1 (col2) VALUES(-1.0);
INSERT INTO t1 (col2) VALUES(256.0);
SELECT MOD(col1,0) FROM t1 WHERE col1 > 0 LIMIT 1;
UPDATE t1 SET col1 = col1 - 50 WHERE col1 < 0;
UPDATE t1 SET col2=col2 + 50 WHERE col2 > 0;
UPDATE t1 SET col1=col1 / 0 WHERE col1 > 0;
set @@sql_mode='ERROR_FOR_DIVISION_BY_ZERO';
INSERT INTO t1 values (1/0,1/0);
set @@sql_mode='ansi,traditional';
SELECT MOD(col1,0) FROM t1 WHERE col1 > 0 LIMIT 2;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0,1/0);
set @@sql_mode='ansi';
INSERT INTO t1 values (1/0,1/0);
set @@sql_mode='ansi,traditional';
INSERT IGNORE INTO t1 VALUES('-129','-1'),('128','256');
INSERT IGNORE INTO t1 VALUES(-129.0,-1.0),(128.0,256.0);
UPDATE IGNORE t1 SET col2=1/NULL where col1=0;

SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with SMALLINT

CREATE TABLE t1(col1 SMALLINT, col2 SMALLINT UNSIGNED);
INSERT INTO t1 VALUES(-32768,0),(0,0),(32767,65535),('-32768','0'),('32767','65535'),(-32768.0,0.0),(32767.0,65535.0);
INSERT INTO t1 (col1) VALUES(-32769);
INSERT INTO t1 (col1) VALUES(32768);
INSERT INTO t1 (col2) VALUES(-1);
INSERT INTO t1 (col2) VALUES(65536);
INSERT INTO t1 (col1) VALUES('-32769');
INSERT INTO t1 (col1) VALUES('32768');
INSERT INTO t1 (col2) VALUES('-1');
INSERT INTO t1 (col2) VALUES('65536');
INSERT INTO t1 (col1) VALUES(-32769.0);
INSERT INTO t1 (col1) VALUES(32768.0);
INSERT INTO t1 (col2) VALUES(-1.0);
INSERT INTO t1 (col2) VALUES(65536.0);
UPDATE t1 SET col1 = col1 - 50 WHERE col1 < 0;
UPDATE t1 SET col2 = col2 + 50 WHERE col2 > 0;
UPDATE t1 SET col1 = col1 / 0 WHERE col1 > 0;
UPDATE t1 SET col1= MOD(col1,0) WHERE col1 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0,1/0);
INSERT IGNORE INTO t1 VALUES(-32769,-1),(32768,65536);
INSERT IGNORE INTO t1 VALUES('-32769','-1'),('32768','65536');
INSERT IGNORE INTO t1 VALUES(-32769,-1.0),(32768.0,65536.0);
UPDATE IGNORE t1 SET col2=1/NULL where col1=0;

SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with MEDIUMINT

CREATE TABLE t1 (col1 MEDIUMINT, col2 MEDIUMINT UNSIGNED);
INSERT INTO t1 VALUES(-8388608,0),(0,0),(8388607,16777215),('-8388608','0'),('8388607','16777215'),(-8388608.0,0.0),(8388607.0,16777215.0);
INSERT INTO t1 (col1) VALUES(-8388609);
INSERT INTO t1 (col1) VALUES(8388608);
INSERT INTO t1 (col2) VALUES(-1);
INSERT INTO t1 (col2) VALUES(16777216);
INSERT INTO t1 (col1) VALUES('-8388609');
INSERT INTO t1 (col1) VALUES('8388608');
INSERT INTO t1 (col2) VALUES('-1');
INSERT INTO t1 (col2) VALUES('16777216');
INSERT INTO t1 (col1) VALUES(-8388609.0);
INSERT INTO t1 (col1) VALUES(8388608.0);
INSERT INTO t1 (col2) VALUES(-1.0);
INSERT INTO t1 (col2) VALUES(16777216.0);
UPDATE t1 SET col1 = col1 - 50 WHERE col1 < 0;
UPDATE t1 SET col2 = col2 + 50 WHERE col2 > 0;
UPDATE t1 SET col1 =col1 / 0 WHERE col1 > 0;
UPDATE t1 SET col1= MOD(col1,0) WHERE col1 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0,1/0);
INSERT IGNORE INTO t1 VALUES(-8388609,-1),(8388608,16777216);
INSERT IGNORE INTO t1 VALUES('-8388609','-1'),('8388608','16777216');
INSERT IGNORE INTO t1 VALUES(-8388609.0,-1.0),(8388608.0,16777216.0);
UPDATE IGNORE t1 SET col2=1/NULL where col1=0;

SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with INT

CREATE TABLE t1 (col1 INT, col2 INT UNSIGNED);
INSERT INTO t1 VALUES(-2147483648,0),(0,0),(2147483647,4294967295),('-2147483648','0'),('2147483647','4294967295'),(-2147483648.0,0.0),(2147483647.0,4294967295.0);
INSERT INTO t1 (col1) VALUES(-2147483649);
INSERT INTO t1 (col1) VALUES(2147643648);
INSERT INTO t1 (col2) VALUES(-1);
INSERT INTO t1 (col2) VALUES(4294967296);
INSERT INTO t1 (col1) VALUES('-2147483649');
INSERT INTO t1 (col1) VALUES('2147643648');
INSERT INTO t1 (col2) VALUES('-1');
INSERT INTO t1 (col2) VALUES('4294967296');
INSERT INTO t1 (col1) VALUES(-2147483649.0);
INSERT INTO t1 (col1) VALUES(2147643648.0);
INSERT INTO t1 (col2) VALUES(-1.0);
INSERT INTO t1 (col2) VALUES(4294967296.0);
UPDATE t1 SET col1 = col1 - 50 WHERE col1 < 0;
UPDATE t1 SET col2 =col2 + 50 WHERE col2 > 0;
UPDATE t1 SET col1 =col1 / 0 WHERE col1 > 0;
UPDATE t1 SET col1= MOD(col1,0) WHERE col1 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0,1/0);
INSERT IGNORE INTO t1 values (-2147483649, -1),(2147643648,4294967296);
INSERT IGNORE INTO t1 values ('-2147483649', '-1'),('2147643648','4294967296');
INSERT IGNORE INTO t1 values (-2147483649.0, -1.0),(2147643648.0,4294967296.0);
UPDATE IGNORE t1 SET col2=1/NULL where col1=0;
SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with BIGINT
-- Note that this doesn't behave 100 % to standard as we rotate
-- integers when it's too big/small (just like C)

CREATE TABLE t1 (col1 BIGINT, col2 BIGINT UNSIGNED);
INSERT INTO t1 VALUES(-9223372036854775808,0),(0,0),(9223372036854775807,18446744073709551615);
INSERT INTO t1 VALUES('-9223372036854775808','0'),('9223372036854775807','18446744073709551615');
INSERT INTO t1 VALUES(-9223372036854774000.0,0.0),(9223372036854775700.0,1844674407370954000.0);
INSERT INTO t1 (col1) VALUES(-9223372036854775809);
INSERT INTO t1 (col1) VALUES(9223372036854775808);
INSERT INTO t1 (col2) VALUES(-1);
INSERT INTO t1 (col2) VALUES(18446744073709551616);
INSERT INTO t1 (col1) VALUES('-9223372036854775809');
INSERT INTO t1 (col1) VALUES('9223372036854775808');
INSERT INTO t1 (col2) VALUES('-1');
INSERT INTO t1 (col2) VALUES('18446744073709551616');

-- Note that the following two double numbers are slighty bigger than max/min
-- bigint becasue of rounding errors when converting it to bigint
--error 1264
INSERT INTO t1 (col1) VALUES(-9223372036854785809.0);
INSERT INTO t1 (col1) VALUES(9223372036854785808.0);
INSERT INTO t1 (col2) VALUES(-1.0);
INSERT INTO t1 (col2) VALUES(18446744073709551616.0);

-- The following doesn't give an error as it's done in integer context
-- UPDATE t1 SET col1=col1 - 5000 WHERE col1 < 0;
UPDATE t1 SET col1 =col1 / 0 WHERE col1 > 0;
UPDATE t1 SET col1= MOD(col1,0) WHERE col1 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0,1/0);
INSERT IGNORE INTO t1 VALUES(-9223372036854775809,-1),(9223372036854775808,18446744073709551616);
INSERT IGNORE INTO t1 VALUES('-9223372036854775809','-1'),('9223372036854775808','18446744073709551616');
INSERT IGNORE INTO t1 VALUES(-9223372036854785809.0,-1.0),(9223372036854785808.0,18446744073709551616.0);
UPDATE IGNORE t1 SET col2=1/NULL where col1=0;
SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with NUMERIC

CREATE TABLE t1 (col1 NUMERIC(4,2));
INSERT INTO t1 VALUES (10.55),(10.5555),(0),(-10.55),(-10.5555),(11),(1e+01);
INSERT INTO t1 VALUES ('10.55'),('10.5555'),('-10.55'),('-10.5555'),('11'),('1e+01');

-- The 2 following inserts should generate a warning, but doesn't yet
-- because NUMERIC works like DECIMAL
--error 1264
INSERT INTO t1 VALUES (101.55);
INSERT INTO t1 VALUES (101);
INSERT INTO t1 VALUES (-101.55);
INSERT INTO t1 VALUES (1010.55);
INSERT INTO t1 VALUES (1010);
INSERT INTO t1 VALUES ('101.55');
INSERT INTO t1 VALUES ('101');
INSERT INTO t1 VALUES ('-101.55');
INSERT INTO t1 VALUES ('-1010.55');
INSERT INTO t1 VALUES ('-100E+1');
INSERT INTO t1 VALUES ('-100E');
UPDATE t1 SET col1 =col1 * 50000 WHERE col1 =11;
UPDATE t1 SET col1 =col1 / 0 WHERE col1 > 0;
UPDATE t1 SET col1= MOD(col1,0) WHERE col1 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 values (1/0);
INSERT IGNORE INTO t1 VALUES(1000),(-1000);
INSERT IGNORE INTO t1 VALUES('1000'),('-1000');
INSERT IGNORE INTO t1 VALUES(1000.0),(-1000.0);
UPDATE IGNORE t1 SET col1=1/NULL where col1=0;
SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with FLOAT

CREATE TABLE t1 (col1 FLOAT, col2 FLOAT UNSIGNED);
INSERT INTO t1 VALUES (-1.1E-37,0),(+3.4E+38,+3.4E+38);
INSERT INTO t1 VALUES ('-1.1E-37',0),('+3.4E+38','+3.4E+38');
INSERT INTO t1 (col1) VALUES (3E-46);
INSERT INTO t1 (col1) VALUES (+3.4E+39);
INSERT INTO t1 (col2) VALUES (-1.1E-3);
INSERT INTO t1 (col1) VALUES ('+3.4E+39');
INSERT INTO t1 (col2) VALUES ('-1.1E-3');
UPDATE t1 SET col1 =col1 * 5000 WHERE col1 > 0;
UPDATE t1 SET col2 =col2 / 0 WHERE col2 > 0;
UPDATE t1 SET col2= MOD(col2,0) WHERE col2 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 (col1) VALUES (1/0);
INSERT IGNORE INTO t1 VALUES (+3.4E+39,-3.4E+39);
INSERT IGNORE INTO t1 VALUES ('+3.4E+39','-3.4E+39');
SELECT * FROM t1;
DROP TABLE t1;

-- Test INSERT with DOUBLE

CREATE TABLE t1 (col1 DOUBLE PRECISION, col2 DOUBLE PRECISION UNSIGNED);
INSERT INTO t1 VALUES (-2.2E-307,0),(2E-307,0),(+1.7E+308,+1.7E+308);
INSERT INTO t1 VALUES ('-2.2E-307',0),('-2E-307',0),('+1.7E+308','+1.7E+308');
INSERT INTO t1 (col1) VALUES (-2.2E-330);
INSERT INTO t1 (col1) VALUES (+1.7E+309);
INSERT INTO t1 (col2) VALUES (-1.1E-3);
INSERT INTO t1 (col1) VALUES ('+1.8E+309');
INSERT INTO t1 (col2) VALUES ('-1.2E-3');
UPDATE t1 SET col1 =col1 * 5000 WHERE col1 > 0;
UPDATE t1 SET col2 =col2 / 0 WHERE col2 > 0;
UPDATE t1 SET col2= MOD(col2,0) WHERE col2 > 0;
INSERT INTO t1 (col1) VALUES ('');
INSERT INTO t1 (col1) VALUES ('a59b');
INSERT INTO t1 (col1) VALUES ('1a');
INSERT IGNORE INTO t1 (col1) VALUES ('2a');
INSERT IGNORE INTO t1 (col1) values (1/0);
INSERT IGNORE INTO t1 VALUES (+1.9E+309,-1.9E+309);
INSERT IGNORE INTO t1 VALUES ('+2.0E+309','-2.0E+309');
SELECT * FROM t1;
DROP TABLE t1;

-- Testing INSERT with CHAR/VARCHAR

CREATE TABLE t1 (col1 CHAR(5), col2 VARCHAR(6));
INSERT INTO t1 VALUES ('hello', 'hello'),('he', 'he'),('hello   ', 'hello ');
INSERT INTO t1 (col1) VALUES ('hellobob');
INSERT INTO t1 (col2) VALUES ('hellobob');
INSERT INTO t1 (col2) VALUES ('hello  ');
UPDATE t1 SET col1 ='hellobob' WHERE col1 ='he';
UPDATE t1 SET col2 ='hellobob' WHERE col2 ='he';
INSERT IGNORE INTO t1 VALUES ('hellobob', 'hellobob');
UPDATE IGNORE t1 SET col2 ='hellotrudy' WHERE col2 ='he';
SELECT * FROM t1;
DROP TABLE t1;

-- Testing INSERT with ENUM

CREATE TABLE t1 (col1 enum('red','blue','green'));
INSERT INTO t1 VALUES ('red'),('blue'),('green');
INSERT INTO t1 (col1) VALUES ('yellow');
INSERT INTO t1 (col1) VALUES ('redd');
INSERT INTO t1 VALUES ('');
UPDATE t1 SET col1 ='yellow' WHERE col1 ='green';
INSERT IGNORE INTO t1 VALUES ('yellow');
UPDATE IGNORE t1 SET col1 ='yellow' WHERE col1 ='blue';
SELECT * FROM t1;
DROP TABLE t1;

-- Testing of insert of NULL in not NULL column

CREATE TABLE t1 (col1 INT NOT NULL, col2 CHAR(5) NOT NULL, col3 DATE NOT NULL);
INSERT INTO t1 VALUES (100, 'hello', '2004-08-20');
INSERT INTO t1 (col1,col2,col3) VALUES (101, 'hell2', '2004-08-21');
INSERT INTO t1 (col1,col2,col3) VALUES (NULL, '', '2004-01-01');
INSERT INTO t1 (col1,col2,col3) VALUES (102, NULL, '2004-01-01');
INSERT INTO t1 VALUES (103,'',NULL);
UPDATE t1 SET col1=NULL WHERE col1 =100;
UPDATE t1 SET col2 =NULL WHERE col2 ='hello';
UPDATE t1 SET col2 =NULL where col3 IS NOT NULL;
INSERT IGNORE INTO t1 values (NULL,NULL,NULL);
SELECT * FROM t1;
DROP TABLE t1;

-- Testing of default values

CREATE TABLE t1 (col1 INT NOT NULL default 99, col2 CHAR(6) NOT NULL);
INSERT INTO t1 VALUES (1, 'hello');
INSERT INTO t1 (col2) VALUES ('hello2');
INSERT INTO t1 (col2) VALUES (NULL);
INSERT INTO t1 (col1) VALUES (2);
INSERT INTO t1 VALUES(default(col1),default(col2));
INSERT INTO t1 (col1) SELECT 1;
INSERT INTO t1 SELECT 1,NULL;
INSERT IGNORE INTO t1 values (NULL,NULL);
INSERT IGNORE INTO t1 (col1) values (3);
INSERT IGNORE INTO t1 () values ();
SELECT * FROM t1;
DROP TABLE t1;

--
-- Bug #9029 Traditional: Wrong SQLSTATE returned for string truncation
--

set sql_mode='traditional';
create table t1 (charcol char(255), varcharcol varchar(255),
binarycol binary(255), varbinarycol varbinary(255), tinytextcol tinytext,
tinyblobcol tinyblob);
insert into t1 (charcol) values (repeat('x',256));
insert into t1 (varcharcol) values (repeat('x',256));
insert into t1 (binarycol) values (repeat('x',256));
insert into t1 (varbinarycol) values (repeat('x',256));
insert into t1 (tinytextcol) values (repeat('x',256));
insert into t1 (tinyblobcol) values (repeat('x',256));
select * from t1;
drop table t1;

--
-- Bug #5902: STR_TO_DATE() didn't give errors in traditional mode
--

set sql_mode='traditional';
create table t1 (col1 datetime);
insert into t1 values(STR_TO_DATE('31.10.2004 15.30 abc','%d.%m.%Y %H.%i'));
insert into t1 values(STR_TO_DATE('32.10.2004 15.30','%d.%m.%Y %H.%i'));
insert into t1 values(STR_TO_DATE('2004.12.12 22:22:33 AM','%Y.%m.%d %r'));
insert into t1 values(STR_TO_DATE('2004.12.12 abc','%Y.%m.%d %T'));
set sql_mode='';
insert into t1 values(STR_TO_DATE('31.10.2004 15.30 abc','%d.%m.%Y %H.%i'));
insert into t1 values(STR_TO_DATE('32.10.2004 15.30','%d.%m.%Y %H.%i'));
insert into t1 values(STR_TO_DATE('2004.12.12 22:22:33 AM','%Y.%m.%d %r'));
insert into t1 values(STR_TO_DATE('2004.12.12 abc','%Y.%m.%d %T'));

-- Some correct values, just to test the functions
insert into t1 values(STR_TO_DATE('31.10.2004 15.30','%d.%m.%Y %H.%i'));
insert into t1 values(STR_TO_DATE('2004.12.12 11:22:33 AM','%Y.%m.%d %r'));
insert into t1 values(STR_TO_DATE('2004.12.12 10:22:59','%Y.%m.%d %T'));

select * from t1;

-- Check that select don't abort even in strict mode (for now)
set sql_mode='traditional';

select count(*) from t1 where STR_TO_DATE('2004.12.12 10:22:61','%Y.%m.%d %T') IS NULL;

drop table t1;

--
-- Check insert with wrong CAST() (Bug #5912)
--

create table t1 (col1 char(3), col2 integer);
insert into t1 (col1) values (cast(1000 as char(3)));
insert into t1 (col1) values (cast(1000E+0 as char(3)));
insert into t1 (col1) values (cast(1000.0 as char(3)));
insert into t1 (col2) values (cast('abc' as signed integer));
insert into t1 (col2) values (10E+0 + 'a');
insert into t1 (col2) values (cast('10a' as unsigned integer));
insert into t1 (col2) values (cast('10' as unsigned integer));
insert into t1 (col2) values (cast('10' as signed integer));
insert into t1 (col2) values (10E+0 + '0 ');
select * from t1;
drop table t1;

--
-- Zero dates using numbers was not checked properly (Bug #5933 & #6145)
--

create table t1 (col1 date, col2 datetime, col3 timestamp);
insert into t1 values (0,0,0);
insert into t1 values (0.0,0.0,0.0);
insert into t1 (col1) values (convert('0000-00-00',date));
insert into t1 (col1) values (cast('0000-00-00' as date));

set sql_mode='NO_ZERO_DATE';
insert into t1 values (0,0,0);
insert into t1 values (0.0,0.0,0.0);
drop table t1;
set sql_mode='traditional';
create table t1 (col1 date);
insert ignore into t1 values ('0000-00-00');
insert into t1 select * from t1;
insert ignore into t1 values ('0000-00-00');
insert ignore into t1 (col1) values (cast('0000-00-00' as date));
insert into t1 select * from t1;
alter table t1 modify col1 datetime;
select * from t1;
drop table t1;
create table t1 (col1 datetime);
insert ignore into t1 values ('0000-00-00 00:00:00'),
                             ('0000-00-00 00:00:00'),
                             (NULL);
insert into t1 select * from t1;
select * from t1;
drop table t1;

--
-- Test of inserting an invalid value via a stored procedure (Bug #5907)
--
create table t1 (col1 tinyint);
drop procedure if exists t1;
create procedure t1 () begin declare exit handler for sqlexception
select'a';
select * from t1;
drop procedure t1;
drop table t1;

--
-- Restore mode
--
set sql_mode=@org_mode;

-- Test fields with no default value that are NOT NULL (Bug #5986)
SET @@sql_mode = 'traditional';
CREATE TABLE t1 (i int not null);
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES (DEFAULT);
INSERT INTO t1 VALUES (DEFAULT(i));
ALTER TABLE t1 ADD j int;
INSERT INTO t1 SET j = 1;
INSERT INTO t1 SET j = 1, i = DEFAULT;
INSERT INTO t1 SET j = 1, i = DEFAULT(i);
INSERT INTO t1 VALUES (DEFAULT,1);
DROP TABLE t1;
SET @@sql_mode = '';
CREATE TABLE t1 (i int not null);
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES (DEFAULT);
INSERT INTO t1 VALUES (DEFAULT(i));
ALTER TABLE t1 ADD j int;
INSERT INTO t1 SET j = 1;
INSERT INTO t1 SET j = 1, i = DEFAULT;
INSERT INTO t1 SET j = 1, i = DEFAULT(i);
INSERT INTO t1 VALUES (DEFAULT,1);
DROP TABLE t1;

--
-- Bugs #8295 and #8296: varchar and varbinary conversion
--

set @@sql_mode='traditional';
create table t1(a varchar(65537)) charset latin1;
create table t1(a varbinary(65537));

--
-- Bug #9881: problem with altering table
--

set @@sql_mode='traditional';
create table t1(a int, b date not null);
alter table t1 modify a bigint unsigned not null;
drop table t1;

--
-- Bug #5906: handle invalid date due to conversion
--
set @@sql_mode='traditional';
create table t1 (d date);
insert into t1 values ('2000-10-00');
insert into t1 values (1000);
insert into t1 values ('2000-10-01');
update t1 set d = 1100;
select * from t1;
drop table t1;

--
-- Bug #11964: alter table with timestamp field
--

set @@sql_mode='traditional';
create table t1(a int, b timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
alter table t1 add primary key(a);
drop table t1;
create table t1(a int, b timestamp not null default 20050102030405);
alter table t1 add primary key(a);
drop table t1;

--
-- BIT fields
--

set @@sql_mode='traditional';
create table t1(a bit(2));
insert into t1 values(b'101');
select * from t1;
drop table t1;

--
-- Bug#17626 CREATE TABLE ... SELECT failure with TRADITIONAL SQL mode
--
set sql_mode='traditional';
create table t1 (date date not null);
create table t2 select date from t1;
drop table t2,t1;
set @@sql_mode= @org_mode;

--
-- Bug #13934 Silent truncation of table comments
--
set @@sql_mode='traditional';
create table t1 (i int)
comment '123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*
         123456789*123456789*123456789*123456789*123456789*';
create table t1 (
i int comment
'123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*
 123456789*123456789*123456789*123456789*');
set @@sql_mode= @org_mode;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
create table t1
(i int comment
 '123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*
  123456789*123456789*123456789*123456789*');
SET sql_mode = default;
select column_name, column_comment from information_schema.columns where
table_schema = 'test' and table_name = 't1';
drop table t1;

set names utf8mb3;
create table t1 (i int)
comment '123456789*123456789*123456789*123456789*123456789*123456789*';
drop table t1;

--
-- Bug #39591: Crash if table comment is longer than 62 characters
--

--60 chars, 120 (+1) bytes (UTF-8 with 2-byte chars)
CREATE TABLE t3 (f1 INT) COMMENT 'כקבהחןכקבהחןכקבהחןכקבהחןכקבהחןכקבהחןכקבהחןכקבהחןכקבהחןכקבהחן';
DROP TABLE t3;

--
-- Bug #26359: Strings becoming truncated and converted to numbers under STRICT mode
--
set sql_mode= 'traditional';
create table t1(col1 tinyint, col2 tinyint unsigned, 
  col3 smallint, col4 smallint unsigned,
  col5 mediumint, col6 mediumint unsigned,
  col7 int, col8 int unsigned,
  col9 bigint, col10 bigint unsigned);
insert into t1(col1) values('-');
insert into t1(col2) values('+');
insert into t1(col3) values('-');
insert into t1(col4) values('+');
insert into t1(col5) values('-');
insert into t1(col6) values('+');
insert into t1(col7) values('-');
insert into t1(col8) values('+');
insert into t1(col9) values('-');
insert into t1(col10) values('+');
drop table t1;

--
-- Bug #27176: Assigning a string to an year column has unexpected results
--
set sql_mode='traditional';
create table t1(a year);
insert into t1 values ('-');
insert into t1 values ('+');
insert into t1 values ('');
insert into t1 values ('2000a');
insert into t1 values ('2E3x');
drop table t1;

--
-- Bug#27069 set with identical elements are created
--
set sql_mode='traditional';
create table t1 (f1 set('a','a'));
create table t1 (f1 enum('a','a'));

--
-- Bug #22824: strict, datetime, NULL, wrong warning
--
set @@sql_mode='NO_ZERO_DATE';
create table t1(a datetime not null);
select count(*) from t1 where a is null;
drop table t1;
SET sql_mode='NO_ZERO_DATE';
SELECT
  STR_TO_DATE('2001','%Y'),
  CONCAT(STR_TO_DATE('2001','%Y')),
  STR_TO_DATE('2001','%Y')+1;
SET @@sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,NO_ZERO_DATE,NO_ZERO_IN_DATE,STRICT_ALL_TABLES';
CREATE TABLE t1 (a DATE);
INSERT INTO t1 VALUES('0000-00-00');
INSERT IGNORE INTO t1 VALUES('0000-00-00');
SELECT * FROM t1;
INSERT INTO t1 VALUES('2004-0-30');
INSERT IGNORE INTO t1 VALUES('2004-0-30');
SELECT * FROM t1;
UPDATE t1 SET a = '0000-00-00';
UPDATE IGNORE t1 SET a = '0000-00-00';
SELECT * FROM t1;
UPDATE t1 SET a = '2004-0-30';
UPDATE IGNORE t1 SET a = '2004-0-30';
SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT IGNORE INTO t1 SELECT * FROM t1;
SELECT * FROM t1;
CREATE TABLE t2(b DATE) SELECT a FROM t1;
CREATE TABLE t2 (b DATE) IGNORE SELECT a FROM t1;
SELECT * FROM t2;
DROP TABLE t2;
INSERT INTO t1 VALUES(1/0);
INSERT IGNORE INTO t1 VALUES(1/0);
SELECT * FROM t1;
UPDATE t1 SET a = (1/0);
UPDATE IGNORE t1 SET a = (1/0);
CREATE TABLE t2(b DATE) SELECT (1/0) FROM t1;
CREATE TABLE t2 (b DATE) IGNORE SELECT (1/0) FROM t1;
SELECT * FROM t2;
DROP TABLE t1,t2;

SET @@sql_mode = 'STRICT_ALL_TABLES,ALLOW_INVALID_DATES';
CREATE TABLE t1 (a1 INT, a2 DATETIME);
UPDATE t1 SET a2={d '1789-07-14'} WHERE a1=0;
DROP TABLE t1;

SET sql_mode=@org_mode;

SET sql_mode = 'ERROR_FOR_DIVISION_BY_ZERO,STRICT_ALL_TABLES';

CREATE TABLE t1 (
Id INTEGER NOT NULL AUTO_INCREMENT,
PRIMARY KEY(Id),
c1 INTEGER NOT NULL,
c2 INTEGER NOT NULL
)|

CREATE PROCEDURE p1()
BEGIN
UPDATE t1 SET c1 = c1 / c2;

CREATE PROCEDURE p2()
BEGIN
DECLARE EXIT HANDLER
FOR SQLSTATE '23000' -- (ER_DUP_ENTRY)
BEGIN
SELECT 'Duplication handled!';

INSERT INTO t1 (Id, c1, c2) VALUES (1, 1, 0);
DROP TABLE t1;
DROP PROCEDURE p1;
DROP PROCEDURE p2;
SET sql_mode=@org_mode;
SET sql_mode='traditional';
CREATE TABLE t1 (col1 char(3));
INSERT INTO t1 VALUES(1000);
SELECT * FROM t1;
INSERT INTO t1 VALUES(cast(1000 as char(4)));
SELECT * FROM t1;
INSERT INTO t1 VALUES(cast(1000 as char(3)));
SELECT * FROM t1;
DROP TABLE t1;
SET sql_mode=@org_mode;
SET sql_mode='traditional';
CREATE TABLE t1 (col1 bigint) engine=innodb;
INSERT INTO t1 values(-9223372036854775808);
INSERT INTO t1 VALUES(-9223372036854775809);
SELECT * FROM t1;
INSERT INTO t1 VALUES(9223372036854775807);
INSERT INTO t1 VALUES(9223372036854775808);
SELECT * FROM t1;
CREATE TABLE t2 (col1 bigint unsigned);
INSERT INTO t1 VALUES(9223372036854775808);
DROP TABLE t1;
DROP TABLE t2;
SET sql_mode=@org_mode;
CREATE TABLE t1( a INT);
CREATE TABLE t2( a INT, b INT);
INSERT INTO t1 VALUES (1), (2), (3), (4);
SET sql_mode= STRICT_ALL_TABLES;
SELECT * FROM t2;
DROP TABLE t1;
DROP TABLE t2;
SET sql_mode=@org_mode;
SET sql_mode='STRICT_ALL_TABLES';
CREATE TABLE t1 (
   id TINYINT UNSIGNED NOT NULL DEFAULT 0
  ) ENGINE=MyISAM;

CREATE TRIGGER t1_BI BEFORE INSERT ON t1
FOR EACH ROW
  SET NEW.id := -1;
INSERT INTO t1 VALUES (18);
DROP trigger t1_BI;
DROP TABLE t1;
SET sql_mode=@org_mode;
SET sql_mode='STRICT_ALL_TABLES';
CREATE TABLE t1(c1 varchar(50)) engine=InnoDB;
ALTER TABLE t1 ADD KEY in_c1(c1);
ALTER TABLE t1 ADD KEY in_c2(c1);
DROP TABLE t1;

CREATE TABLE t1 ( a datetime(2) );
CREATE TABLE t2 ( a timestamp(2) );

SELECT str_to_date('09:22', '%H:%i');
SELECT str_to_date('09:22:23.33', '%H:%i:%s.%f');

INSERT INTO t1 VALUES( str_to_date('09:22', '%H:%i') );
INSERT INTO t1 VALUES( str_to_date('09:22:23.33', '%H:%i:%s.%f') );
SELECT timediff( a, cast(CURRENT_DATE AS datetime) ) FROM t1;
DELETE FROM t1;
INSERT INTO t1 VALUES( str_to_date('2019-12-31', '%Y-%m-%d') );

SELECT * FROM t1;

INSERT INTO t2 VALUES( str_to_date('09:22', '%H:%i') );
INSERT INTO t2 VALUES( str_to_date('09:22:23.33', '%H:%i:%s.%f') );
SELECT timediff( a, cast(CURRENT_DATE AS datetime) ) FROM t2;
DELETE FROM t2;
INSERT INTO t2 VALUES( str_to_date('2019-12-31', '%Y-%m-%d') );

CREATE TABLE t3 SELECT str_to_date('09:22:23.33', '%H:%i:%s.%f');

SELECT * FROM t2;

DROP TABLE t1, t2, t3;

SET sql_mode='NO_ZERO_DATE';
select str_to_date('0000-00-00', '%Y-%m-%d');
select str_to_date('0000-01-00', '%Y-%m-%d');
select str_to_date('0000-00-01', '%Y-%m-%d');
select str_to_date('2023-02-31', '%Y-%m-%d');

SET sql_mode='NO_ZERO_IN_DATE';
select str_to_date('0000-00-00', '%Y-%m-%d');
select str_to_date('0000-01-00', '%Y-%m-%d');
select str_to_date('0000-00-01', '%Y-%m-%d');
select str_to_date('2023-02-31', '%Y-%m-%d');

SET sql_mode='ALLOW_INVALID_DATES';
select str_to_date('0000-00-00', '%Y-%m-%d');
select str_to_date('0000-01-00', '%Y-%m-%d');
select str_to_date('0000-00-01', '%Y-%m-%d');
select str_to_date('2023-02-31', '%Y-%m-%d');

SET sql_mode=@org_mode;
