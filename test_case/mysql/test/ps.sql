
SET @old_log_output=@@global.log_output;
SET GLOBAL log_output="FILE,TABLE";
drop table if exists t1,t2,t3,t4;

-- Avoid wrong warnings if mysql_client_test fails
drop database if exists client_test_db;

create table t1
(
  a int primary key,
  b char(10)
);
insert into t1 values (1,'one');
insert into t1 values (2,'two');
insert into t1 values (3,'three');
insert into t1 values (4,'four');

-- basic functionality
set @a=2;
set @a=3;

-- non-existant statement
--error 1243
deallocate prepare no_such_statement;

-- Nesting ps commands is not allowed: 
--error ER_UNSUPPORTED_PS 
prepare stmt2 from 'prepare nested_stmt from "select 1"';

-- PS insert 
prepare stmt3 from 'insert into t1 values (?,?)';
set @arg1=5, @arg2='five';
select * from t1 where a>3;

-- PS update 
prepare stmt4 from 'update t1 set a=? where b=?';
set @arg1=55, @arg2='five';
select * from t1 where a>3;

-- PS create/delete
prepare stmt4 from 'create table t2 (a int)';

-- Do something that will cause error
--error 1051
execute stmt4;

-- placeholders in result field names.
prepare stmt5 from 'select ? + a from t1';
set @a=1;

set @nullvar=1;
set @nullvar=NULL;

set @nullvar2=NULL;

-- Check that multiple SQL statements are disabled inside PREPARE
--error 1064
prepare stmt6 from 'select 1;

-- This shouldn't parse
--error 1064
explain prepare stmt6 from 'insert into t1 values (5,"five");

create table t2
(
  a int
);

insert into t2 values (0);

-- parameter is NULL
set @arg00=NULL ;

-- prepare using variables:
--error 1064
prepare stmt1 from @nosuchvar;

set @ivar= 1234;

set @fvar= 123.4567;

drop table t1,t2;

--
-- Bug #4105: Server crash on attempt to prepare a statement with character
-- set introducer
--
PREPARE stmt1 FROM "select _utf8mb3 'A' COLLATE utf8mb3_bin = ?";
set @var='A';

--
-- BUG#3486:  FOUND_ROWS() fails inside stored procedure [and prepared statement]
--
create table t1 (id int);
select SQL_CALC_FOUND_ROWS * from t1;
insert into t1 values (1);
select SQL_CALC_FOUND_ROWS * from t1;
drop table t1;

--
-- prepared EXPLAIN
--
create table t1 
(
  c1  tinyint, c2  smallint, c3  mediumint, c4  int,
  c5  integer, c6  bigint, c7  float, c8  double,
  c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4),
  c13 date, c14 datetime, c15 timestamp, c16 time,
  c17 year, c18 bit, c19 bool, c20 char,
  c21 char(10), c22 varchar(30), c23 tinyblob, c24 tinytext,
  c25 blob, c26 text, c27 mediumblob, c28 mediumtext,
  c29 longblob, c30 longtext, c31 enum('one', 'two', 'three'),
  c32 set('monday', 'tuesday', 'wednesday')
) engine = MYISAM ;
create table t2 like t1;

set @stmt= ' explain SELECT (SELECT SUM(c1 + c12 + 0.0) FROM t2 where (t1.c2 - 0e-3) = t2.c2 GROUP BY t1.c15 LIMIT 1) as scalar_s, exists (select 1.0e+0 from t2 where t2.c3 * 9.0000000000 = t1.c4) as exists_s, c5 * 4 in (select c6 + 0.3e+1 from t2) as in_s, (c7 - 4, c8 - 4) in (select c9 + 4.0, c10 + 40e-1 from t2) as in_row_s FROM t1, (select c25 x, c32 y from t2) tt WHERE x * 1 = c25 ' ;
drop tables t1,t2;

--
-- parameters from variables (for field creation)
--
set @arg00=1;
select m from t1;
drop table t1;
select m from t1;
drop table t1;

--
-- eq() for parameters
--
create table t1 (id int(10) unsigned NOT NULL default '0',
                 name varchar(64) NOT NULL default '',
                 PRIMARY KEY  (id), UNIQUE KEY `name` (`name`));
insert into t1 values (1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7');
set @id1=1,@id2=6;
select name from t1 where id=1 or id=6;
drop table t1;

--
-- SHOW TABLE STATUS test
--
create table t1 ( a int primary key, b varchar(30)) engine = MYISAM ;
drop table t1;

--
-- Bug#4912 "mysqld crashs in case a statement is executed a second time":
-- negation elimination should work once and not break prepared statements
-- 

create table t1(a varchar(2), b varchar(3));
drop table t1;

--
-- Bug#5034 "prepared "select 1 into @arg15", second execute crashes
-- server".
-- Check that descendands of select_result can be reused in prepared 
-- statements or are correctly created and deleted on each execute
--

--let $outfile=$MYSQLTEST_VARDIR/tmp/f1.txt
--error 0,1
--remove_file $outfile

prepare stmt1 from "select 1 into @var";
drop table t1;
drop table t1;

-- 
-- BUG#5242 "Prepared statement names are case sensitive"
--
prepare stmt1 from 'select 1';

-- also check that statement names are in right charset.
set names utf8mb3;
set names latin1;
set names default;


-- 
-- BUG#4368 "select * from t1 where a like ?" crashes server if a is in utf8mb3
-- and ? is in latin1
-- Check that Item converting latin1 to utf8mb3 (for LIKE function) is created
-- in memory of prepared statement.
--

create table t1 (a varchar(10)) charset=utf8mb3;
insert into t1 (a) values ('yahoo');
set character_set_connection=latin1;
set @var='google';
drop table t1;

-- 
-- BUG#5510 "inserting Null in AutoIncrement primary key Column Fails" 
-- (prepared statements) 
-- The cause: misuse of internal MySQL 'Field' API.
-- 

create table t1 (a bigint(20) not null primary key auto_increment);
insert into t1 (a) values (null);
select * from t1;
set @var=null;
select * from t1;
drop table t1;
create table t1 (a timestamp not null);
select * from t1;
drop table t1;

-- 
-- BUG#5688 "Upgraded 4.1.5 Server seg faults" # (prepared statements)
-- The test case speaks for itself.
-- Just another place where we used wrong memory root for Items created
-- during statement prepare.
-- 
prepare stmt from "select 'abc' like convert('abc' using utf8mb3)";

-- 
-- BUG#5748 "Prepared statement with BETWEEN and bigint values crashes
-- mysqld". Just another place where an item tree modification must be 
-- rolled back.
-- 
create table t1 ( a bigint );
set @a=1;
drop table t1;

--
-- Bug #5987 subselect in bool function crashes server (prepared statements):
-- don't overwrite transformed subselects with old arguments of a bool
-- function.
--
create table t1 (a int);
drop table t1;

--
-- Test case for Bug#6042 "constants propogation works only once (prepared
-- statements): check that the query plan changes whenever we change
-- placeholder value.
--
create table t1 (a int, b int) engine = myisam;
insert into t1 (a, b) values (1,1), (1,2), (2,1), (2,2);
set @v=5;
set @v=0;
set @v=5;
drop table t1;

