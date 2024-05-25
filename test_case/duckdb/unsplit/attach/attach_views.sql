PRAGMA enable_verification;
ATTACH DATABASE ':memory:' AS new_database;
CREATE TABLE t1 AS SELECT 42 i;
CREATE SCHEMA new_database.s1;
