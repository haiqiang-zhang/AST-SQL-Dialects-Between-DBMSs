--                                             #
--   Prepared Statements test on HEAP tables   #
--                                             #
--##############################################

--    
-- NOTE: PLEASE SEE ps_1general.test (bottom) 
--       BEFORE ADDING NEW TEST CASES HERE !!!

use test;

let $type= 'HEAP' ;
drop table if exists t1, t9 ;
(
  a int, b varchar(30),
  primary key(a)
) engine = $type ;
drop table if exists t9;
(
  c1  tinyint, c2  smallint, c3  mediumint, c4  int,
  c5  integer, c6  bigint, c7  float, c8  double,
  c9  double precision, c10 real, c11 decimal(7, 4), c12 numeric(8, 4),
  c13 date, c14 datetime, c15 timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP 
  ON UPDATE CURRENT_TIMESTAMP, c16 time,
  c17 year, c18 tinyint, c19 bool, c20 char,
  c21 char(10), c22 varchar(30), c23 varchar(100), c24 varchar(100),
  c25 varchar(100), c26 varchar(100), c27 varchar(100), c28 varchar(100),
  c29 varchar(100), c30 varchar(100), c31 enum('one', 'two', 'three'),
  c32 set('monday', 'tuesday', 'wednesday'),
  primary key(c1)
) engine = $type ;

-- source include/ps_query.inc
-- source include/ps_modify.inc
-- source include/ps_modify1.inc
-- source include/ps_conv.inc

drop table t1, t9;