--
-- A test case for Bug#5985 prepare stmt from "select rand(?)" crashes
-- server. Check that Item_func_rand is prepared-statements friendly.
--
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4);
set @precision=10000000000;
select rand(), 
       cast(rand(10)*@precision as unsigned integer) from t1;
        cast(rand(10)*@precision as unsigned integer),
        cast(rand(?)*@precision as unsigned integer) from t1";
set @var=1;
set @var=2;
set @var=3;
drop table t1;

--
-- A test case for Bug#6050 "EXECUTE stmt reports ambiguous fieldnames with
-- identical tables from different schemata"
-- Check that field name resolving in prepared statements works OK.
--
create database mysqltest1;
create table t1 (a int);
create table mysqltest1.t1 (a int);
select * from t1, mysqltest1.t1;
drop table t1;
drop table mysqltest1.t1;
drop database mysqltest1;
select '1.1' as a, '1.2' as a UNION SELECT '2.1', '2.2';

--
-- Test CREATE TABLE ... SELECT (Bug #6094)
--
create table t1 (a int);
insert into t1 values (1),(2),(3);
create table t2 select * from t1;
drop table t2;
drop table t2;
drop table t2;
drop table t1,t2;

--
-- Bug#6088 "FOUND_ROWS returns wrong values for prepared statements when
-- LIMIT is used"
-- 
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
select found_rows();
select found_rows();
select found_rows();
drop table t1;

--
-- Bug#6047 "permission problem when executing mysql_stmt_execute with derived
-- table"
--

CREATE TABLE t1 (N int, M tinyint);
INSERT INTO t1 VALUES (1,0),(1,0),(2,0),(2,0),(3,0);
DROP TABLE t1;

-- 
-- Bug#6297 "prepared statement, wrong handling of <parameter> IS NULL"
-- Test that placeholders work with IS NULL/IS NOT NULL clauses. 
--
prepare stmt from "select ? is null, ? is not null, ?";
select @no_such_var is null, @no_such_var is not null, @no_such_var;
set @var='abc';
select @var is null, @var is not null, @var;
set @var=null;
select @var is null, @var is not null, @var;

-- 
-- Bug#6873 "PS, having with subquery, crash during execute"
-- check that if we modify having subtree, we update JOIN->having pointer
--
create table t1 (pnum char(3));
create table t2 (pnum char(3));
drop table t1, t2;

--
--
-- Bug#19399 "Stored Procedures 'Lost Connection' when dropping/creating
--            tables"
-- Check that multi-delete tables are also cleaned up before re-execution.
-- 
--disable_warnings
drop table if exists t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;

-- Bug#6102 "Server crash with prepared statement and blank after
-- function name"
-- ensure that stored functions are cached when preparing a statement
-- before we open tables
--
create table t1 (a varchar(20));
insert into t1 values ('foo');
drop table t1;

--
-- Bug #6089: FOUND_ROWS returns wrong values when no table/view is used 
--

prepare stmt from "SELECT SQL_CALC_FOUND_ROWS 'foo' UNION SELECT 'bar' LIMIT 0";
SELECT FOUND_ROWS();
SELECT FOUND_ROWS();

--
-- Bug#9096 "select doesn't return all matched records if prepared statements
-- is used"
-- The bug was is bad co-operation of the optimizer's algorithm which determines
-- which keys can be used to execute a query, constants propagation
-- part of the optimizer and parameter markers used by prepared statements.

drop table if exists t1;
create table t1 (c1 int(11) not null, c2 int(11) not null,
             primary key  (c1,c2), key c2 (c2), key c1 (c1));

insert into t1 values (200887, 860);
insert into t1 values (200887, 200887);

select * from t1 where (c1=200887 and c2=200887) or c2=860;
set @a=200887, @b=860;

drop table t1;

--
-- Bug#9777 - another occurrence of the problem stated in Bug#9096:
-- we can not compare basic constants by their names, because a placeholder
-- is a basic constant while his name is always '?'
--

create table t1 (
   id bigint(20) not null auto_increment,
   code varchar(20) character set utf8mb3 COLLATE utf8mb3_bin not null default '',
   company_name varchar(250) character set utf8mb3 COLLATE utf8mb3_bin default null,
   setup_mode tinyint(4) default null,
   start_date datetime default null,
   primary key  (id), unique key code (code)
);

create table t2 (
   id bigint(20) not null auto_increment,
   email varchar(250) character set utf8mb3 COLLATE utf8mb3_bin default null,
   name varchar(250) character set utf8mb3 COLLATE utf8mb3_bin default null,
   t1_id bigint(20) default null,
   password varchar(250) character set utf8mb3 COLLATE utf8mb3_bin default null,
   primary_contact tinyint(4) not null default '0',
   email_opt_in tinyint(4) not null default '1',
   primary key  (id), unique key email (email), key t1_id (t1_id),
   constraint t2_fk1 foreign key (t1_id) references t1 (id)
);

insert into t1 values
(1, 'demo', 'demo s', 0, current_date()),
(2, 'code2', 'name 2', 0, current_date()),
(3, 'code3', 'name 3', 0, current_date());

insert into t2 values
(2, 'email1', 'name1', 3, 'password1', 0, 0),
(3, 'email2', 'name1', 1, 'password2', 1, 0),
(5, 'email3', 'name3', 2, 'password3', 0, 0);
set @a=1;

select t2.id from t2, t1 where (t1.id=1 and t2.t1_id=t1.id);
drop table t2, t1;

--
-- Bug#11060 "Server crashes on calling stored procedure with INSERT SELECT
-- UNION SELECT" aka "Server crashes on re-execution of prepared INSERT ...
-- SELECT with UNION".
--
create table t1 (id int);
drop table t1;
create table t1 (
  id int(11) unsigned not null primary key auto_increment,
  partner_id varchar(35) not null,
  t1_status_id int(10) unsigned
);

insert into t1 values ("1", "partner1", "10"), ("2", "partner2", "10"),
                      ("3", "partner3", "10"), ("4", "partner4", "10");

create table t2 (
  id int(11) unsigned not null default '0',
  t1_line_id int(11) unsigned not null default '0',
  article_id varchar(20),
  sequence int(11) not null default '0',
  primary key  (id,t1_line_id)
);

insert into t2 values ("1", "1", "sup", "0"), ("2", "1", "sup", "1"),
                      ("2", "2", "sup", "2"), ("2", "3", "sup", "3"),
                      ("2", "4", "imp", "4"), ("3", "1", "sup", "0"),
                      ("4", "1", "sup", "0");

create table t3 (
  id int(11) not null default '0',
  preceding_id int(11) not null default '0',
  primary key  (id,preceding_id)
);

create table t4 (
  user_id varchar(50) not null,
  article_id varchar(20) not null,
  primary key  (user_id,article_id)
);

insert into t4 values("nicke", "imp");
     left join t1 pp on pp.id = t3.preceding_id
where
  exists (
    select *
    from t2 as pl_inner
    where pl_inner.id = t1.id
    and pl_inner.sequence <= (
      select min(sequence) from t2 pl_seqnr
      where pl_seqnr.id = t1.id
    )
    and exists (
      select * from t4
      where t4.article_id = pl_inner.article_id
      and t4.user_id = ?
    )
  )
  and t1.id = ?
group by t1.id
having count(pp.id) = 0';
set @user_id = 'nicke';
set @id = '2';
drop table t1, t2, t3, t4;
set @a='CHRISTINE           ';
set @b='CHRISTINE';
set @a=1, @b=2;
set @a='CHRISTINE           ';
set @b='CHRISTINE';
create table t1 (a int);
select ?;
select ??;
select ? from t1;
drop table t1;
set @@time_zone:='Japan';
set transaction isolation level read committed;
set transaction isolation level serializable;
set @@transaction_isolation=default;

--
-- Bug#14410 "Crash in Enum or Set type in CREATE TABLE and PS/SP"
--
-- Part I. Make sure the typelib for ENUM is created in the statement memory
-- root.
prepare stmt from "create temporary table t1 (letter enum('','a','b','c')
not null)";
drop table t1;
drop table t1;
drop table t1;
set names latin1;
drop table t1;
drop table t1;
drop table t1;
set names default;

