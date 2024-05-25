CREATE TABLE sequence_test_table (a int);
DROP TABLE sequence_test_table;
CREATE SEQUENCE sequence_test5 AS integer;
CREATE SEQUENCE sequence_test6 AS smallint;
CREATE SEQUENCE sequence_test7 AS bigint;
CREATE SEQUENCE sequence_test8 AS integer MAXVALUE 100000;
CREATE SEQUENCE sequence_test9 AS integer INCREMENT BY -1;
CREATE SEQUENCE sequence_test10 AS integer MINVALUE -100000 START 1;
CREATE SEQUENCE sequence_test11 AS smallint;
CREATE SEQUENCE sequence_test12 AS smallint INCREMENT -1;
CREATE SEQUENCE sequence_test13 AS smallint MINVALUE -32768;
CREATE SEQUENCE sequence_test14 AS smallint MAXVALUE 32767 INCREMENT -1;
ALTER SEQUENCE sequence_test5 AS smallint;
ALTER SEQUENCE sequence_test8 AS smallint MAXVALUE 20000;
ALTER SEQUENCE sequence_test9 AS smallint;
ALTER SEQUENCE sequence_test10 AS smallint MINVALUE -20000;
ALTER SEQUENCE sequence_test11 AS int;
ALTER SEQUENCE sequence_test12 AS int;
ALTER SEQUENCE sequence_test13 AS int;
ALTER SEQUENCE sequence_test14 AS int;
CREATE TABLE serialTest1 (f1 text, f2 serial);
INSERT INTO serialTest1 VALUES ('foo');
INSERT INTO serialTest1 VALUES ('bar');
INSERT INTO serialTest1 VALUES ('force', 100);
SELECT * FROM serialTest1;
SELECT pg_get_serial_sequence('serialTest1', 'f2');
CREATE TABLE serialTest2 (f1 text, f2 serial, f3 smallserial, f4 serial2,
  f5 bigserial, f6 serial8);
INSERT INTO serialTest2 (f1)
  VALUES ('test_defaults');
INSERT INTO serialTest2 (f1, f2, f3, f4, f5, f6)
  VALUES ('test_max_vals', 2147483647, 32767, 32767, 9223372036854775807,
          9223372036854775807),
         ('test_min_vals', -2147483648, -32768, -32768, -9223372036854775808,
          -9223372036854775808);
SELECT * FROM serialTest2 ORDER BY f2 ASC;
SELECT nextval('serialTest2_f2_seq');
SELECT nextval('serialTest2_f3_seq');
SELECT nextval('serialTest2_f4_seq');
SELECT nextval('serialTest2_f5_seq');
SELECT nextval('serialTest2_f6_seq');
CREATE SEQUENCE sequence_test;
CREATE SEQUENCE IF NOT EXISTS sequence_test;
SELECT nextval('sequence_test'::text);
SELECT nextval('sequence_test'::regclass);
SELECT currval('sequence_test'::text);
SELECT currval('sequence_test'::regclass);
SELECT setval('sequence_test'::text, 32);
SELECT nextval('sequence_test'::regclass);
SELECT setval('sequence_test'::text, 99, false);
SELECT nextval('sequence_test'::regclass);
SELECT setval('sequence_test'::regclass, 32);
SELECT nextval('sequence_test'::text);
SELECT setval('sequence_test'::regclass, 99, false);
SELECT nextval('sequence_test'::text);
DISCARD SEQUENCES;
DROP SEQUENCE sequence_test;
CREATE SEQUENCE foo_seq;
ALTER TABLE foo_seq RENAME TO foo_seq_new;
SELECT * FROM foo_seq_new;
SELECT nextval('foo_seq_new');
SELECT nextval('foo_seq_new');
SELECT last_value, log_cnt IN (31, 32) AS log_cnt_ok, is_called FROM foo_seq_new;
DROP SEQUENCE foo_seq_new;
ALTER TABLE serialtest1_f2_seq RENAME TO serialtest1_f2_foo;
INSERT INTO serialTest1 VALUES ('more');
SELECT * FROM serialTest1;
CREATE TEMP SEQUENCE myseq2;
CREATE TEMP SEQUENCE myseq3;
CREATE TEMP TABLE t1 (
  f1 serial,
  f2 int DEFAULT nextval('myseq2'),
  f3 int DEFAULT nextval('myseq3'::text)
);
DROP SEQUENCE myseq3;
DROP TABLE t1;
DROP SEQUENCE myseq2;
ALTER SEQUENCE IF EXISTS sequence_test2 RESTART WITH 24
  INCREMENT BY 4 MAXVALUE 36 MINVALUE 5 CYCLE;
