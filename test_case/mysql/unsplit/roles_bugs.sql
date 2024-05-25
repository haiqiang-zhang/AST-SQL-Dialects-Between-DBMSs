SELECT CHARSET(CURRENT_ROLE()) = @@character_set_system;
SELECT CHARSET(ROLES_GRAPHML()) = @@character_set_system;
CREATE TABLE t1 AS
  SELECT CURRENT_ROLE() AS CURRENT_ROLE, ROLES_GRAPHML() AS ROLES_GRAPHML;
DROP TABLE t1;
SELECT CHARSET(CURRENT_ROLE()) = @@character_set_system;
SELECT CHARSET(ROLES_GRAPHML()) = @@character_set_system;
CREATE DATABASE my_db;
CREATE table my_db.t1 (id int primary key);
DROP DATABASE my_db;
CREATE DATABASE bug_test;
CREATE TABLE bug_test.test_table (test_id int, test_data varchar(50),
row_is_verified bool);
SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT CURRENT_USER(), CURRENT_ROLE();
DROP DATABASE bug_test;
SELECT current_role(), current_user();
CREATE DATABASE testdb1;
CREATE TABLE testdb1.t1(c1 int);
SELECT CURRENT_USER();
SELECT CURRENT_USER();
CREATE DATABASE testdb2;
CREATE TABLE testdb2.t2(c2 int);
SELECT CURRENT_USER();
DROP DATABASE testdb1;
DROP DATABASE testdb2;
