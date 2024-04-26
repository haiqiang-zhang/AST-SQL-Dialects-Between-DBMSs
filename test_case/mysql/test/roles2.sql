set @orig_partial_revokes = @@global.partial_revokes;
SET GLOBAL partial_revokes= OFF;

CREATE ROLE r1;

CREATE USER u1@localhost IDENTIFIED BY 'foo';

CREATE DATABASE db1;

CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;

-- test positive
SELECT * FROM db1.t1;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;

-- test positive
SELECT * FROM db1.t1;

-- side track:
-- set roles to none and verify that privileges are updated!
SET ROLE NONE;
SELECT * FROM db1.t1;
SET ROLE r1;
SELECT * FROM db1.t1;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t2;

-- test positive
SELECT * FROM db1.t1;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT c1 FROM db1.t2;
SELECT c2 FROM db1.t1;


-- test positive
SELECT c1 FROM db1.t1;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
DROP ROLE r1;
DROP USER u1@localhost;
DROP DATABASE db1;
CREATE ROLE r1;
CREATE ROLE r2;

CREATE USER u1@localhost IDENTIFIED BY 'foo';

CREATE DATABASE db1;
CREATE DATABASE db2;

CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t3 (c1 INT, c2 INT, c3 INT);

CREATE TABLE db2.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t2 (c1 INT, c2 INT, c3 INT);
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;

-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;
SELECT * FROM db2.t1;
SELECT * FROM db2.t2;

-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t3;


-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
SET ROLE r1;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT c1 FROM db1.t3;
SELECT c2 FROM db1.t1;

-- test positive
SELECT c1 FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1;
SELECT * FROM db1.t1;
DROP ROLE r1;
DROP ROLE r2;
DROP USER u1@localhost;
DROP DATABASE db1;
DROP DATABASE db2;
CREATE ROLE r1;
CREATE ROLE r2;

CREATE USER u1@localhost IDENTIFIED BY 'foo';

CREATE DATABASE db1;
CREATE DATABASE db2;

CREATE TABLE db1.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t2 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db1.t3 (c1 INT, c2 INT, c3 INT);

CREATE TABLE db2.t1 (c1 INT, c2 INT, c3 INT);
CREATE TABLE db2.t2 (c1 INT, c2 INT, c3 INT);
SET ROLE r1,r2;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;

-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1,r2;
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;
SET ROLE r1,r2;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
UPDATE db1.t2 SET c1=2;
SELECT * FROM db2.t1;
SELECT * FROM db2.t2;

-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1,r2;
SELECT * FROM db1.t1;
SET ROLE r1,r2;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT * FROM db1.t3;


-- test positive
SELECT * FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1,r2;
SELECT * FROM db1.t1;
SET ROLE r1,r2;

-- test negative
--error ER_TABLEACCESS_DENIED_ERROR
UPDATE db1.t1 SET c1=2;
SELECT c1 FROM db1.t3;
SELECT c2 FROM db1.t1;

-- test positive
SELECT c1 FROM db1.t1;
SELECT * FROM db1.t2;

-- test revoke
connection default;
SET ROLE r1,r2;
SELECT * FROM db1.t1;
DROP ROLE r1;
DROP ROLE r2;
DROP USER u1@localhost;
DROP DATABASE db1;
DROP DATABASE db2;
CREATE ROLE r1, r2, r3, r4;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE USER u2@localhost IDENTIFIED BY 'foo';

CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE DATABASE db1aaaa;
CREATE DATABASE dddddb1;
CREATE DATABASE secdb1;
CREATE DATABASE secdb2;

CREATE TABLE db1.t1 (c1 INT);
CREATE TABLE db2.t1 (c2 INT);
CREATE TABLE dddddb1.t1 (c2 INT);
CREATE TABLE db1aaaa.t1 (c2 INT);
CREATE TABLE secdb1.t1 (c1 INT);
CREATE TABLE secdb2.t1 (c2 INT);

INSERT INTO db1.t1 VALUES (1),(2),(3);
INSERT INTO db2.t1 VALUES (1),(2),(3);
INSERT INTO dddddb1.t1 VALUES (1),(2),(3);
INSERT INTO db1aaaa.t1 VALUES (1),(2),(3);
SET ROLE r1;

-- Positive test
SELECT * FROM db1.t1;
SELECT * FROM db2.t1;

-- Negative test
--error ER_TABLEACCESS_DENIED_ERROR
SELECT * FROM db1aaaa.t1;
SELECT * FROM dddddb1.t1;

SET ROLE r2;
SELECT * FROM db1.t1;
SELECT * FROM db2.t1;
SELECT * FROM db1aaaa.t1;

-- Negative test
--error ER_TABLEACCESS_DENIED_ERROR
SELECT * FROM dddddb1.t1;

SET ROLE r3;
SELECT * FROM db1.t1;
SELECT * FROM db2.t1;
SELECT * FROM db1aaaa.t1;

-- Negative test
--error ER_DBACCESS_DENIED_ERROR
GRANT SELECT ON `%db1`.* TO u2@localhost;

SET ROLE r4;

-- Negative test
--error ER_DBACCESS_DENIED_ERROR
GRANT SELECT ON `secdb%`.* TO u2@localhost;
SET ROLE r1;

-- Positive test
INSERT INTO dddddb1.t1 VALUES (1);

-- Negative test
--error ER_TABLEACCESS_DENIED_ERROR
INSERT INTO db2.t1 VALUES (1);
DROP ROLE r1,r2,r3,r4;
DROP USER u1@localhost, u2@localhost;
DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db1aaaa;
DROP DATABASE dddddb1;
DROP DATABASE secdb1;
DROP DATABASE secdb2;
SET GLOBAL partial_revokes = @orig_partial_revokes;
CREATE USER 'u1'@'' IDENTIFIED BY '123';
CREATE USER 'r1'@'' IDENTIFIED BY '123';
CREATE USER 'r2'@'' IDENTIFIED BY '123';
SET DEFAULT ROLE 'r1'@'', 'r2'@'' TO 'u1'@'';
DROP USER 'u1'@'','r1'@'','r2'@'';
