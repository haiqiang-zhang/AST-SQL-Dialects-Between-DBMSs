CREATE ROLE r1;

CREATE ROLE `admin-db1`;
CREATE ROLE `admin-db2`;
CREATE ROLE `admin-db1t1`;
CREATE ROLE `admin-db2t1`;
CREATE ROLE `app-updater`;

CREATE USER `app-middleware-db1`@`localhost` IDENTIFIED BY 'foo';
CREATE USER `app-middleware-db2`@`localhost` IDENTIFIED BY 'foo';
CREATE USER `app`@`localhost` IDENTIFIED BY 'foo';

CREATE DATABASE db1;
CREATE DATABASE db2;

CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t2 (c1 INT, c2 INT, c3 INT);
SET ROLE `admin-db1`;
INSERT INTO db1.t1 VALUES (1,2,3);
INSERT INTO db1.t2 VALUES (1,2,3);
INSERT INTO db2.t1 VALUES (1,2,3);

SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
SELECT * FROM db2.t1;
SET ROLE `admin-db1`;
INSERT INTO db2.t2 VALUES (1,2,3);
SELECT * FROM db2.t2;
SET ROLE `admin-db1t1`;
SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT ExtractValue(ROLES_GRAPHML(),'count(//node)') as num_nodes;
SELECT ExtractValue(ROLES_GRAPHML(),'count(//edge)') as num_edges;
SET ROLE ALL;
SELECT CURRENT_USER(), CURRENT_ROLE();
SELECT CURRENT_USER(), CURRENT_ROLE();
DROP DATABASE db1;
DROP DATABASE db2;
DROP ROLE r1;
DROP ROLE `admin-db1`;
DROP ROLE `admin-db2`;
DROP ROLE `admin-db1t1`;
DROP ROLE `admin-db2t1`;
DROP ROLE `app-updater`;
DROP USER `app-middleware-db1`@`localhost`;
DROP USER `app-middleware-db2`@`localhost`;
DROP USER `app`@`localhost`;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE USER u2@localhost IDENTIFIED BY 'foo';
CREATE ROLE r1;
CREATE DATABASE db1;
SET ROLE ALL;
SET ROLE NONE;

DROP USER u1@localhost, u2@localhost;
DROP ROLE r1;
DROP DATABASE db1;
SELECT user,host FROM mysql.user;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE USER u2@localhost IDENTIFIED BY 'foo';
CREATE ROLE r1, r2;
use test;
SET ROLE ALL;
CREATE USER u3@localhost IDENTIFIED BY 'foo';
CREATE ROLE role_admin, arbitrary_role;
SET ROLE role_admin;
DROP USER u1@localhost, u2@localhost, u3@localhost;
DROP ROLE r1,r2,role_admin,arbitrary_role;
CREATE USER `u1`@`%` IDENTIFIED BY 'foo';
CREATE USER `u2`@`%` IDENTIFIED BY 'foo';
CREATE ROLE r1, r2, r3;

-- Connect as u1 - Trying to grant r1,r2,r3 to other use u2 fails as expected.
connect(con1, localhost, u1, foo, test);
SET ROLE all;

-- Connect as root
--connection default
GRANT r3 TO r2 WITH ADMIN OPTION;
SELECT * FROM mysql.role_edges;
SET ROLE all;
SET ROLE r3;
SET ROLE r3;
SET ROLE r3;
SELECT * FROM mysql.role_edges;
SELECT * FROM mysql.role_edges;

DROP ROLE r1,r2,r3;
DROP USER u1,u2;
