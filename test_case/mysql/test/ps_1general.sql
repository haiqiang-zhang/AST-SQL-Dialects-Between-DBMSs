--                                                            #
--   basic and miscellaneous tests for prepared statements    #
--                                                            #
--#############################################################

-- Result differences depending on FS case sensitivity.
if (!$require_case_insensitive_file_system)
{
  --source include/have_case_sensitive_file_system.inc
}
--    
-- NOTE: PLEASE SEE THE DETAILED DESCRIPTION AT THE BOTTOM OF THIS FILE
--       BEFORE ADDING NEW TEST CASES HERE !!!
-- one subtest needs page size > 8k
--disable_warnings
-- Test needs myisam for a few testcases
--source include/have_myisam.inc

drop table if exists t5, t6, t7, t8;
drop database if exists mysqltest ;

-- Cleanup from other tests
drop database if exists client_test_db;
drop database if exists testtets;
drop table if exists t1Aa,t2Aa,v1Aa,v2Aa;
drop view if exists t1Aa,t2Aa,v1Aa,v2Aa;
select '------ basic tests ------' as test_sequence ;

let $type= 'MYISAM' ;

-- 1. PREPARE stmt_name FROM <preparable statement>;
--    <preparable statement> ::=
--     'literal_stmt' |
--     @variable_ref_stmt.
--    The statement may contain question marks as placeholders for parameters.
--
--    Bind a statement name to a string containing a SQL statement and
--    send it to the server. The server will parse the statement and
--    reply with "Query Ok" or an error message.
--
PREPARE stmt FROM ' select * from t1 where a = ? ' ;

-- 2. EXECUTE stmt_name [USING @var [, @var ]];
--    Current values of supplied variables are used as parameters.
--
--    Send the server the order to execute the statement and supply values
--    for the input parameters needed.
--    If no error occurs the server reply will be identical to the reply for
--    the query used in PREPARE with question marks replaced with values of
--    the input variables.
--
SET @var= 2 ;
--    The non prepared statement with the same server reply would be:
select * from t1 where a = @var ;

-- 3. DEALLOCATE PREPARE stmt_name;
--    Send the server the order to drop the parse informations.
--    The server will reply with "Query Ok" or an error message.
DEALLOCATE PREPARE stmt ;
set @arg00='select 1 as my_col';
set @arg00='';
set @arg00=NULL;
drop table if exists not_exist ;

-- case derived from client_test.c: test_prepare_syntax()
-- prepare must fail (incomplete statement)
--error ER_PARSE_ERROR
prepare stmt1 from ' insert into t1 values(? ' ;
                     where a=? and where ' ;
--         but there was a successful prepare of stmt1 before)
prepare stmt1 from ' select * from t1 where a <= 2 ' ;

