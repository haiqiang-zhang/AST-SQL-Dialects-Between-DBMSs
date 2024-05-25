PRAGMA enable_verification;
BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER NOT NULL, j INTEGER);
INSERT INTO integers SELECT i, i+1 FROM range(0, 1000) tbl(i);
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_test';
INSERT INTO integers VALUES (NULL, NULL);
DROP TABLE integers;
BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER NOT NULL, j INTEGER);
INSERT INTO integers SELECT i, i+1 FROM range(0, 1000) tbl(i);
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET, CODEC 'SNAPPY');
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_test';
INSERT INTO integers VALUES (NULL, NULL);
DROP TABLE integers;
BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER NOT NULL, j INTEGER);
INSERT INTO integers SELECT i, i+1 FROM range(0, 1000) tbl(i);
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET, COMPRESSION ZSTD, ROW_GROUP_SIZE 100000);;
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_test';
INSERT INTO integers VALUES (NULL, NULL);
SELECT SUM(i), SUM(j) FROM integers

statement ok
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET)

statement ok
ROLLBACK

statement ok
IMPORT DATABASE '__TEST_DIR__/export_test'

# verify the data is still there
query II nosort sumresult
SELECT SUM(i), SUM(j) FROM integers

# verify that the not null constraint is still there
statement error
INSERT INTO integers VALUES (NULL, NULL);
SELECT SUM(i), SUM(j) FROM integers

statement ok
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET, CODEC 'SNAPPY')

statement ok
ROLLBACK

statement ok
IMPORT DATABASE '__TEST_DIR__/export_test'

# verify the data is still there
query II nosort sumresult
SELECT SUM(i), SUM(j) FROM integers

# verify that the not null constraint is still there
statement error
INSERT INTO integers VALUES (NULL, NULL);
SELECT SUM(i), SUM(j) FROM integers

statement ok
EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT PARQUET, COMPRESSION ZSTD, ROW_GROUP_SIZE 100000);

statement ok
ROLLBACK

statement ok
IMPORT DATABASE '__TEST_DIR__/export_test'

# verify the data is still there
query II nosort sumresult
SELECT SUM(i), SUM(j) FROM integers

# verify that the not null constraint is still there
statement error
INSERT INTO integers VALUES (NULL, NULL);
