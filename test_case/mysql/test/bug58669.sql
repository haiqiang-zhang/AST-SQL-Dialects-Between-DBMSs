
CREATE USER user1@localhost;
CREATE DATABASE db1;
CREATE TABLE db1.t1(a INT);
SELECT CURRENT_USER();
INSERT INTO db1.t1 VALUES (1);
DROP DATABASE db1;
DROP USER user1@localhost;
