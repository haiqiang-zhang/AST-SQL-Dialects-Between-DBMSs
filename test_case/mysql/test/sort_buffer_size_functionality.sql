--                                                                             #
-- Variable Name: sort_buffer_size                                             #
-- Scope: Global/Session                                                       #
-- Access Type: Dynamic                                                        #
-- Data Type: numeric                                                          #
--                                                                             #
--                                                                             #
-- Creation Date: 2012-08-31                                                   #
-- Author : Tanjot Singh Uppal                                                 #
--                                                                             #
--                                                                             #
-- Description:Test Cases of Dynamic System Variable sort_buffer_size          #
--             that checks the behavior of this variable in the following ways #
--              * Value Check                                                  #
--              * Scope Check                                                  #
--              * Functionality Check                                          #
--              * Accessability Check                                          #
--                                                                             #
--##############################################################################

-- Results for temptable depends on pointer size (see handler::ref_length).
-- source include/no_valgrind_without_big.inc

--echo '-----------------------WL6372_VAR_8_01----------------------#'
--###################################################################
--   Checking default value                                         #
--###################################################################
SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT COUNT(@@SESSION.sort_buffer_size);

SELECT @@GLOBAL.sort_buffer_size;
SELECT @@SESSION.sort_buffer_size;


-- let $restart_parameters= "restart:--sort_buffer_size=9999999"
if ($VALGRIND_TEST)
{
-- let $shutdown_server_timeout = 600
}
-- source include/restart_mysqld.inc

SELECT @@GLOBAL.sort_buffer_size;

SET @@GLOBAL.sort_buffer_size=DEFAULT;
SELECT @@GLOBAL.sort_buffer_size;
--   Checking Value can be set - Dynamic                            #
--###################################################################

SET @@local.sort_buffer_size=9999999;

SET @@session.sort_buffer_size=9999999;

SET @@GLOBAL.sort_buffer_size=9999999;

SET @@local.sort_buffer_size=DEFAULT;

SET @@session.sort_buffer_size=DEFAULT;

SET @@GLOBAL.sort_buffer_size=DEFAULT;

SELECT @@GLOBAL.sort_buffer_size;

-- The below check is hashed until the BUG#14635304 is fixed
--SELECT @@SESSION.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='sort_buffer_size';

SELECT @@session.sort_buffer_size = VARIABLE_VALUE 
FROM performance_schema.session_variables 
WHERE VARIABLE_NAME='sort_buffer_size';

SELECT COUNT(@@GLOBAL.sort_buffer_size);

SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='sort_buffer_size';
--  Checking Variable Scope                                                     #
--###############################################################################
SELECT @@sort_buffer_size = @@GLOBAL.sort_buffer_size;

SELECT COUNT(@@sort_buffer_size);

SELECT COUNT(@@local.sort_buffer_size);

SELECT COUNT(@@SESSION.sort_buffer_size);

SELECT COUNT(@@GLOBAL.sort_buffer_size);
SELECT sort_buffer_size = @@SESSION.sort_buffer_size;
--  Checking boundary values                                                    #
--###############################################################################
--disable_warnings
SET @@GLOBAL.sort_buffer_size=32767;
SET @@session.sort_buffer_size=32767;

SELECT @@GLOBAL.sort_buffer_size;
select @@session.sort_buffer_size;
SET @@global.sort_buffer_size=-1;
SET @@session.sort_buffer_size=-1;

select @@session.sort_buffer_size;
SELECT @@GLOBAL.sort_buffer_size;
--  The MAX value is not being tested as would                                  #
-- differ on a 32 bit machine and a 64 bit machine                              #
--###############################################################################


--echo '-----------------------WL6372_VAR_8_07----------------------#'
--###############################################################################
--  Checking the /Var  directory size                                           #
--###############################################################################
-- source include/vardir_size_check.inc

--echo '-----------------------WL6372_VAR_8_08----------------------#'
--###############################################################################
--  Checking the sort buffer functionality when data is more than 32K           #
--###############################################################################

--echo -- create a table
let $table = tab1;
let $i = 10;
SET @@GLOBAL.sort_buffer_size=32768;
SET @@SESSION.sort_buffer_size=32768;
select variable_value from performance_schema.session_status where variable_name ='Sort_merge_passes';
select variable_value from performance_schema.session_status where variable_name ='Sort_rows';
select variable_value from performance_schema.session_status where variable_name ='Sort_scan';
set @Sort_merge_passes = (select variable_value from performance_schema.session_status where variable_name ='Sort_merge_passes');
set @Sort_rows = (select variable_value from performance_schema.session_status where variable_name ='Sort_rows');
set @Sort_scan = (select variable_value from performance_schema.session_status where variable_name ='Sort_scan');

set @optimizer_switch_saved=@@optimizer_switch;
set optimizer_switch='derived_merge=off';

select count(1) from (select b.* from tab1 b inner join tab1 c inner join tab1 d inner join tab1 e inner join tab1 f order by 1) a;
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;

select count(1) from (select b.* from tab1 b inner join tab1 c inner join tab1 d inner join tab1 e inner join tab1 f order by 1) a;
select ( select variable_value from performance_schema.global_status where variable_name ='Sort_merge_passes') - @Sort_merge_passes;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_rows') - @Sort_rows;
select (select variable_value from performance_schema.global_status where variable_name ='Sort_scan') - @Sort_scan;

set @@optimizer_switch=@optimizer_switch_saved;
DROP TABLE IF EXISTS tab1;
SET @@session.sort_buffer_size=DEFAULT;
SET @@GLOBAL.sort_buffer_size=DEFAULT;
