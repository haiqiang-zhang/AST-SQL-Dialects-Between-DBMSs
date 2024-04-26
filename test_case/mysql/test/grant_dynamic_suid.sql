
CREATE USER wl15874@localhost,wl15874_2@localhost;
CREATE DATABASE wl15874;
USE wl15874;
CREATE DEFINER=wl15874_2@localhost PROCEDURE p1() SELECT 1;
CREATE DEFINER=wl15874_2@localhost FUNCTION f1() RETURNS INT RETURN 12;
CREATE DEFINER=wl15874_2@localhost VIEW v1 AS SELECT 1 as 'a';
CREATE VIEW v1 AS SELECT 1 as 'a';
ALTER DEFINER=wl15874_2@localhost VIEW v1 AS SELECT 1 as 'a';
DROP VIEW v1;
CREATE TABLE t1(a INT);
CREATE DEFINER=wl15874_2@localhost TRIGGER t1_trg1 AFTER INSERT ON t1 FOR EACH ROW SET @sum = @sum + 1;
CREATE DEFINER=wl15874_2@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 1;
CREATE EVENT wl15874_ev1
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO SET @sum = @sum + 1;
ALTER DEFINER=wl15874_2@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 2;
DROP EVENT wl15874_ev1;
CREATE DEFINER=CURRENT_USER PROCEDURE p1() SELECT 1;
DROP PROCEDURE p1;
CREATE DEFINER=wl15874_2@localhost PROCEDURE p1() SELECT 1;
DROP USER wl15874_2@localhost;
DROP PROCEDURE p1;
CREATE DEFINER=wl15874_2@localhost FUNCTION f1() RETURNS INT RETURN 12;
DROP USER wl15874_2@localhost;
DROP FUNCTION f1;
CREATE DEFINER=wl15874_2@localhost VIEW v1 AS SELECT 1 as 'a';
DROP USER wl15874_2@localhost;
DROP VIEW v1;
CREATE TABLE t1(a INT);
CREATE DEFINER=wl15874_2@localhost TRIGGER t1_trg1 AFTER INSERT ON t1 FOR EACH ROW SET @sum = @sum + 1;
DROP USER wl15874_2@localhost;
DROP TRIGGER t1_trg1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT 1 as 'a';
ALTER DEFINER=wl15874_2@localhost VIEW v1 AS SELECT 2 as 'a';
DROP VIEW v1;
CREATE DEFINER=wl15874_2@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 1;
DROP USER wl15874_2@localhost;
ALTER DEFINER=wl15874_2@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 2;
DROP EVENT wl15874_ev1;
CREATE DEFINER=wl15874_na@localhost PROCEDURE p1() SELECT 1;
CREATE DEFINER=wl15874_na@localhost PROCEDURE p1() SELECT 1;
CREATE DEFINER=wl15874_na@localhost FUNCTION f1() RETURNS INT RETURN 12;
CREATE DEFINER=wl15874_na@localhost VIEW v1 AS SELECT 1 as 'a';
CREATE TABLE t1(a INT);
CREATE DEFINER=wl15874_na@localhost TRIGGER t1_trg1 AFTER INSERT ON t1 FOR EACH ROW SET @sum = @sum + 1;
ALTER DEFINER=wl15874_na@localhost VIEW v1 AS SELECT 2 as 'a';
CREATE DEFINER=wl15874_na@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 1;
ALTER DEFINER=wl15874_na@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 2;
CREATE USER wl15874_na@localhost;
DROP USER wl15874_na@localhost;
CREATE USER wl15874_na@localhost;
DROP USER wl15874_na_ren@localhost;
CREATE ROLE wl15874_na@localhost;
DROP ROLE wl15874_na@localhost;
CREATE ROLE wl15874_na@localhost;
DROP ROLE wl15874_na_ren@localhost;
DROP PROCEDURE p1;
DROP FUNCTION f1;
DROP VIEW v1;
DROP TRIGGER t1_trg1;
DROP TABLE t1;
DROP EVENT wl15874_ev1;
CREATE DEFINER=wl15874_na@localhost PROCEDURE p1() SELECT 1;
CREATE DEFINER=wl15874_na@localhost FUNCTION f1() RETURNS INT RETURN 12;
CREATE DEFINER=wl15874_na@localhost VIEW v1 AS SELECT 1 as 'a';
CREATE TABLE t1(a INT);
CREATE DEFINER=wl15874_na@localhost TRIGGER t1_trg1 AFTER INSERT ON t1 FOR EACH ROW SET @sum = @sum + 1;

DROP TABLE t1;

CREATE VIEW v1 as SELECT 3 as 'a';
ALTER DEFINER=wl15874_na@localhost VIEW v1 AS SELECT 2 as 'a';

DROP VIEW v1;
CREATE DEFINER=wl15874_na@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 1;


CREATE EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 1;
ALTER DEFINER=wl15874_na@localhost EVENT wl15874_ev1
  ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 HOUR
  DO SET @sum = @sum + 2;

DROP EVENT wl15874_ev1;
SELECT GRANTEE FROM INFORMATION_SCHEMA.USER_PRIVILEGES
WHERE PRIVILEGE_TYPE = 'SET_USER_ID' AND GRANTEE LIKE '%wl15874_2%' ORDER BY 1;
DROP DATABASE wl15874;
DROP USER wl15874@localhost,wl15874_2@localhost;