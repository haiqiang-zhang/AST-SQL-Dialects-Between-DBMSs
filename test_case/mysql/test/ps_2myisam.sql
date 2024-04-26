--                                             #
--  Prepared Statements test on MYISAM tables  #
--                                             #
--##############################################

--    
-- NOTE: PLEASE SEE ps_1general.test (bottom) 
--       BEFORE ADDING NEW TEST CASES HERE !!!

use test;

let $type= 'MYISAM' ;

-- source include/ps_query.inc

-- parameter in SELECT ... MATCH/AGAINST
-- case derived from client_test.c: test_bug1500()
--disable_warnings
drop table if exists t2 ;
insert into t2 values ('Gravedigger'), ('Greed'),('Hollow Dogs') ;
set @arg00='Dogs' ;
set @arg00='Grave' ;
drop table t2 ;

-- source include/ps_modify.inc
-- source include/ps_modify1.inc
-- source include/ps_conv.inc

drop table t1, t9;
