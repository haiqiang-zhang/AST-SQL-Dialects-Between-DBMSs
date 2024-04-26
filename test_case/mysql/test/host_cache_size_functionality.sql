--                                                                             #
-- Variable Name: Host_Cache_Size                                              #
-- Scope: Global                                                               #
-- Access Type: Dynamic                                                        #
-- Data Type: numeric                                                          #
--                                                                             #
--                                                                             #
-- Creation Date: 2012-08-31                                                   #
-- Author : Tanjot Singh Uppal                                                 #
--                                                                             #
--                                                                             #
-- Description:Test Cases of Dynamic System Variable Host_Cache_Size           #
--             that checks the behavior of this variable in the following ways #
--              * Value Check                                                  #
--              * Scope Check                                                  #
--              * Functionality Check                                          #
--              * Accessability Check                                          #
--                                                                             #               
-- This test does not perform the crash recovery on this variable              # 
-- For crash recovery test on default change please run the ibtest             #
--##############################################################################

echo '--________________________VAR_06_Host_Cache_Size__________________#'
echo '--#'
--echo '-----------------------WL6372_VAR_6_01----------------------#'
--###################################################################
--   Checking default value                                         #
--###################################################################
SELECT COUNT(@@GLOBAL.Host_Cache_Size);

set @Default_host_cache_size=(select if(if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))>2000,2000,if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))));

select @@global.Host_Cache_Size=@Default_host_cache_size;

let $restart_file= $MYSQLTEST_VARDIR/tmp/mysqld.1.expect;

SELECT @@GLOBAL.Host_Cache_Size;

set @Default_host_cache_size=(select if(if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))>2000,2000,if(@@global.max_connections<500,128+@@global.max_connections,128+@@global.max_connections+floor((@@global.max_connections-500)/20))));
SET @@GLOBAL.Host_Cache_Size=DEFAULT;
select @@global.Host_Cache_Size=@Default_host_cache_size;
--   Checking Value can be set - Dynamic                            #
--###################################################################
--error ER_GLOBAL_VARIABLE 
SET @@local.Host_Cache_Size=1;
SET @@session.Host_Cache_Size=1;

SET @@GLOBAL.Host_Cache_Size=1;
SET @@GLOBAL.Host_Cache_Size=DEFAULT;

SELECT COUNT(@@GLOBAL.Host_Cache_Size);

select @@global.Host_Cache_Size=@Default_host_cache_size;
SELECT @@GLOBAL.Host_Cache_Size = VARIABLE_VALUE
FROM performance_schema.global_variables
WHERE VARIABLE_NAME='Host_Cache_Size';

SELECT COUNT(@@GLOBAL.Host_Cache_Size);

SELECT COUNT(VARIABLE_VALUE)
FROM performance_schema.global_variables 
WHERE VARIABLE_NAME='Host_Cache_Size';
--  Checking Variable Scope                                                     #
--###############################################################################
SELECT @@Host_Cache_Size = @@GLOBAL.Host_Cache_Size;
SELECT COUNT(@@local.Host_Cache_Size);
SELECT COUNT(@@SESSION.Host_Cache_Size);

SELECT COUNT(@@GLOBAL.Host_Cache_Size);
SELECT Host_Cache_Size;

SET @@GLOBAL.Host_Cache_Size=DEFAULT;
