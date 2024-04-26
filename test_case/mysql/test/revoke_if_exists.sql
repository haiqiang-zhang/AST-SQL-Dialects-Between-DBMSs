CREATE DATABASE wl14690;
CREATE USER u1,u2,u3,u4;
CREATE ROLE r1,r2;
CREATE TABLE wl14690.t(i int, j int);
CREATE FUNCTION wl14690.fun() RETURNS INT DETERMINISTIC CONTAINS SQL RETURN @var1;

SET @@global.partial_revokes = OFF;
SELECT COUNT(*) FROM mysql.user where user = 'unknown_user';
SELECT COUNT(*) FROM mysql.user where user = 'unknown_user';
SELECT COUNT(*) FROM mysql.user where user = 'unknown_user';
SELECT COUNT(*) FROM mysql.user where user = 'unknown_user';

SET GLOBAL mandatory_roles=r1;
SET GLOBAL mandatory_roles=default;
SET GLOBAL partial_revokes=default;
DROP USER u1,u2,u3,u4;
DROP ROLE r1,r2;
DROP DATABASE wl14690;
