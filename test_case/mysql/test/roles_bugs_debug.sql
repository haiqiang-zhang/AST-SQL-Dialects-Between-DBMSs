--    until next SQL statement is executed.
-- 2. In case of privileges are revokes from a user changes are visible
--    immediately to the current SQL statement.

-- Setup
CREATE DATABASE my_db;
CREATE table my_db.t1 (id int primary key);
CREATE ROLE foo_role;
CREATE USER foo, bar;
SET DEFAULT ROLE foo_role TO foo;
SET DEBUG_SYNC='in_check_grant_all_columns SIGNAL s1 WAIT_FOR s2';
SET DEBUG_SYNC='now WAIT_FOR s1';
SET DEBUG_SYNC='after_table_grant_revoke SIGNAL s2';
SET DEBUG_SYNC= 'RESET';
INSERT into my_db.t1 values(9) on duplicate key UPDATE id = values(id) + 90;
SET DEBUG_SYNC='in_check_grant_all_columns SIGNAL s1 WAIT_FOR s2';
SET DEBUG_SYNC='now WAIT_FOR s1';
SET DEBUG_SYNC='after_table_grant_revoke SIGNAL s2';
INSERT into my_db.t1 values(9) on duplicate key UPDATE id = values(id) + 90;
SET DEBUG_SYNC= 'RESET';
DROP DATABASE my_db;
DROP USER foo, bar;
DROP ROLE foo_role;

CREATE USER b35471453@localhost;
CREATE TABLE t35471453(c1 INT);
CREATE OR REPLACE DEFINER = 'role_35471453' VIEW v35471453
  AS TABLE t35471453;
CREATE OR REPLACE DEFINER = 'role_35471453' VIEW v35471453
  AS TABLE t35471453;
DROP ROLE IF EXISTS role_35471453;
DROP ROLE IF EXISTS role_35471453;

DROP VIEW v35471453;
DROP TABLE t35471453;
DROP USER b35471453@localhost;
