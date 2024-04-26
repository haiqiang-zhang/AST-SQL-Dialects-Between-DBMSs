--                                                                             #
-- Variable Name: table_definition_cache                                       #
-- Scope: Global                                                               #
-- Access Type: Dynamic                                                        #
-- Data Type: numeric                                                          #
--                                                                             #
--                                                                             #
-- Creation Date: 2012-08-31                                                   #
-- Author : Tanjot Singh Uppal                                                 #
--                                                                             #
--                                                                             #
-- Description:Test Cases of Dynamic System Variable table_definition_cache    #
--             that checks the behavior of this variable in the following ways #
--              * Value Check                                                  #
--              * Scope Check                                                  #
--              * Functionality Check                                          #
--              * Accessability Check                                          #
--                                                                             #               
-- This test does not perform the crash recovery on this variable              # 
-- For crash recovery test on default change please run the ibtest             #
--##############################################################################

--source include/not_valgrind.inc

echo '--________________________VAR_05_table_definition_cache__________________#'
echo '--#'
--echo '-----------------------WL6372_VAR_5_01----------------------#'
--###################################################################
--   Checking default value                                         #
--###################################################################
SELECT COUNT(@@GLOBAL.table_definition_cache);

SET @@GLOBAL.table_definition_cache=DEFAULT;
SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);

let $restart_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

SELECT @@GLOBAL.table_definition_cache;

SET @@GLOBAL.table_definition_cache=DEFAULT;
SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);
--   Checking Value can be set - Dynamic                            #
--###################################################################

--error ER_GLOBAL_VARIABLE
SET @@local.table_definition_cache=1;
SET @@session.table_definition_cache=1;
SET @@GLOBAL.table_definition_cache=1;

SET @@GLOBAL.table_definition_cache=DEFAULT;


SELECT IF (@@open_files_limit < 5000, 2000, @@GLOBAL.table_definition_cache);
SELECT @@GLOBAL.table_definition_cache = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='table_definition_cache';

SELECT COUNT(@@GLOBAL.table_definition_cache);
SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='table_definition_cache';
--  Checking Variable Scope                                                     #
--###############################################################################
SELECT @@table_definition_cache = @@GLOBAL.table_definition_cache;
SELECT COUNT(@@local.table_definition_cache);
SELECT COUNT(@@SESSION.table_definition_cache);

SELECT COUNT(@@GLOBAL.table_definition_cache);
SELECT table_definition_cache;

-- With new data dictionary (DD) introduced, the size of table definition cache
-- is bit more than expected. 
set @dd_definitions = 14;
set @Open_table_definitions = (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') + @dd_definitions;
set @Opened_table_definitions = (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') + @dd_definitions;
DROP TABLE IF EXISTS tab1;
DROP TABLE IF EXISTS tab2;

let $table = tab1;

let $table = tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 2;

select 1 from tab1;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 1;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 3;

select 1 from tab2;
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 2;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4;

DROP TABLE IF EXISTS tab1;

-- Two extra tables appear since DROP TABLE needs to delete entries for the
-- table being dropped from mysql.index_stats and mysql.table_stats.
--disable_warnings
select (select variable_value from performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 1 + 2;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4 + 2;


DROP TABLE IF EXISTS tab2;
select (select variable_value from
        performance_schema.session_status where variable_name ='Open_table_definitions') = @Open_table_definitions + 2;

select (select variable_value from performance_schema.session_status where variable_name ='Opened_table_definitions') = @Opened_table_definitions + 4 + 2;




--echo --cleanup
set @@GLOBAL.table_definition_cache=DEFAULT;
