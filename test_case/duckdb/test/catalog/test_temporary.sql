CREATE TEMPORARY TABLE integers(i INTEGER) ON COMMIT PRESERVE ROWS;
CREATE TEMPORARY TABLE integersx(i INTEGER);
CREATE TEMPORARY TABLE main.integersy(i INTEGER);
CREATE TEMPORARY TABLE s1 AS SELECT 42;
CREATE TABLE temp.integersy(i INTEGER);
CREATE SCHEMA temp;
CREATE TABLE temp.integersy(i INTEGER);
CREATE TABLE memory.temp.integersy(i INTEGER);
DROP SCHEMA temp CASCADE;
DROP TABLE memory.main.integersx;
DROP TABLE integersx;
CREATE TEMPORARY TABLE temp.integersx(i INTEGER);
DROP TABLE temp.integersx;
CREATE TEMPORARY TABLE integers2(i INTEGER) ON COMMIT DELETE ROWS;
CREATE TEMPORARY TABLE integers(i INTEGER);
INSERT INTO integers VALUES (42);
BEGIN TRANSACTION;
CREATE TEMPORARY TABLE integers2(i INTEGER);
CREATE TEMPORARY SEQUENCE seq;
CREATE TEMPORARY VIEW v1 AS SELECT 42;
INSERT INTO integers2 VALUES (42);
COMMIT;
BEGIN TRANSACTION;
CREATE TEMPORARY TABLE integers3(i INTEGER);
INSERT INTO integers3 VALUES (42);
ROLLBACK;
SELECT i from integers3;
INSERT INTO integers VALUES (42);
SELECT * FROM temp.s1;
SELECT * FROM s1;
SELECT i from integers;
SELECT i from integers2;
SELECT nextval('seq');
SELECT * from v1;
SELECT i from integers2;
SELECT nextval('seq');
SELECT * from v1;
SELECT i from integers3;