--
-- A test case for Bug#12734 "prepared statement may return incorrect result
-- set for a select SQL request": test that canDoTurboBM is reset for each
-- execute of a prepared statement.
--
create table t1 (
  word_id mediumint(8) unsigned not null default '0',
  formatted varchar(20) not null default ''
);

insert into t1 values
  (80,'pendant'), (475,'pretendants'), (989,'tendances'),
  (1019,'cependant'),(1022,'abondance'),(1205,'independants'),
  (13,'lessiver'),(25,'lambiner'),(46,'situer'),(71,'terminer'),
  (82,'decrocher');

select count(*) from t1 where formatted like '%NDAN%';
select count(*) from t1 where formatted like '%ER';
set @like="%NDAN%";
set @like="%ER";
set @like="%NDAN%";
set @like="%ER";
drop table t1;

--
-- Bug#13134 "Length of VARCHAR() utf8mb3 column is increasing when table is
-- recreated with PS/SP"
--
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
insert into t1 (a) values (repeat('a', 20));
select length(a) from t1;
drop table t1;
insert into t1 (a) values (repeat('a', 20));
select length(a) from t1;
drop table t1;
SET sql_mode = default;
create table t1 (col1 integer, col2 integer);
insert into t1 values(100,100),(101,101),(102,102),(103,103);
set @a=100, @b=100;
set @a=101, @b=101;
set @a=102, @b=102;
set @a=102, @b=103;
drop table t1;

--
-- Bug#16365 Prepared Statements: DoS with too many open statements
-- Check that the limit @@max_prpeared_stmt_count works.
--
-- This is also the test for bug#23159 prepared_stmt_count should be
-- status variable.
--
-- Save the old value
set @old_max_prepared_stmt_count= @@max_prepared_stmt_count;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=-1;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=10000000000000000;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=default;
select @@max_prepared_stmt_count;
set @@max_prepared_stmt_count=1;
set max_prepared_stmt_count=1;
set local max_prepared_stmt_count=1;
set global max_prepared_stmt_count=1;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=0;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=1;
select @@max_prepared_stmt_count;
set global max_prepared_stmt_count=0;
set global max_prepared_stmt_count=3;
select @@max_prepared_stmt_count;

-- Switch to connection con1
connection con1;
let $con1_id=`SELECT CONNECTION_ID()`;
select @@max_prepared_stmt_count;

-- Disconnect connection con1 and switch to default connection
disconnect con1;

-- Wait for the connection con1 to die
let $wait_condition=SELECT COUNT(*)=0 FROM information_schema.processlist WHERE id=$con1_id;

select @@max_prepared_stmt_count;
set global max_prepared_stmt_count= @old_max_prepared_stmt_count;


--
-- Bug#19399 "Stored Procedures 'Lost Connection' when dropping/creating
--            tables"
-- Check that multi-delete tables are also cleaned up before re-execution.
-- 
--disable_warnings
drop table if exists t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;
create temporary table if not exists t1 (a1 int);
drop temporary table t1;


--
-- BUG#22085: Crash on the execution of a prepared statement that
--            uses an IN subquery with aggregate functions in HAVING 
--

CREATE TABLE t1(
  ID int(10) unsigned NOT NULL auto_increment,
  Member_ID varchar(15) NOT NULL default '',
  Action varchar(12) NOT NULL,
  Action_Date datetime NOT NULL,
  Track varchar(15) default NULL,
  User varchar(12) default NULL,
  Date_Updated timestamp NOT NULL default CURRENT_TIMESTAMP on update
    CURRENT_TIMESTAMP,
  PRIMARY KEY (ID),
  KEY Action (Action),
  KEY Action_Date (Action_Date)
);

