SELECT CHARSET(CURRENT_ROLE()) = @@character_set_system;
SELECT CHARSET(ROLES_GRAPHML()) = @@character_set_system;
CREATE TABLE t1 AS
  SELECT CURRENT_ROLE() AS CURRENT_ROLE, ROLES_GRAPHML() AS ROLES_GRAPHML;
DROP TABLE t1;
CREATE ROLE r1;
SET ROLE r1;
SELECT CHARSET(CURRENT_ROLE()) = @@character_set_system;
SELECT CHARSET(ROLES_GRAPHML()) = @@character_set_system;
SET ROLE DEFAULT;
DROP ROLE r1;

CREATE USER uu@localhost, u1@localhost;
CREATE ROLE r1;
DROP USER u1@localhost;
DROP ROLE u1@localhost;
DROP ROLE r1;
DROP USER uu@localhost, u1@localhost;

-- Setup
CREATE DATABASE my_db;
CREATE table my_db.t1 (id int primary key);
CREATE ROLE my_role;
CREATE USER my_user, foo@localhost, baz@localhost;
SET DEFAULT ROLE my_role TO my_user;

-- Stored procedure with the definer who has ALL of global privilege granted
-- directly.
DELIMITER $$;
CREATE DEFINER=foo@localhost PROCEDURE my_db.foo_proc()
BEGIN
INSERT into my_db.t1 values(2) on duplicate key UPDATE id = values(id) + 200;
END $$
DELIMITER ;

-- Stored procedure with the definer who is granted a role to which all global
-- privileges are granted.
DELIMITER $$;
CREATE DEFINER=baz@localhost PROCEDURE my_db.baz_proc()
BEGIN
set ROLE all;
INSERT into my_db.t1 values(4) on duplicate key UPDATE id = values(id) + 400;
END $$
DELIMITER ;
INSERT into my_db.t1 values(5);
INSERT into my_db.t1 values(8) on duplicate key UPDATE id = values(id) + 800;
INSERT into my_db.t1 values(10);
DROP DATABASE my_db;
DROP USER my_user;
DROP USER foo@localhost, baz@localhost;
DROP ROLE my_role;
CREATE USER u1, u2;
CREATE ROLE r1, r2;
SET ROLE r1;
DROP ROLE r1, r2;
DROP USER u1, u2;

CREATE USER u1;
CREATE ROLE r1, r2;
CREATE USER u2 DEFAULT ROLE r1;
CREATE USER u3 DEFAULT ROLE r2;
DROP ROLE r1, r2;
DROP USER u1, u2;
CREATE DATABASE bug_test;
CREATE TABLE bug_test.test_table (test_id int, test_data varchar(50),
row_is_verified bool);
INSERT INTO bug_test.test_table VALUES(1, 'valueA', FALSE);
CREATE ROLE `r_verifier`@`localhost`;
CREATE USER `TestUserFails`@`localhost` IDENTIFIED BY 'test';
CREATE USER `TestUserWorks`@`localhost` IDENTIFIED BY 'test';
SET DEFAULT ROLE `r_verifier`@`localhost` TO `TestUserFails`@`localhost`;
SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT test_id, test_data, row_is_verified FROM bug_test.test_table;
UPDATE bug_test.test_table SET row_is_verified = TRUE WHERE test_id=1;
SELECT test_id, test_data, row_is_verified FROM bug_test.test_table;
SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT test_id, test_data, row_is_verified FROM bug_test.test_table;
UPDATE bug_test.test_table SET row_is_verified = TRUE WHERE test_id=1;

DROP USER `TestUserFails`@`localhost`, `TestUserWorks`@`localhost`;
DROP ROLE `r_verifier`@`localhost`;
DROP DATABASE bug_test;
CREATE ROLE r1,r2,r3,r4;

SET @save_mandatory_roles = @@global.mandatory_roles;
SET GLOBAL mandatory_roles = 'r4';

SET GLOBAL mandatory_roles = @save_mandatory_roles;
DROP ROLE r1,r2,r3,r4;
CREATE ROLE test_role;
CREATE USER test_user DEFAULT ROLE test_role;
SELECT current_role(), current_user();
DROP ROLE test_role;
DROP USER test_user;

CREATE DATABASE testdb1;
CREATE TABLE testdb1.t1(c1 int);
CREATE USER testuser;
SELECT CURRENT_USER();
USE testdb1;
SET ROLE DEFAULT;
SET ROLE ALL;
SET ROLE NONE;
SELECT CURRENT_USER();

CREATE DATABASE testdb2;
CREATE TABLE testdb2.t2(c2 int);
CREATE ROLE testrole;
SELECT CURRENT_USER();
SET ROLE testrole;
USE testdb2;
SET ROLE DEFAULT;
SET ROLE testrole;
USE testdb2;
SET ROLE ALL EXCEPT testrole;
DROP DATABASE testdb1;
DROP DATABASE testdb2;
DROP ROLE testrole;
DROP USER testuser;
