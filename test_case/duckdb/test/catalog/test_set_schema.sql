CREATE SCHEMA test;;
CREATE SCHEMA out_of_path;;
SET SESSION schema = 'test';;
CREATE TABLE main.main_table(j INTEGER);;
CREATE TABLE test_table(i INTEGER);;
CREATE TABLE out_of_path.oop_table(k INTEGER);;
SELECT * FROM test.test_table;;
SELECT * FROM test_table;;
SELECT * FROM main_table;;
SELECT * FROM out_of_path.oop_table;;
SELECT * FROM out_of_path.test_table;;
SELECT * FROM main.test_table;;
INSERT INTO main.test_table (i) VALUES (1);;
INSERT INTO test_table (i) VALUES (1);;
INSERT INTO test.test_table (i) VALUES (2), (3);;
INSERT INTO main_table (j) VALUES (4);;
INSERT INTO main.main_table (j) VALUES (5), (6);;
INSERT INTO oop_table (k) VALUES (7);;
INSERT INTO out_of_path.oop_table (k) VALUES (8), (9);;
DELETE FROM main.test_table WHERE i=3;;
DELETE FROM test.main_table WHERE i=5;;
DELETE FROM oop_table WHERE k=8;;
DELETE FROM test.test_table WHERE i=1;;
DELETE FROM test_table WHERE i=2;;
DELETE FROM main.main_table WHERE j=4;;
DELETE FROM main_table WHERE j=5;;
DELETE FROM out_of_path.oop_table WHERE k=8;;
UPDATE main.test_table SET i=10 WHERE i=1;;
UPDATE test_table SET i=30 WHERE i=3;;
UPDATE test.test_table SET i=300 WHERE i=30;;
UPDATE main_table SET j=60 WHERE j=6;;
UPDATE main.main_table SET j=600 WHERE j=60;;
CREATE TEMP TABLE test_temp_table(i INTEGER);;
SELECT * FROM memory.main.test_temp_table;;
SELECT * FROM test.test_temp_table;;
SELECT * FROM test_temp_table;;
SELECT * FROM temp.test_temp_table;;
CREATE VIEW test_view AS SELECT * FROM test_table;;
CREATE VIEW main.main_view AS SELECT * FROM main.main_table;;
CREATE VIEW out_of_path.oop_view AS SELECT * FROM out_of_path.oop_table;;
SELECT * FROM main.test_view;;
SELECT * FROM test.test_view;;
SELECT * FROM test_view;;
SELECT * FROM main.main_view;;
SELECT * FROM main_view;;
SELECT * FROM oop_view;;
SELECT * FROM out_of_path.oop_view;;
SET SESSION schema = 'main';;
CREATE VIEW bad_test_view AS SELECT * FROM test_table;;
SET SESSION schema = 'test';;
DROP VIEW main.test_view;
DROP VIEW test_view;
DROP VIEW main_view;
DROP VIEW oop_view;
DROP VIEW out_of_path.oop_view;
CREATE MACRO test_macro(a, b) AS a + b;;
CREATE MACRO test_macro2(c, d) AS c * d;;
CREATE MACRO main.main_macro(a, b) AS a - b;;
CREATE MACRO out_of_path.oop_macro(a, b) AS a * b;;
SELECT main.test_macro(1, 2);;
SELECT oop_macro(1, 2);;
SELECT main_macro(1, 2);;
SELECT main.main_macro(1, 2);;
SELECT test.test_macro(1, 2);;
SELECT test_macro(1, 2);;
SELECT out_of_path.oop_macro(1, 2);;
DROP MACRO main.test_macro;;
DROP MACRO test_macro;;
DROP MACRO test.test_macro2;;
DROP MACRO main_macro;;
DROP MACRO oop_macro;;
DROP MACRO out_of_path.oop_macro;;
CREATE SEQUENCE test_sequence;;
CREATE SEQUENCE test_sequence2;;
CREATE SEQUENCE main.main_sequence;;
CREATE SEQUENCE out_of_path.oop_sequence;;
SELECT main.nextval('main.test_sequence');;
SELECT main.nextval('test.test_sequence');;
SELECT main.nextval('test_sequence');;
SELECT main.nextval('main.main_sequence');;
SELECT main.nextval('main_sequence');;
SELECT main.nextval('oop_sequence');;
SELECT main.nextval('out_of_path.oop_sequence');;
DROP SEQUENCE main.test_sequence;;
DROP SEQUENCE test_sequence;;
DROP SEQUENCE test.test_sequence2;;
DROP SEQUENCE main_sequence;;
DROP SEQUENCE oop_sequence;;
DROP SEQUENCE out_of_path.oop_sequence;;
ALTER TABLE main.test_table ADD COLUMN k INTEGER;;
ALTER TABLE main.main_table ADD COLUMN k INTEGER;;
ALTER TABLE main_table ADD COLUMN l INTEGER;;
ALTER TABLE test_table ADD COLUMN m INTEGER;;
ALTER TABLE test.test_table ADD COLUMN n INTEGER;;
ALTER TABLE oop_table ADD COLUMN o INTEGER;;
ALTER TABLE out_of_path.oop_table ADD COLUMN p INTEGER;;
DROP TABLE main.test_table;;
DROP TABLE test.main_table;;
DROP TABLE test_table;;
DROP TABLE main_table;;
DROP TABLE oop_table;;
DROP TABLE out_of_path.oop_table;;
CREATE TABLE test_table2(i INTEGER);;
DROP TABLE test.test_table2;;
CREATE TABLE test_table3(i INTEGER);;
DROP TABLE IF EXISTS test_table3;;
DROP TABLE IF EXISTS test_table3;;
CREATE TABLE test_table4(i INTEGER);;
DROP TABLE IF EXISTS test.test_table4;;
DROP TABLE IF EXISTS test.test_table4;;
CREATE TABLE main.main_table2(i INTEGER);;
DROP TABLE IF EXISTS main.main_table2;;
DROP TABLE IF EXISTS main.main_table2;;
SELECT i FROM test_table;;
SELECT j FROM main.main_table;;
SELECT k FROM out_of_path.oop_table;;
SELECT i FROM test_table;;
SELECT j FROM main_table;;
SELECT abs(i) FROM test_table;;
SELECT sum(i) FROM test_table;;
