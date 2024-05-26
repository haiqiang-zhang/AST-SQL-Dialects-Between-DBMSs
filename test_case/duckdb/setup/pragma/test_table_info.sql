CREATE TABLE integers(i INTEGER DEFAULT 1+3, j INTEGER);
CREATE VIEW v1 AS SELECT 42::INTEGER AS a, 'hello' AS b;
CREATE VIEW v2(c) AS SELECT 42::INTEGER AS a, 'hello' AS b;
CREATE VIEW v3(c, d) AS SELECT DATE '1992-01-01', 'hello' AS b;
CREATE SCHEMA test;
CREATE VIEW test.v1 AS SELECT 42::INTEGER AS a, 'hello' AS b;
create table tconstraint1(i integer primary key default(3), j blob not null);
create table tconstraint2(i integer, j integer, k integer, l integer unique, primary key(i, j, k));
create table t1 (
	c1 int,
	c2 int generated always as (c1 + 1)
);
PRAGMA table_info('integers');
PRAGMA table_info(integers);
PRAGMA table_info='integers';
PRAGMA table_info=integers;
PRAGMA table_info('v1');
PRAGMA table_info('v2');
PRAGMA table_info('v3');
PRAGMA table_info('test.v1');
PRAGMA table_info(tconstraint1);
PRAGMA table_info(tconstraint2);
