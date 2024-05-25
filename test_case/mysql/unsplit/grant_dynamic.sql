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
DROP DATABASE restricted;
DROP TABLE IF EXISTS test.t1;
SELECT 'helloworld';
SELECT 'helloworld';
SELECT 'helloworld';
SELECT 'helloworld';
CREATE DATABASE db1_protected;
CREATE DATABASE db1;
DROP DATABASE db1_protected;
DROP DATABASE db1;