INSERT INTO t1(Member_ID, Action, Action_Date, Track) VALUES
  ('111111', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('111111', 'Enrolled', '2006-03-01', 'CAD' ),
  ('111111', 'Disenrolled', '2006-07-03', 'CAD' ),
  ('222222', 'Enrolled', '2006-03-07', 'CAD' ),
  ('222222', 'Enrolled', '2006-03-07', 'CHF' ),
  ('222222', 'Disenrolled', '2006-08-02', 'CHF' ),
  ('333333', 'Enrolled', '2006-03-01', 'CAD' ),
  ('333333', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('444444', 'Enrolled', '2006-03-01', 'CAD' ),
  ('555555', 'Disenrolled', '2006-03-01', 'CAD' ),
  ('555555', 'Enrolled', '2006-07-21', 'CAD' ),
  ('555555', 'Disenrolled', '2006-03-01', 'CHF' ),
  ('666666', 'Enrolled', '2006-02-09', 'CAD' ),
  ('666666', 'Enrolled', '2006-05-12', 'CHF' ),
  ('666666', 'Disenrolled', '2006-06-01', 'CAD' );
        (Track,Action_Date) IN (SELECT Track, MAX(Action_Date) FROM t1
                                  WHERE Member_ID=?
                                    GROUP BY Track 
                                      HAVING Track>='CAD' AND
                                             MAX(Action_Date)>'2006-03-01')";
SET @id='111111';
SET @id='222222';
DROP TABLE t1;

--
-- BUG#21354: (COUNT(*) = 1) not working in SELECT inside prepared
-- statement 
--
--disable_warnings
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (i INT, INDEX(i));
INSERT INTO t1 VALUES (1);
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
SET @a = 0;
SET @a = 1;
SET @a = 0;
DROP TABLE t1;

--
-- Bug#19182: CREATE TABLE bar (m INT) SELECT n FROM foo;
--

CREATE TABLE t1 (i INT);

DROP TABLE t2;

-- Check that on second execution we don't loose 'j' column and the keys
-- on 'i' and 'j' columns.
EXECUTE st_19182;
DROP TABLE t2, t1;

--
-- Bug #22060 "ALTER TABLE x AUTO_INCREMENT=y in SP crashes server"
--
-- Code which implemented CREATE/ALTER TABLE and CREATE DATABASE
-- statement modified HA_CREATE_INFO structure in LEX, making these
-- statements PS/SP-unsafe (their re-execution might have resulted
-- in incorrect results).
--
--disable_warnings
drop database if exists mysqltest;
drop table if exists t1, t2;
create database mysqltest character set utf8mb3;
drop table mysqltest.t1;
drop table mysqltest.t2;
alter database mysqltest character set latin1;
drop database mysqltest;
drop table t1;
drop table t1;
--

--
-- Bug #27937: crash on the second execution for prepared statement 
--             from UNION with ORDER BY an expression containing RAND()
--

CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (2), (3), (1);
DROP TABLE t1;


--
-- Bug #32137: prepared statement crash with str_to_date in update clause
--
create table t1 (a int, b tinyint);
drop table t1;
create table t1 (a varchar(20));
insert into t1 values ('foo');
drop table t1;

--
-- Bug#8115: equality propagation and prepared statements
--

create table t1 (a char(3) not null, b char(3) not null,
                 c char(3) not null, primary key  (a, b, c));
create table t2 like t1;

-- reduced query
prepare stmt from
  "select t1.a from (t1 left outer join t2 on t2.a=1 and t1.b=t2.b)
  where t1.a=1";

-- original query
prepare stmt from
"select t1.a, t1.b, t1.c, t2.a, t2.b, t2.c from
(t1 left outer join t2 on t2.a=? and t1.b=t2.b)
left outer join t2 t3 on t3.a=? where t1.a=?";

set @a:=1, @b:=1, @c:=1;

drop table t1,t2;


--
-- Bug#9383: INFORMATION_SCHEMA.COLUMNS, JOIN, Crash, prepared statement
--

eval SET @aux= "SELECT COUNT(*)
                FROM INFORMATION_SCHEMA.COLUMNS A,
                INFORMATION_SCHEMA.COLUMNS B
                WHERE A.TABLE_SCHEMA = B.TABLE_SCHEMA
                AND A.TABLE_NAME = B.TABLE_NAME
                AND A.COLUMN_NAME = B.COLUMN_NAME AND
                A.TABLE_NAME = 'user'";

let $exec_loop_count= 3;
{
  eval execute my_stmt;
  dec $exec_loop_count;

-- Test CALL in prepared mode
delimiter |;
drop procedure if exists p1|
drop table if exists t1|
--enable_warnings
create table t1 (id int)|
insert into t1 values(1)|
create procedure p1(a int, b int)
begin
  declare c int;
  select max(id)+1 into c from t1;
  insert into t1 select a+b;
  insert into t1 select a-b;
  insert into t1 select a-c;
set @a= 3, @b= 4|
prepare stmt from "call p1(?, ?)"|
execute stmt using @a, @b|
execute stmt using @a, @b|
select * from t1|
deallocate prepare stmt|
drop procedure p1|
drop table t1|
delimiter ;


--
-- Bug#7306 LIMIT ?, ? and also WL#1785 " Prepared statements: implement
-- support for placeholders in LIMIT clause."
-- Add basic test coverage for the feature.
-- 
create table t1 (a int);
insert into t1 (a) values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
set @offset=0, @limit=1;
select * from t1 limit 0, 1;
set @offset=3, @limit=2;
select * from t1 limit 3, 2;
set @offset=9;
set @limit=2;
                   (select * from t1 limit ?, ?) order by a limit ?";

drop table t1;

--
-- Bug#12651
-- (Crash on a PS including a subquery which is a select from a simple view)
--
CREATE TABLE b12651_T1(a int) ENGINE=MYISAM;
CREATE TABLE b12651_T2(b int) ENGINE=MYISAM;
CREATE VIEW  b12651_V1 as SELECT b FROM b12651_T2;

DROP VIEW b12651_V1;
DROP TABLE b12651_T1, b12651_T2;



--
-- Bug #14956: ROW_COUNT() returns incorrect result after EXECUTE of prepared
-- statement
--
create table t1 (id int);
select row_count();
drop table t1;

--
-- BUG#16474: SP crashed MySQL
-- (when using "order by localvar", where 'localvar' is just that.
-- The actual bug test is in sp.test, this is just testing that we get the
-- expected result for prepared statements too, i.e. place holders work as
-- textual substitution. If it's a single integer, it works as the (deprecated)
-- "order by column#", otherwise it's an expression.
--
create table t1 (a int, b int);
insert into t1 (a,b) values (2,8),(1,9),(3,7);

-- Will order by index
prepare stmt from "select * from t1 order by ?";
set @a=NULL;
set @a=1;
set @a=2;
select * from t1 order by 1;

-- Will not order by index.
prepare stmt from "select * from t1 order by ?+1";
set @a=0;
set @a=1;
select * from t1 order by 1+1;

drop table t1;

--
-- Bug#19308 "REPAIR/OPTIMIZE/ANALYZE supported in SP but not in PS".
-- Add test coverage for the added commands.
--
create table t1 (a int) engine=myisam;
create table t2 like t1;
create table t3 like t2;
drop table t1, t2, t3;

--
-- Bug#17199 "Table not found" error occurs if the query contains a call
--            to a function from another database.
--            Test prepared statements- related behaviour.
--
--
-- ALTER TABLE RENAME and Prepared Statements: wrong DB name buffer was used
-- in ALTER ... RENAME which caused memory corruption in prepared statements.
-- No need to fix this problem in 4.1 as ALTER TABLE is not allowed in
-- Prepared Statements in 4.1.
--
create database mysqltest_long_database_name_to_thrash_heap;
use test;
create table t1 (i int);
use mysqltest_long_database_name_to_thrash_heap;
use test;
use mysqltest_long_database_name_to_thrash_heap;
-- 
use mysqltest_long_database_name_to_thrash_heap;
drop table t1;
use test;
use mysqltest_long_database_name_to_thrash_heap;
use test;
select * from mysqltest_long_database_name_to_thrash_heap.t1;
select * from mysqltest_long_database_name_to_thrash_heap.t1;
use mysqltest_long_database_name_to_thrash_heap;
drop database mysqltest_long_database_name_to_thrash_heap;
create temporary table t1 (i int);
use test;


--
-- BUG#21166: Prepared statement causes signal 11 on second execution
--
-- Changes in an item tree done by optimizer weren't properly
-- registered and went unnoticed, which resulted in preliminary freeing
-- of used memory.
--

CREATE TABLE t1 (i BIGINT, j BIGINT);
CREATE TABLE t2 (i BIGINT);
CREATE TABLE t3 (i BIGINT, j BIGINT);
                   LEFT JOIN t3 ON ((t3.i, t3.j) = (t1.i, t1.j))
                   WHERE t1.i = ?";

SET @a= 1;
DROP TABLE IF EXISTS t1, t2, t3;


--
-- BUG#21081: SELECT inside stored procedure returns wrong results
--

CREATE TABLE t1 (i INT KEY);
CREATE TABLE t2 (i INT);

INSERT INTO t1 VALUES (1), (2);
INSERT INTO t2 VALUES (1);
                   WHERE t1.i = ?";

SET @arg= 1;
SET @arg= 2;
SET @arg= 1;
DROP TABLE t1, t2;


--
-- BUG#20327: Marking of a wrong field leads to a wrong result on select with
--            view, prepared statement and subquery.
--
CREATE TABLE t1 (i INT);
CREATE VIEW v1 AS SELECT * FROM t1;

INSERT INTO t1 VALUES (1), (2);

let $query = SELECT t1.i FROM t1 JOIN v1 ON t1.i = v1.i
             WHERE EXISTS (SELECT * FROM t1 WHERE v1.i = 1);
DROP VIEW v1;
DROP TABLE t1;


--
-- BUG#21856: Prepared Statments: crash if bad create
--

let $iterations= 100;
{
  --error ER_PARSE_ERROR
  PREPARE stmt FROM "CREATE PROCEDURE p1()";
  dec $iterations;

--
-- Bug 25027: query with a single-row non-correlated subquery
--            and IS NULL predicate
--

CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);
CREATE TABLE t2 (b int);
INSERT INTO t2 VALUES (NULL);

SELECT a FROM t1 WHERE (SELECT b FROM t2) IS NULL;
SET @arg=1;

DROP TABLE t1,t2;
create table t1 (s1 char(20));
drop table t1;

--
-- Bug#6895 "Prepared Statements: ALTER TABLE DROP COLUMN does nothing"
--
create table t1 (a int, b int);
drop table t1;
create table t1 (a int, b int);
drop table t1;
create table t1 (a int, b int);
drop table t1;

--
-- Bug #22060 "ALTER TABLE x AUTO_INCREMENT=y in SP crashes server"
--
-- 5.0 part of the test.
--

-- ALTER TABLE
create table t1 (i int primary key auto_increment) comment='comment for table t1';
create table t2 (i int, j int, k int);
select * from t2;
drop table t1, t2;
set @old_character_set_server= @@character_set_server;
set @@character_set_server= latin1;
drop database mysqltest_1;
set @@character_set_server= utf8mb3;
drop database mysqltest_1;
set @@character_set_server= @old_character_set_server;


--
-- BUG#24491 "using alias from source table in insert ... on duplicate key"
--
create table t1 (id int primary key auto_increment, value varchar(10));
insert into t1 (id, value) values (1, 'FIRST'), (2, 'SECOND'), (3, 'THIRD');
drop tables t1;

--
-- Bug #28509: strange behaviour: passing a decimal value to PS
--
prepare stmt from "create table t1 select ?";
set @a=1.0;
drop table t1;

--
-- Bug#33798: prepared statements improperly handle large unsigned ints
--
create table t1 (a bigint unsigned, b bigint(20) unsigned);
set @a= 9999999999999999;
set @b= 14632475938453979136;
insert into t1 values (@a, @b);
select * from t1 where a = @a and b = @b;
select * from t1 where a = @a and b = @b;
drop table t1;

--
-- Bug#32890 Crash after repeated create and drop of tables and views
--

--disable_warnings
drop view if exists v1;
drop table if exists t1;

create table t1 (a int, b int);
insert into t1 values (1,1), (2,2), (3,3);
insert into t1 values (3,1), (1,2), (2,3);
drop table t1;
create table t1 (a int, b int);
drop view v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;
select * from v1;
drop view v1;

drop table t1;
create temporary table t1 (a int, b int);

drop table t1;

--
-- Bug#33851: Passing UNSIGNED param to EXECUTE returns ERROR 1210
--

prepare stmt from "select ?";
set @arg= 123456789.987654321;
select @arg;
set @arg= "string";
select @arg;
set @arg= 123456;
select @arg;
set @arg= cast(-12345.54321 as decimal(20, 10));
select @arg;
create table t1(b int);
insert into t1 values (0);
create view v1 AS select 1 as a from t1 where b;
drop table t1;
drop view v1;

create table t1(a bigint);
create table t2(b tinyint);
insert into t2 values (null);
drop table t1,t2;
CREATE TABLE t1(a INT PRIMARY KEY);
INSERT INTO t1 VALUES(0), (1);
DROP TABLE t1;

--
-- Bug #20665: All commands supported in Stored Procedures should work in
-- Prepared Statements
--
create procedure proc_1() reset binary logs and gtids;
create function func_1() returns int begin reset binary logs and gtids;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() reset slave;
create function func_1() returns int begin reset slave;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1(a integer) kill a;
drop procedure proc_1;
create function func_1() returns int begin kill 0;
select func_1() from dual;
select func_1() from dual;
select func_1() from dual;
drop function func_1;


create procedure proc_1() flush privileges;
create function func_1() returns int begin flush privileges;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() flush tables with read lock;
create function func_1() returns int begin flush tables with read lock;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() flush tables;
create function func_1() returns int begin flush tables;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() flush tables;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
create function func_1() returns int begin flush tables;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;

-- make the output deterministic:
-- the order used in SHOW OPEN TABLES
-- is too much implementation dependent
--disable_ps_protocol
flush tables;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;
select Host, User from mysql.user limit 0;
select Host, Db from mysql.db limit 0;


create procedure proc_1() flush logs;
create function func_1() returns int begin flush logs;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() flush status;
create function func_1() returns int begin flush status;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() flush user_resources;
create function func_1() returns int begin flush user_resources;
create function func_1() returns int begin call proc_1();
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure proc_1;


create procedure proc_1() start slave;
drop procedure proc_1;
create function func_1() returns int begin start slave;


create procedure proc_1() stop slave;
drop procedure proc_1;
create function func_1() returns int begin stop slave;


create procedure proc_1() show binlog events;
drop procedure proc_1;
create function func_1() returns int begin show binlog events;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() show slave status;
drop procedure proc_1;
create function func_1() returns int begin show slave status;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() show binary log status;
drop procedure proc_1;
create function func_1() returns int begin show binary log status;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() show binary logs;
drop procedure proc_1;
create function func_1() returns int begin show binary logs;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() show events;
drop procedure proc_1;
create function func_1() returns int begin show events;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure a() select 42;
create procedure proc_1(a char(2)) show create procedure a;
drop procedure proc_1;
create function func_1() returns int begin show create procedure a;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop procedure a;


create function a() returns int return 42+13;
create procedure proc_1(a char(2)) show create function a;
drop procedure proc_1;
create function func_1() returns int begin show create function a;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop function a;


create table tab1(a int, b char(1), primary key(a,b));
create procedure proc_1() show create table tab1;
drop procedure proc_1;
create function func_1() returns int begin show create table tab1;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop table tab1;
drop view if exists v1;
drop table if exists t1;
create table t1(a int, b char(5));
insert into t1 values (1, "one"), (1, "edno"), (2, "two"), (2, "dve");
create view v1 as
    (select a, count(*) from t1 group by a)
    union all
    (select b, count(*) from t1 group by b);
create procedure proc_1() show create view v1;
drop procedure proc_1;
create function func_1() returns int begin show create view v1;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop view v1;
drop table t1;


create procedure proc_1() install plugin my_plug soname 'some_plugin.so';
drop procedure proc_1;
create function func_1() returns int begin install plugin my_plug soname '/tmp/plugin';
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() uninstall plugin my_plug;
drop procedure proc_1;
create function func_1() returns int begin uninstall plugin my_plug;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() create database mysqltest_xyz;
drop database if exists mysqltest_xyz;
drop database if exists mysqltest_xyz;
drop database if exists mysqltest_xyz;
drop procedure proc_1;
create function func_1() returns int begin create database mysqltest_xyz;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop database if exists mysqltest_xyz;
drop database if exists mysqltest_xyz;
drop database if exists mysqltest_xyz;


create table t1 (a int, b char(5));
insert into t1 values (1, "one"), (2, "two"), (3, "three");
create procedure proc_1() checksum table xyz;
drop procedure proc_1;
create function func_1() returns int begin checksum table t1;
select func_1(), func_1(), func_1() from dual;
drop function func_1;


create procedure proc_1() create user pstest_xyz@localhost;
drop user pstest_xyz@localhost;
drop user pstest_xyz@localhost;
drop user pstest_xyz@localhost;
drop procedure proc_1;
create function func_1() returns int begin create user pstest_xyz@localhost;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop user pstest_xyz@localhost;
drop user pstest_xyz@localhost;
drop user pstest_xyz@localhost;
create function func_1() returns int begin create event xyz on schedule at now() do select 123;
select func_1(), func_1(), func_1() from dual;
drop function func_1;
drop event if exists xyz;
create event xyz on schedule every 5 minute disable do select 123;
create procedure proc_1() alter event xyz comment 'xyz';
drop event xyz;
create event xyz on schedule every 5 minute disable do select 123;
drop event xyz;
create event xyz on schedule every 5 minute disable do select 123;
drop event xyz;
drop procedure proc_1;
create function func_1() returns int begin alter event xyz comment 'xyz';
drop event if exists xyz;
create event xyz on schedule every 5 minute disable do select 123;
create procedure proc_1() drop event xyz;
create event xyz on schedule every 5 minute disable do select 123;
drop procedure proc_1;
create function func_1() returns int begin drop event xyz;
drop table if exists t1;
create table t1 (a int, b char(5)) engine=myisam;
insert into t1 values (1, "one"), (2, "two"), (3, "three");
SET GLOBAL new_cache.key_buffer_size=128*1024;
create procedure proc_1() cache index t1 in new_cache;
drop procedure proc_1;
SET GLOBAL second_cache.key_buffer_size=128*1024;
drop table t1;
drop table if exists t1;
drop table if exists t2;
create table t1 (a int, b char(5)) engine=myisam;
insert into t1 values (1, "one"), (2, "two"), (3, "three");
create table t2 (a int, b char(5)) engine=myisam;
insert into t2 values (1, "one"), (2, "two"), (3, "three");
create procedure proc_1() load index into cache t1 ignore leaves;
drop procedure proc_1;
create function func_1() returns int begin load index into cache t1 ignore leaves;
drop table t1, t2;

--
-- Bug #21422: GRANT/REVOKE possible inside stored function, probably in a trigger
-- This is disabled for now till it is resolved in 5.0
--

--create procedure proc_1() grant all on *.* to abc@host;

create procedure proc_1() show errors;
drop procedure proc_1;
create function func_1() returns int begin show errors;
drop table if exists t1;
drop table if exists t2;
create procedure proc_1() show warnings;
drop table if exists t1;
drop table if exists t2;
drop table if exists t1, t2;
drop procedure proc_1;
create function func_1() returns int begin show warnings;

--
-- Bug#22684: The Functions ENCODE, DECODE and FORMAT are not real functions
--

set @to_format="123456789.123456789";
set @dec=0;
set @dec=4;
set @dec=6;
set @dec=2;
set @to_format="100";
set @to_format="1000000";
set @to_format="10000";


--
-- BUG#18326: Do not lock table for writing during prepare of statement
--

CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 (i INT);
INSERT INTO t2 VALUES (2);

-- Prepare never acquires the lock, and thus should not block.
PREPARE stmt1 FROM "SELECT i FROM t1";

-- This should not block because READ lock on t1 is shared.
EXECUTE stmt1;

-- This should block because WRITE lock on t2 is exclusive.
send EXECUTE stmt2;

SELECT * FROM t2;
let $wait_condition= SELECT COUNT(*) = 2 FROM t2;
SELECT * FROM t2;

-- DDL and DML works even if some client have a prepared statement
-- referencing the table.
ALTER TABLE t1 ADD COLUMN j INT;
ALTER TABLE t2 ADD COLUMN j INT;
INSERT INTO t1 VALUES (4, 5);
INSERT INTO t2 VALUES (4, 5);
SELECT * FROM t2;

DROP TABLE t1, t2;

--
-- Bug #24879 Prepared Statements: CREATE TABLE (utf8mb3 KEY) produces a growing
-- key length
--
-- Test that parse information is not altered by subsequent executions of a
-- prepared statement
--
drop table if exists t1;
drop table t1;
drop table t1;

--
-- Bug #32030 DELETE does not return an error and deletes rows if error
-- evaluating WHERE
--
-- Test that there is an error for prepared delete just like for the normal
-- one.
--
create table t1 (a int, b int);
create table t2 like t1;

insert into t1 (a, b) values (1,1), (1,2), (1,3), (1,4), (1,5),
       (2,2), (2,3), (2,1), (3,1), (4,1), (4,2), (4,3), (4,4), (4,5), (4,6);

insert into t2 select a, max(b) from t1 group by a;
delete from t2 where (select (select max(b) from t1 group
by a having a < 2) x from t1) > 10000;
drop table t1, t2;
CREATE TABLE t1 (a TIME NOT NULL, b TINYINT);
INSERT IGNORE INTO t1 VALUES (0, 0),(0, 0);
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1),(2);
DROP TABLE t1;
CREATE TABLE t1(f1 INT);
INSERT INTO t1 VALUES (1),(1);
DROP TABLE t1;

-- The idea of this test case is to check that
--   - OUT-parameters of four allowed types (string, double, int, decimal) work
--     properly;
--   - INOUT and OUT parameters work properly;
--   - A mix of IN and OUT parameters work properly;
DROP PROCEDURE IF EXISTS p_string;
DROP PROCEDURE IF EXISTS p_double;
DROP PROCEDURE IF EXISTS p_int;
DROP PROCEDURE IF EXISTS p_decimal;
CREATE PROCEDURE p_string(
  IN v0 INT,
  OUT v1 CHAR(32),
  IN v2 CHAR(32),
  INOUT v3 CHAR(32))
BEGIN
  SET v0 = -1;
  SET v1 = 'test_v1';
  SET v2 = 'n/a';
  SET v3 = 'test_v3';
CREATE PROCEDURE p_double(
  IN v0 INT,
  OUT v1 DOUBLE(4, 2),
  IN v2 DOUBLE(4, 2),
  INOUT v3 DOUBLE(4, 2))
BEGIN
  SET v0 = -1;
  SET v1 = 12.34;
  SET v2 = 98.67;
  SET v3 = 56.78;
CREATE PROCEDURE p_int(
  IN v0 CHAR(10),
  OUT v1 INT,
  IN v2 INT,
  INOUT v3 INT)
BEGIN
  SET v0 = 'n/a';
  SET v1 = 1234;
  SET v2 = 9876;
  SET v3 = 5678;
CREATE PROCEDURE p_decimal(
  IN v0 INT,
  OUT v1 DECIMAL(4, 2),
  IN v2 DECIMAL(4, 2),
  INOUT v3 DECIMAL(4, 2))
BEGIN
  SET v0 = -1;
  SET v1 = 12.34;
  SET v2 = 98.67;
  SET v3 = 56.78;
SET @x_str_1 = NULL;
SET @x_str_2 = NULL;
SET @x_str_3 = NULL;
SET @x_dbl_1 = NULL;
SET @x_dbl_2 = NULL;
SET @x_dbl_3 = NULL;
SET @x_int_1 = NULL;
SET @x_int_2 = NULL;
SET @x_int_3 = NULL;
SET @x_dec_1 = NULL;
SET @x_dec_2 = NULL;
SET @x_dec_3 = NULL;
SELECT @x_int_1, @x_str_1, @x_str_2, @x_str_3;
SELECT @x_int_1, @x_str_1, @x_str_2, @x_str_3;
SELECT @x_int_1, @x_dbl_1, @x_dbl_2, @x_dbl_3;
SELECT @x_int_1, @x_dbl_1, @x_dbl_2, @x_dbl_3;
SELECT @x_str_1, @x_int_1, @x_int_2, @x_int_3;
SELECT @x_str_1, @x_int_1, @x_int_2, @x_int_3;
SELECT @x_int_1, @x_dec_1, @x_dec_2, @x_dec_3;
SELECT @x_int_1, @x_dec_1, @x_dec_2, @x_dec_3;
DROP PROCEDURE p_string;
DROP PROCEDURE p_double;
DROP PROCEDURE p_int;
DROP PROCEDURE p_decimal;

--
-- Another test case for WL#4435: check out parameters in Dynamic SQL.
--

--echo
--disable_warnings
DROP PROCEDURE IF EXISTS p1;
DROP PROCEDURE IF EXISTS p2;

CREATE PROCEDURE p1(OUT v1 CHAR(10))
  SET v1 = 'test1';
CREATE PROCEDURE p2(OUT v2 CHAR(10))
BEGIN
  SET @query = 'CALL p1(?)';

  SET v2 = @u1;
SELECT @a;

DROP PROCEDURE p1;
DROP PROCEDURE p2;

CREATE TABLE t1 (a INT);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;

SELECT *
FROM (SELECT 1 UNION SELECT 2) t;
SELECT c1, t2.c2, count(c3)
FROM
  (
  SELECT 3 as c2 FROM dual WHERE @x = 1
  UNION
  SELECT 2       FROM dual WHERE @x = 1 OR @x = 2
  ) AS t1,
  (
  SELECT '2012-03-01 01:00:00' AS c1, 3 as c2, 1 as c3 FROM dual
  UNION
  SELECT '2012-03-01 02:00:00',       3,       2       FROM dual
  UNION
  SELECT '2012-03-01 01:00:00',       2,       1       FROM dual
  ) AS t2
WHERE t2.c2 = t1.c2
GROUP BY c1,c2
ORDER BY c1,c2
";
SET @x = 1;
SELECT c1, t2.c2, count(c3)
FROM
  (
  SELECT 3 as c2 FROM dual WHERE @x = 1
  UNION
  SELECT 2       FROM dual WHERE @x = 1 OR @x = 2
  ) AS t1,
  (
  SELECT '2012-03-01 01:00:00' AS c1, 3 as c2, 1 as c3 FROM dual
  UNION
  SELECT '2012-03-01 02:00:00',       3,       2       FROM dual
  UNION
  SELECT '2012-03-01 01:00:00',       2,       1       FROM dual
  ) AS t2
WHERE t2.c2 = t1.c2
GROUP BY c1, c2
ORDER BY c1, c2;
SET @x = 2;
SELECT c1, t2.c2, count(c3)
FROM
  (
  SELECT 3 as c2 FROM dual WHERE @x = 1
  UNION
  SELECT 2       FROM dual WHERE @x = 1 OR @x = 2
  ) AS t1,
  (
  SELECT '2012-03-01 01:00:00' AS c1, 3 as c2, 1 as c3 FROM dual
  UNION
  SELECT '2012-03-01 02:00:00',       3,       2       FROM dual
  UNION
  SELECT '2012-03-01 01:00:00',       2,       1       FROM dual
  ) AS t2
WHERE t2.c2 = t1.c2
GROUP BY c1, c2
ORDER BY c1, c2;
SET @x = 1;
SELECT c1, t2.c2, count(c3)
FROM
  (
  SELECT 3 as c2 FROM dual WHERE @x = 1
  UNION
  SELECT 2       FROM dual WHERE @x = 1 OR @x = 2
  ) AS t1,
  (
  SELECT '2012-03-01 01:00:00' AS c1, 3 as c2, 1 as c3 FROM dual
  UNION
  SELECT '2012-03-01 02:00:00',       3,       2       FROM dual
  UNION
  SELECT '2012-03-01 01:00:00',       2,       1       FROM dual
  ) AS t2
WHERE t2.c2 = t1.c2
GROUP BY c1, c2
ORDER BY c1, c2;

CREATE TABLE t1(a INTEGER);
CREATE TABLE t2(a INTEGER);
SELECT (SELECT 1 FROM t2 WHERE ot.a) AS d
FROM t1 AS ot
GROUP BY d';

INSERT INTO t1 VALUES (0),(1),(2);
INSERT INTO t2 VALUES (1);
DROP TABLE t1, t2;

CREATE TABLE t1 (
  pk INTEGER AUTO_INCREMENT,
  col_int_nokey INTEGER,
  col_int_key INTEGER,

  col_varchar_key VARCHAR(1),
  col_varchar_nokey VARCHAR(1),

  PRIMARY KEY (pk),
  KEY (col_int_key),
  KEY (col_varchar_key, col_int_key)
);

INSERT INTO t1 (
  col_int_key, col_int_nokey,
  col_varchar_key, col_varchar_nokey
) VALUES 
(4,    2, 'v', 'v'),
(62, 150, 'v', 'v');

CREATE TABLE t2 (
  pk INTEGER AUTO_INCREMENT,
  col_int_nokey INTEGER,
  col_int_key INTEGER,

  col_varchar_key VARCHAR(1),
  col_varchar_nokey VARCHAR(1),

  PRIMARY KEY (pk),
  KEY (col_int_key),
  KEY (col_varchar_key, col_int_key)
);

INSERT INTO t2 (
  col_int_key, col_int_nokey,
  col_varchar_key, col_varchar_nokey
) VALUES 
(8, NULL, 'x', 'x'),
(7, 8,    'd', 'd');
SELECT
  ( SELECT MAX( SQ1_alias2 .col_int_nokey ) AS SQ1_field1
    FROM ( t2 AS SQ1_alias1 RIGHT JOIN t1 AS SQ1_alias2
           ON ( SQ1_alias2.col_varchar_key = SQ1_alias1.col_varchar_nokey )
         )
    WHERE SQ1_alias2.pk < alias1.col_int_nokey OR alias1.pk
  ) AS field1
FROM ( t1 AS alias1 JOIN t2 AS alias2 ON alias2.pk )
GROUP BY field1
';

DROP TABLE t1, t2;

CREATE TABLE t1 (a INTEGER);
CREATE TABLE t2 (b INTEGER);

DROP TABLE t1, t2;

CREATE TABLE bug19894382(f1 CHAR(64) DEFAULT 'slave',
                         f2 TIME, f3 TIMESTAMP NULL, f4 DATETIME,
                         f5 TIME(3), f6 TIMESTAMP(3) NULL, f7 DATETIME(3));
INSERT INTO bug19894382 SELECT * FROM client_test_db.bug19894382;
let $MYSQLD_DATADIR= `select @@datadir`;
INSERT INTO bug19894382(f2, f3, f4, f5, f6, f7)
  SELECT f2, f3, f4, f5, f6, f7 FROM client_test_db.bug19894382;
SELECT * FROM bug19894382 ORDER BY f2;
DROP TABLE bug19894382;
SET @a=repeat('a', 100000);

DROP DATABASE client_test_db;

CREATE TABLE t1 (t time DEFAULT NULL);
INSERT INTO t1 VALUES ('16:07:44');
SET @var1 = 5;
DROP TABLE t1;

CREATE TABLE t1 (dt datetime DEFAULT NULL);
INSERT INTO t1 VALUES ('2018-11-11 16:07:44');
SET @var1 = 5;
DROP TABLE t1;

CREATE TABLE t1 (d date DEFAULT NULL);
INSERT INTO t1 VALUES ('2018-11-11');
SET @var1 = 5;
DROP TABLE t1;
CREATE TABLE t(a INT, b INT);
INSERT INTO t VALUES (1, 1), (2, 2), (3, 3), (4, 4);
DROP PREPARE ps;
DROP TABLE t;

CREATE TABLE t1(c1 int);
INSERT INTO t1 VALUES(1),(2);
CREATE FUNCTION f1() returns INT deterministic return 1;
CREATE VIEW v1 AS SELECT c1 FROM t1 WHERE c1 = f1();
DROP FUNCTION f1;
DROP VIEW v1;
DROP TABLE t1;

CREATE TABLE t1 (a char (64) character set latin1, b int unsigned);
SET @a = 'test';
SET @b = 2;
DROP TABLE t1;

CREATE TABLE t1 (a INTEGER);
DROP TABLE t1;

CREATE TABLE t1 ( pk INTEGER NOT NULL, a INTEGER );

-- Verify there's no <cache> around the 2.
PREPARE q FROM 'EXPLAIN FORMAT=tree SELECT * FROM t1 WHERE pk = ?';
SET @v = 2;

DROP TABLE t1;

CREATE TABLE t (f INT NOT NULL) ENGINE=InnoDB;
INSERT INTO t (f) VALUES (0);
SET @a = '0.3';
SELECT * FROM t;
DROP TABLE t;

CREATE TABLE t1 (int_column INT NOT NULL);
INSERT INTO t1 VALUES (1), (2), (3), (4);

SELECT * from t1 where int_column < '1.9';
SET @a = '1.9';

DROP TABLE t1;

SET GLOBAL log_output=@old_log_output;

CREATE TABLE ints(i INTEGER);
CREATE TABLE deci(d DECIMAL(12,4));
CREATE TABLE dbls(r DOUBLE);
CREATE TABLE flts(f FLOAT);

SET @empty = '';
SET @spaces = '   ';
SET @intval = '666';
SET @decval = '777.777';
SET @dblval = '888.888e100';
SET @fltval = '1e38';
SET @intvalx = '  666  ';
SET @decvalx = '  777.777  ';
SET @dblvalx = '  888.888e100  ';
SET @fltvalx = '  1e38  ';
INSERT INTO ints VALUES ('');
INSERT INTO deci VALUES ('');
INSERT INTO dbls VALUES ('');
INSERT INTO flts VALUES ('');
INSERT INTO ints VALUES ('   ');
INSERT INTO deci VALUES ('   ');
INSERT INTO dbls VALUES ('   ');
INSERT INTO flts VALUES ('   ');
INSERT INTO ints VALUES (@empty);
INSERT INTO deci VALUES (@empty);
INSERT INTO dbls VALUES (@empty);
INSERT INTO flts VALUES (@empty);
INSERT INTO ints VALUES (@spaces);
INSERT INTO deci VALUES (@spaces);
INSERT INTO dbls VALUES (@spaces);
INSERT INTO flts VALUES (@spaces);

INSERT INTO ints VALUES ('666');
INSERT INTO deci VALUES ('777.777');
INSERT INTO dbls VALUES ('888.888e100');
INSERT INTO flts VALUES ('1e38');

INSERT INTO ints VALUES ('  666  ');
INSERT INTO deci VALUES ('  777.777  ');
INSERT INTO dbls VALUES ('  888.888e100  ');
INSERT INTO flts VALUES ('  1e38  ');

INSERT INTO ints VALUES (@intval);
INSERT INTO deci VALUES (@decval);
INSERT INTO dbls VALUES (@dblval);
INSERT INTO flts VALUES (@fltval);

INSERT INTO ints VALUES (@intvalx);
INSERT INTO deci VALUES (@decvalx);
INSERT INTO dbls VALUES (@dblvalx);
INSERT INTO flts VALUES (@fltvalx);

SELECT * FROM ints;
SELECT * FROM deci;
SELECT * FROM dbls;
SELECT * FROM flts;

DROP TABLE ints, deci, dbls, flts;

CREATE TABLE t1 (
 id INT NOT NULL,
 value VARCHAR(100) NULL
);

INSERT INTO t1 VALUES ROW(1,'A');

set @a=1;
set @b='B';
UPDATE t1 AS ut
       INNER JOIN (VALUES ROW(?, ?)) AS vt (id, value)
       ON ut.id = vt.id
SET ut.value = vt.value";

SELECT * FROM t1;

UPDATE t1 SET id = 1, value = 'A';
UPDATE t1 AS ut
       INNER JOIN (VALUES ROW(CAST(? AS SIGNED), CAST(? AS CHAR))
                  ) AS vt (id, value)
       ON ut.id = vt.id
SET ut.value = vt.value";

SELECT * FROM t1;

DROP TABLE t1;
