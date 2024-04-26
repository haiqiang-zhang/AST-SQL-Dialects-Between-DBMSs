
--
-- Test behavior of various per-account limits (aka quotas)
--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

set @orig_sql_mode= @@sql_mode;

-- Prepare play-ground
--disable_warnings
drop table if exists t1;
create table t1 (i int);
delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

-- Limits doesn't work with prepared statements (yet)
--disable_ps_protocol

-- Test of MAX_QUERIES_PER_HOUR limit
create user mysqltest_1@localhost with max_queries_per_hour 2;
select * from t1;
select * from t1;
select * from t1;
select * from t1;
drop user mysqltest_1@localhost;

-- Test of MAX_UPDATES_PER_HOUR limit
create user mysqltest_1@localhost with max_updates_per_hour 2;
select * from t1;
select * from t1;
select * from t1;
delete from t1;
delete from t1;
delete from t1;
select * from t1;
delete from t1;
select * from t1;
drop user mysqltest_1@localhost;

-- Test of MAX_CONNECTIONS_PER_HOUR limit
create user mysqltest_1@localhost with max_connections_per_hour 2;
select * from t1;
select * from t1;
select * from t1;
drop user mysqltest_1@localhost;

-- Test of MAX_USER_CONNECTIONS limit
-- We need this to reset internal mqh_used variable
flush privileges;
create user mysqltest_1@localhost with max_user_connections 2;
select * from t1;
select * from t1;
select * from t1;
alter user mysqltest_1@localhost with max_user_connections 3;
select * from t1;
drop user mysqltest_1@localhost;

-- Now let us test interaction between global and per-account
-- max_user_connections limits
select @@session.max_user_connections, @@global.max_user_connections;
set session max_user_connections= 2;
set global max_user_connections= 2;
select @@session.max_user_connections, @@global.max_user_connections;
create user mysqltest_1@localhost;
select @@session.max_user_connections, @@global.max_user_connections;
select * from t1;
alter user mysqltest_1@localhost with max_user_connections 3;
select @@session.max_user_connections, @@global.max_user_connections;
set global max_user_connections= 0;
drop user mysqltest_1@localhost;

-- Final cleanup
drop table t1;

set sql_mode= @orig_sql_mode;
