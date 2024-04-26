--                                                                             #
-- Variable Name: table_open_cache                                             #
-- Scope: Global                                                               #
-- Access Type: Dynamic                                                         #
-- Data Type: numeric                                                          #
--                                                                             #
--                                                                             #
-- Creation Date: 2012-08-31                                                   #
-- Author : Tanjot Singh Uppal                                                 #
--                                                                             #
--                                                                             #
-- Description:Test Cases of Dynamic System Variable table_open_cache           #
--             that checks the behavior of this variable in the following ways #
--              * Value Check                                                  #
--              * Scope Check                                                  #
--              * Functionality Check                                          #
--              * Accessability Check                                          #
--                                                                             #               
-- This test does not perform the crash recovery on this variable              # 
-- For crash recovery test on default change please run the ibtest             #
--##############################################################################


CALL mtr.add_suppression("innodb_open_files should not be greater than the open_files_limit.");
--   Checking default value                                         #
--###################################################################
SELECT COUNT(@@GLOBAL.table_open_cache);

SELECT IF(@@open_files_limit < 5000, 4000, @@GLOBAL.table_open_cache);

let $restart_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

SELECT @@GLOBAL.table_open_cache;

SET @@GLOBAL.table_open_cache=DEFAULT;
SELECT @@GLOBAL.table_open_cache;
--   Checking Value can be set - Dynamic                            #
--###################################################################

--error ER_GLOBAL_VARIABLE
SET @@local.table_open_cache=1;
SET @@session.table_open_cache=1;

SET @@GLOBAL.table_open_cache=1;
SET @@GLOBAL.table_open_cache=DEFAULT;


SELECT @@GLOBAL.table_open_cache;
SELECT @@GLOBAL.table_open_cache = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='table_open_cache';

SELECT COUNT(@@GLOBAL.table_open_cache);

SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='table_open_cache';
--  Checking Variable Scope                                                     #
--###############################################################################
SELECT @@table_open_cache = @@GLOBAL.table_open_cache;
SELECT COUNT(@@local.table_open_cache);
SELECT COUNT(@@SESSION.table_open_cache);

SELECT COUNT(@@GLOBAL.table_open_cache);
SELECT table_open_cache;
DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;
DROP TABLE IF EXISTS tab3;

let $i = 1;

let $table = tab1;

let $table = tab2;

let $table = tab3;
set @@GLOBAL.table_open_cache=2;

select 1 from tab1;

select 1 from tab2;
set @opened_tables = (select variable_value from performance_schema.session_status where variable_name ='Opened_tables');
set @open_cache_hits = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits');
set @open_cache_miss = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses');
set @open_cache_overflow = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows');
select 1 from tab1;
select 1 from tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow;
select 1 from tab3;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 2;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss + 1;
select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow + 1;
set @global_opened_tables = (select variable_value from performance_schema.global_status where variable_name ='Opened_tables');
set @global_open_cache_hits = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits');
set @global_open_cache_miss = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses');
set @global_open_cache_overflow = (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows');
set @opened_tables = (select variable_value from performance_schema.session_status where variable_name ='Opened_tables');
set @open_cache_hits = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits');
set @open_cache_miss = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses');
set @open_cache_overflow = (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows');

select 1 from tab2;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits + 1;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow;

select (select variable_value from performance_schema.global_status where variable_name ='Opened_tables') = @global_opened_tables;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits') = @global_open_cache_hits + 1;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses') = @global_open_cache_miss;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows') = @global_open_cache_overflow;

select 1 from tab1;
select (select variable_value from performance_schema.session_status where variable_name ='Opened_tables') = @opened_tables + 1;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_hits') = @open_cache_hits;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_misses') = @open_cache_miss + 1;

select (select variable_value from performance_schema.session_status where variable_name ='Table_open_cache_overflows') = @open_cache_overflow + 1;

select (select variable_value from performance_schema.global_status where variable_name ='Opened_tables') = @global_opened_tables + 1;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_hits') = @global_open_cache_hits + 1;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_misses') = @global_open_cache_miss + 1;

select (select variable_value from performance_schema.global_status where variable_name ='Table_open_cache_overflows') = @global_open_cache_overflow + 1;

DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;
DROP TABLE IF EXISTS tab3;
set @@GLOBAL.table_open_cache=DEFAULT;

-- Restore default settings in opt file
let $restart_parameters = restart:;
