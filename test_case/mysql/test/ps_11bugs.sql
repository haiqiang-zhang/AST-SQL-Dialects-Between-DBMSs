--                                             #
--   Prepared Statements                       #
--   re-testing bug DB entries                 #
--                                             #
-- The bugs are reported as "closed".          #
-- Command sequences taken from bug report.    #
-- No other test contains the bug# as comment. #
--                                             #
-- Tests drop/create tables 't1', 't2', ...    #
--                                             #
--##############################################

--disable_warnings
drop table if exists t1, t2;

-- bug#1180: optimized away part of WHERE clause cause incorect prepared satatement results

CREATE TABLE t1(session_id  char(9) NOT NULL);
INSERT INTO t1 VALUES ("abc");
SELECT * FROM t1;

-- Must not find a row
set @arg1= 'abc';

-- Now, it should find one row
set @arg1= '1111';

-- Back to non-matching
set @arg1= 'abc';

drop table t1;

-- end of bug#1180


-- bug#1644: Insertion of more than 3 NULL columns with parameter binding fails

-- Using prepared statements, insertion of more than three columns with NULL
-- values fails to insert additional NULLS.  After the third column NULLS will
-- be inserted into the database as zeros.
-- First insert four columns of a value (i.e. 22) to verify binding is working
-- correctly.  Then Bind to each columns bind parameter an is_null value of 1.
-- Then insert four more columns of integers, just for sanity.
-- A subsequent select on the server will result in this:
-- mysql> select * from foo_dfr;

-- Test is extended to more columns - code stores bit vector in bytes.

create table t1 (
  c_01 char(6), c_02 integer, c_03 real, c_04 int(3), c_05 varchar(20),
  c_06 date,    c_07 char(1), c_08 real, c_09 int(11), c_10 time,
  c_11 char(6), c_12 integer, c_13 real, c_14 int(3), c_15 varchar(20),
  c_16 date,    c_17 char(1), c_18 real, c_19 int(11), c_20 text);

set @arg01= 'row_1';
set @arg06= '2004-10-12';
set @arg11= 'row_1';
set @arg16= '2004-10-12';
                      @arg11, @arg12, @arg13, @arg14, @arg15, @arg16, @arg17, @arg18, @arg19, @arg20;

set @arg01= NULL;
set @arg06= NULL;
set @arg11= NULL;
set @arg16= NULL;
                      @arg11, @arg12, @arg13, @arg14, @arg15, @arg16, @arg17, @arg18, @arg19, @arg20;

set @arg01= 'row_3';
set @arg06= '2004-10-12';
set @arg11= 'row_3';
set @arg16= '2004-10-12';
                      @arg11, @arg12, @arg13, @arg14, @arg15, @arg16, @arg17, @arg18, @arg19, @arg20;

select * from t1;

drop table t1;

-- end of bug#1644


-- bug#1676: Prepared statement two-table join returns no rows when one is expected

create table t1(
   cola varchar(50) not null,
   colb varchar(8) not null,
   colc varchar(12) not null,
   cold varchar(2) not null,
   primary key (cola, colb, cold));

create table t2(
   cola varchar(50) not null,
   colb varchar(8) not null,
   colc varchar(2) not null,
   cold float,
   primary key (cold));

insert into t1 values ('aaaa', 'yyyy', 'yyyy-dd-mm', 'R');

insert into t2 values ('aaaa', 'yyyy', 'R', 203), ('bbbb', 'zzzz', 'C', 201);

set @arg0= "aaaa";
set @arg1= "yyyy";
set @arg2= "R";

drop table t1, t2;

-- end of bug#1676

-- End of 4.1 tests

-- bug#18492: mysqld reports ER_ILLEGAL_REFERENCE in --ps-protocol

create table t1 (a int primary key);
insert into t1 values (1);

select * from t1 where 3 in (select (1+1) union select 1);

drop table t1;

--
-- Bug#19356: Assertion failure with undefined @uservar in prepared statement execution
-- 
create table t1 (a int, b varchar(4));
create table t2 (a int, b varchar(4), primary key(a));

set @intarg= 11;
set @varchararg= '2222';
set @intarg= 12;
set @intarg= 13;
set @intarg= 14;
set @nullarg= Null;

select * from t1;
select * from t2;

drop table t1;
drop table t2;

--
-- Bug #32124: crash if prepared statements refer to variables in the where
-- clause
--

CREATE TABLE t1 (a INT);
DROP TABLE t1;

CREATE TABLE t2 (a INT PRIMARY KEY);
INSERT INTO t2 VALUES (400000), (400001);

SET @@sort_buffer_size=400000;

CREATE FUNCTION p1(i INT) RETURNS INT
BEGIN
  SET @@sort_buffer_size= i;

SELECT * FROM t2 WHERE a = @@sort_buffer_size AND p1(@@sort_buffer_size + 1) > a - 1;

DROP TABLE t2;
DROP FUNCTION p1;


SELECT CONCAT(@@sort_buffer_size);
SELECT LEFT("12345", @@ft_boolean_syntax);

SET @@sort_buffer_size=DEFAULT;

CREATE USER test_user1@'localhost';

-- valid user, value password, both prepare and execute should succeed
PREPARE stmt FROM "SET PASSWORD FOR test_user1@'localhost' = 'SoSecret'";

-- invalid user, should fail
--error ER_PARSE_ERROR
SET PASSWORD FOR @'localhost' = 'SoSecret';

-- invalid value, should fail
--error ER_PARSE_ERROR
SET PASSWORD FOR test_user1@'localhost' = NULL;

-- user does not exist, prepare should pass, execute should fail
PREPARE stmt FROM "SET PASSWORD FOR test_user2@'localhost' = 'SoSecret'";

DROP USER test_user1@'localhost';

create table t6(a decimal(3,2));
insert into t6 values(6.2);
set @a=8;
set @a=5;
drop table t6;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
                   WHERE EXISTS (SELECT * FROM mysql.user LIMIT 1)";
                   WHERE EXISTS (SELECT * FROM mysql.user LIMIT 1)";
DROP TABLE t1;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
