
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

-- Test of GRANT commands

SET NAMES binary;

set @orig_sql_mode_session= @@SESSION.sql_mode;
set @orig_sql_mode_global= @@GLOBAL.sql_mode;
set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;

-- Cleanup
--disable_warnings
drop table if exists t1;

delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

create user mysqltest_1@localhost;
create user mysqltest_2@localhost;

delete from mysql.user where user like 'mysqltest\_%';
delete from mysql.db where user like 'mysqltest\_%';
delete from mysql.tables_priv where user like 'mysqltest\_%';
delete from mysql.columns_priv where user like 'mysqltest\_%';

--
-- Bug#19828 Case sensitivity in Grant/Revoke
--

create user CUser@localhost;
create user CUser@LOCALHOST;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser' order by 1,2;

DROP USER CUser@localhost;
DROP USER CUser@LOCALHOST;
create table t1 (a int);
create user CUser@localhost;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

DROP USER CUser@localhost;
DROP USER CUser@LOCALHOST;

create user  CUser@localhost;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser' order by 1,2;
SELECT user, host, db, Table_name, Table_priv, Column_priv FROM mysql.tables_priv where user = 'CUser' order by 1,2;

DROP USER CUser@localhost;
DROP USER CUser@LOCALHOST;

drop table t1;

-- revoke on a specific DB only

create user  CUser2@LOCALHOST;

SELECT user, host FROM mysql.user where user = 'CUser2' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser2' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser2' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser2' order by 1,2;

SELECT user, host FROM mysql.user where user = 'CUser2' order by 1,2;
SELECT user, host, db, select_priv FROM mysql.db where user = 'CUser2' order by 1,2;

DROP USER CUser2@localhost;
DROP USER CUser2@LOCALHOST;


--
-- Bug#31194 Privilege ordering does not order properly for wildcard values
--

CREATE DATABASE mysqltest_1;
CREATE TABLE mysqltest_1.t1 (a INT);
CREATE USER 'mysqltest1'@'%';
SELECT * FROM mysqltest_1.t1;
DROP USER 'mysqltest1'@'%';
DROP DATABASE mysqltest_1;

CREATE DATABASE temp;
CREATE TABLE temp.t1(a INT, b VARCHAR(10));
INSERT INTO temp.t1 VALUES(1, 'name1');
INSERT INTO temp.t1 VALUES(2, 'name2');
INSERT INTO temp.t1 VALUES(3, 'name3');


CREATE USER 'user1'@'%';
SELECT a FROM temp.t1;
SELECT b FROM temp.t1;
DROP USER 'user2'@'%';
DROP DATABASE temp;

set GLOBAL sql_mode= @orig_sql_mode_global;
set SESSION sql_mode= @orig_sql_mode_session;
SET GLOBAL partial_revokes = @orig_partial_revokes;