CREATE SEQUENCE sequence_test2 START WITH 32;
CREATE SEQUENCE sequence_test4 INCREMENT BY -1;
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test4');
ALTER SEQUENCE sequence_test2 RESTART;
SELECT nextval('sequence_test2');
ALTER SEQUENCE sequence_test2 RESTART WITH 24
  INCREMENT BY 4 MAXVALUE 36 MINVALUE 5 CYCLE;
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
ALTER SEQUENCE sequence_test2 RESTART WITH 24
  NO CYCLE;
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
ALTER SEQUENCE sequence_test2 RESTART WITH -24 START WITH -24
  INCREMENT BY -4 MINVALUE -36 MAXVALUE -5 CYCLE;
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
ALTER SEQUENCE sequence_test2 RESTART WITH -24
  NO CYCLE;
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
SELECT nextval('sequence_test2');
ALTER SEQUENCE IF EXISTS sequence_test2 RESTART WITH 32 START WITH 32
  INCREMENT BY 4 MAXVALUE 36 MINVALUE 5 CYCLE;
SELECT setval('sequence_test2', 5);
CREATE SEQUENCE sequence_test3;
SELECT * FROM information_schema.sequences
  WHERE sequence_name ~ ANY(ARRAY['sequence_test', 'serialtest'])
  ORDER BY sequence_name ASC;
SELECT schemaname, sequencename, start_value, min_value, max_value, increment_by, cycle, cache_size, last_value
FROM pg_sequences
WHERE sequencename ~ ANY(ARRAY['sequence_test', 'serialtest'])
  ORDER BY sequencename ASC;
SELECT * FROM pg_sequence_parameters('sequence_test4'::regclass);
COMMENT ON SEQUENCE sequence_test2 IS 'will work';
COMMENT ON SEQUENCE sequence_test2 IS NULL;
CREATE SEQUENCE seq;
SELECT nextval('seq');
SELECT lastval();
SELECT setval('seq', 99);
SELECT lastval();
DISCARD SEQUENCES;
CREATE SEQUENCE seq2;
SELECT nextval('seq2');
SELECT lastval();
DROP SEQUENCE seq2;
CREATE UNLOGGED SEQUENCE sequence_test_unlogged;
ALTER SEQUENCE sequence_test_unlogged SET LOGGED;
ALTER SEQUENCE sequence_test_unlogged SET UNLOGGED;
DROP SEQUENCE sequence_test_unlogged;
CREATE TEMPORARY SEQUENCE sequence_test_temp1;
START TRANSACTION READ ONLY;
SELECT nextval('sequence_test_temp1');
ROLLBACK;
START TRANSACTION READ ONLY;
SELECT setval('sequence_test_temp1', 1);
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
DROP TABLE serialTest1, serialTest2;
SELECT * FROM information_schema.sequences WHERE sequence_name IN
  ('sequence_test2', 'serialtest2_f2_seq', 'serialtest2_f3_seq',
   'serialtest2_f4_seq', 'serialtest2_f5_seq', 'serialtest2_f6_seq')
  ORDER BY sequence_name ASC;
DROP SEQUENCE seq;
CREATE SEQUENCE test_seq1 CACHE 10;
SELECT nextval('test_seq1');
SELECT nextval('test_seq1');
SELECT nextval('test_seq1');
DROP SEQUENCE test_seq1;
