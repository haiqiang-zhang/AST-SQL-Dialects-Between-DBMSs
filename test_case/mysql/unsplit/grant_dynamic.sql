SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE
LIKE '%u1%' ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u2%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
CREATE TABLE t1 (c1 int);
DROP TABLE t1;
CREATE DATABASE restricted;
CREATE TABLE restricted.t1 (c1 int, restricted int);
CREATE TABLE test.t1 (c1 INT);
DROP DATABASE restricted;
DROP TABLE test.t1;
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1(a int);
SELECT 'helloworld';
SELECT 'helloworld';
SELECT 'helloworld';
SELECT 'helloworld';
DROP TABLE test.t1;
CREATE DATABASE db1_protected;
CREATE DATABASE db1;
DROP DATABASE db1_protected;
DROP DATABASE db1;