-- drop the table between prepare and execute
create table t5
(
  a int primary key,
  b char(30),
  c int
);
insert into t5( a, b, c) values( 1, 'original table', 1);
drop table t5 ;
create table t5
(
  a int primary key,
  b char(30),
  c int
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5 ;
create table t5
(
  a int primary key,
  c int,
  b char(30)
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5 ;
create table t5
(
  a int primary key,
  b char(30),
  c int,
  d timestamp default '2008-02-23 09:23:45'
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5 ;
create table t5
(
  a int primary key,
  d timestamp default '2008-02-23 09:23:45',
  b char(30),
  c int
);
insert into t5( a, b, c) values( 9, 'recreated table', 9);
drop table t5 ;
create table t5
(
  a timestamp default '2004-02-29 18:01:59',
  b char(30),
  c int
);
insert into t5( b, c) values( 'recreated table', 9);
drop table t5 ;
create table t5
(
  f1 int primary key,
  f2 char(30),
  f3 int
);
insert into t5( f1, f2, f3) values( 9, 'recreated table', 9);
drop table t5 ;

-- execute without parameter
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
set @arg00=1 ;
set @arg01='two' ;
--         but there was a successful prepare before)
prepare stmt1 from ' select * from t1 where a <= 2 ' ;
create table t5
(
  a int primary key,
  b char(10)
);
drop table t5 ;

--# parallel use of more than one prepared statement handlers
-- switch between different queries
prepare stmt1 from ' select a from t1 where a <= 2 ' ;
select '------ show and misc tests ------' as test_sequence ;
drop table if exists t2;
create table t2 
(
  a int primary key, b char(10)
);
SET @arg00="a";
SET @arg00="b";
SET @arg00=1;
create index t2_idx on t2(b);
--# get a warning and an error
-- cases derived from client_test.c: test_warnings(), test_errors()
--disable_warnings
drop table if exists t5;

--# SELECT @@version
-- cases derived from client_test.c: test_select_version()
--
-- TODO: Metadata check is temporary disabled here, because metadata of 
-- this statement also depends on @@version contents and you can't apply
-- replace_column and replace_result to it. It will be enabled again when 
-- support of replace_column and replace_result on metadata will be
-- implemented.
--
----enable_metadata
prepare stmt1 from ' SELECT @@version ' ;

--# do @var:= and set @var=
-- cases derived from client_test.c: test_do_set()
prepare stmt_do from ' do @var:=  (1 in (select a from t1)) ' ;
let $1= 3 ;
{
  execute stmt_do ;
  select @var as 'content of @var is:' ;
  select @var as 'content of @var is:' ;
  dec $1 ;
drop table if exists t5 ;
create table t5 (a int) ;
let $1= 3 ;
{
  execute stmt_do ;
  select @var as 'content of @var is:' ;
  select @var as 'content of @var is:' ;
  dec $1 ;
drop table t5 ;

--# nonsense like prepare of prepare,execute or deallocate
--error ER_UNSUPPORTED_PS 
prepare stmt1 from ' prepare stmt2 from '' select 1 ''  ' ;

--# We don't support alter view as prepared statements
--error ER_UNSUPPORTED_PS
prepare stmt1 from 'alter view v1 as select 2';

--# switch the database connection
--error ER_UNSUPPORTED_PS
prepare stmt4 from ' use test ' ;

--# create/drop database
prepare stmt3 from ' create database mysqltest ';
create database mysqltest ;
drop database mysqltest ;
--# describe
prepare stmt3 from ' describe t2 ';
drop table t2 ;
--# lock/unlock
--error ER_UNSUPPORTED_PS
prepare stmt3 from ' lock tables t1 read ' ;
--# Load/Unload table contents

--let $datafile = $MYSQLTEST_VARDIR/tmp/data.txt
--error 0,1
--remove_file $datafile

--replace_result $MYSQLTEST_VARDIR <MYSQLTEST_VARDIR>
--error ER_UNSUPPORTED_PS
eval prepare stmt1 from ' load data infile ''$datafile''
     into table t1 fields terminated by ''\t'' ';
     execute stmt1 ;
--# 
prepare stmt1 from ' optimize table t1 ' ;

--# handler
--error ER_UNSUPPORTED_PS
prepare stmt1 from ' handler t1 open ';


--# commit/rollback
prepare stmt3 from ' commit ' ;


--# switch the sql_mode
prepare stmt4 from ' SET sql_mode=ansi ';
select 'a' || 'b' ;
select '2' || '3' ;
SET sql_mode=ansi;
SET sql_mode="";

--# simple explain
-- cases derived from client_test.c: test_explain_bug()
prepare stmt1 from ' explain select a from t1 order by b ';
SET @arg00=1 ;

--# parameters with probably problematic characters (quote, double  quote)
-- cases derived from client_test.c: test_logs()
-- try if 
--disable_warnings
drop table if exists t2;
create table t2 (id smallint, name varchar(20)) ;
set @id= 9876 ;
set @arg00= 'MySQL - Open Source Database' ;
set @arg01= "'" ;
set @arg02= '"' ;
set @arg03= "my'sql'" ;
set @arg04= 'my"sql"' ;
insert into t2 values ( @id , @arg00 );
insert into t2 values ( @id , @arg01 );
insert into t2 values ( @id , @arg02 );
insert into t2 values ( @id , @arg03 );
insert into t2 values ( @id , @arg04 );
drop table t2;
select '------ create/drop/alter/rename tests ------' as test_sequence ;
drop table if exists t2, t3;

--# DROP TABLE
prepare stmt_drop from ' drop table if exists t2 ' ;

--# CREATE TABLE
prepare stmt_create from ' create table t2 (
                             a int primary key, b char(10)) ';
drop table t3;

--# CREATE TABLE .. SELECT
set @arg00=1;
select m from t3;
drop table t3;

--# RENAME TABLE
--disable_warnings
drop table if exists new_t2;
drop table t2;
--# RENAME more than on TABLE within one statement
-- cases derived from client_test.c: test_rename()
prepare stmt1 from ' rename table t5 to t6, t7 to t8 ' ;
create table t5 (a int) ;
create table t7 (a int) ;
drop table t6, t8 ;
select '------ big statement tests ------' as test_sequence ;
--            or other sources.

--# many lines ( 50 )
let $my_stmt= select 'ABC' as my_const_col from t1 where
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 AND
1 = 1 ;

--# many characters ( about 1400 )

let $my_stmt= select 'ABC' as my_const_col FROM t1 WHERE
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' AND
'1234567890123456789012345678901234567890123456789012345678901234567890'
= '1234567890123456789012345678901234567890123456789012345678901234567890' ;


--# many parameters ( 50 )
--disable_query_log
set @arg00= 1;
set @arg01= 1;
set @arg02= 1;
set @arg03= 1;
set @arg04= 1;
set @arg05= 1;
set @arg06= 1;
set @arg07= 1;
set @arg10= 1;
set @arg11= 1;
set @arg12= 1;
set @arg13= 1;
set @arg14= 1;
set @arg15= 1;
set @arg16= 1;
set @arg17= 1;
set @arg20= 1;
set @arg21= 1;
set @arg22= 1;
set @arg23= 1;
set @arg24= 1;
set @arg25= 1;
set @arg26= 1;
set @arg27= 1;
set @arg30= 1;
set @arg31= 1;
set @arg32= 1;
set @arg33= 1;
set @arg34= 1;
set @arg35= 1;
set @arg36= 1;
set @arg37= 1;
set @arg40= 1;
set @arg41= 1;
set @arg42= 1;
set @arg43= 1;
set @arg44= 1;
set @arg45= 1;
set @arg46= 1;
set @arg47= 1;
set @arg50= 1;
set @arg51= 1;
set @arg52= 1;
set @arg53= 1;
set @arg54= 1;
set @arg55= 1;
set @arg56= 1;
set @arg57= 1;
set @arg60= 1;
set @arg61= 1;

select 'ABC' as my_const_col FROM t1 WHERE
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and @arg00=@arg00 and
@arg00=@arg00 ;
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  and  ? = ?  and  ? = ?  and  ? = ?  and
 ? = ?  ' ;

-- cases derived from client_test.c: test_mem_overun()
--disable_warnings
drop table if exists t5 ;

set @col_num= 1000 ;
set @string= 'create table t5( ' ;
let $1=`select @col_num - 1` ;
{
  eval set @string= concat(@string, 'c$1 int,') ;
  dec $1 ;
set @string= concat(@string, 'c0 int)' );
select @string as "" ;
set @string= 'insert into t5 values(' ;
let $1=`select @col_num - 1` ;
{
  eval set @string= concat(@string, '1 ,') ;
  dec $1 ;
select @string as "" ;

drop table t1, t5, t9;
create table t1 (c1 int);
insert into t1 values (1);
drop prepare stmt1;
drop table t1;
