CREATE ROLE r1;
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE TABLE db1.t1 (c1 int);
CREATE TABLE db1.t2 (c1 int);
CREATE TABLE db2.t1 (c1 int);
CREATE TABLE db2.t2 (c1 int);

CREATE SQL SECURITY DEFINER VIEW db1.v1 AS SELECT * FROM db1.t1;
CREATE SQL SECURITY DEFINER VIEW db2.v1 AS SELECT * FROM db2.t1;
CREATE SQL SECURITY DEFINER VIEW db1.v2 AS SELECT * FROM db1.t1;
CREATE SQL SECURITY INVOKER VIEW db1.v4 AS SELECT * FROM db2.t2;
SET ROLE r1;
SELECT * FROM v1;
SELECT * FROM db2.v1;
SELECT * FROM v4;
SET ROLE r1;
SELECT * FROM v1;
SET ROLE r1;
SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM db2.v1;
SELECT * FROM v4;
SET ROLE r1;
SELECT * FROM v1;
SELECT * FROM v2;
SELECT * FROM db2.v1;
SELECT * FROM v4;
SET ROLE r1;
SELECT * FROM v1;
SELECT * FROM v4;
CREATE SQL SECURITY DEFINER VIEW db1.v5 AS SELECT * FROM db2.t1;
SELECT * FROM v5;
ALTER USER u1@localhost DEFAULT ROLE r1;
SELECT * FROM v5;
CREATE USER u2@localhost IDENTIFIED BY 'oof';
SELECT * FROM db1.v5;
SELECT * FROM db1.v2;
SELECT * FROM db1.v4;
SELECT * FROM v5;
DROP DATABASE db1;
DROP DATABASE db2;
DROP USER u1@localhost;
DROP ROLE r1;
DROP USER u2@localhost;

CREATE USER user_with_role@localhost;
CREATE ROLE test_role;
SET DEFAULT ROLE test_role TO user_with_role@localhost;

CREATE USER user_without_role@localhost;
USE test;
CREATE TABLE t1 (c1 INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM v1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1;
USE test;
CREATE TABLE t2 (c1 INT);
CREATE VIEW v3 AS SELECT * FROM t2;
CREATE VIEW v4 AS SELECT * FROM v3;
DROP VIEW v3;
CREATE VIEW v3 AS SELECT * FROM t2;

-- Cleanup
--disconnect user_without_role
--disconnect user_with_role
--connection default
--disable_connect_log

DROP VIEW v1, v2, v3, v4;
DROP TABLE t1, t2;

DROP USER user_without_role@localhost;
DROP USER user_with_role@localhost;
DROP ROLE test_role;

CREATE USER user_with_role@localhost;
CREATE ROLE test_role;
SET DEFAULT ROLE test_role TO user_with_role@localhost;

CREATE USER user_without_role@localhost;
USE test;
CREATE TABLE t1 (c1 INT);
CREATE VIEW v1 AS SELECT * FROM t1;
CREATE VIEW v2 AS SELECT * FROM v1;
DROP VIEW v1;
CREATE VIEW v1 AS SELECT * FROM t1;
USE test;
CREATE TABLE t2 (c1 INT);
CREATE VIEW v3 AS SELECT * FROM t2;
CREATE VIEW v4 AS SELECT * FROM v3;
DROP VIEW v3;
CREATE VIEW v3 AS SELECT * FROM t2;

-- Cleanup
--disconnect user_without_role
--disconnect user_with_role
--connection default
--disable_connect_log

DROP VIEW v1, v2, v3, v4;
DROP TABLE t1, t2;

DROP USER user_without_role@localhost;
DROP USER user_with_role@localhost;
DROP ROLE test_role;
