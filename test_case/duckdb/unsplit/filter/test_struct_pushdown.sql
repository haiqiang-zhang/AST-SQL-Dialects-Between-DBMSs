PRAGMA enable_verification;
CREATE TABLE test_structs(i STRUCT(a integer, b bool));;
INSERT INTO test_structs VALUES ({'a': 1, 'b': true}), ({'a': 2, 'b': false}), (NULL), ({'a': 3, 'b': true}), ({'a': NULL, 'b': NULL});;
CREATE TABLE string_structs(s STRUCT(a varchar, b varchar));;
INSERT INTO string_structs VALUES ({'a': 'foo', 'b': 'bar'}), ({'a': 'baz', 'b': 'qux'}), (NULL), ({'a': 'foo', 'b': NULL});;
CREATE TABLE large_structs(i STRUCT(a integer, b bool));;
INSERT INTO large_structs SELECT {'a': n, 'b': n % 2 = 0} FROM generate_series(200000) as t(n);;
CREATE TABLE nested_structs(s STRUCT(a STRUCT(b integer, c bool), d STRUCT(e integer, f varchar)));;
INSERT INTO nested_structs VALUES
	({'a': {'b': 1, 'c': false}, 'd': {'e': 2, 'f': 'foo'}}),
	(NULL),
	({'a': {'b': 3, 'c': true}, 'd': {'e': 4, 'f': 'bar'}}),
	({'a': {'b': NULL, 'c': true}, 'd': {'e': 5, 'f': 'qux'}}),
	({'a': NULL, 'd': NULL});;
COPY (FROM test_structs) TO '__TEST_DIR__/test_structs.parquet' (FORMAT PARQUET);;
COPY (FROM string_structs) TO '__TEST_DIR__/string_structs.parquet' (FORMAT PARQUET);;
COPY (FROM nested_structs) TO '__TEST_DIR__/nested_structs.parquet' (FORMAT PARQUET);;
COPY (SELECT {'i': n} as s FROM generate_series(100000) as t(n)) TO '__TEST_DIR__/large.parquet' (FORMAT 'parquet', ROW_GROUP_SIZE 3000);;
EXPLAIN SELECT * FROM test_structs WHERE i.a < 2;;
SELECT * FROM test_structs WHERE i.a < 2;;
EXPLAIN SELECT * FROM test_structs WHERE i.a > 2;;
SELECT * FROM test_structs WHERE i.a > 2;;
EXPLAIN SELECT * FROM test_structs WHERE i.A < 2;;
SELECT * FROM test_structs WHERE i.A < 2;;
EXPLAIN SELECT * FROM test_structs WHERE i.a IS NULL;;
SELECT * FROM test_structs WHERE i.a IS NULL;;
EXPLAIN SELECT * FROM test_structs WHERE i.a = 2 OR i.a IS NULL;;
SELECT * FROM test_structs WHERE i.a = 2 OR i.a IS NULL ORDER BY 1 DESC NULLS FIRST;;
EXPLAIN SELECT * FROM string_structs WHERE s.a = 'foo';;
SELECT * FROM string_structs WHERE s.a = 'foo';;
EXPLAIN SELECT * FROM large_structs WHERE i.a > 150000;;
EXPLAIN SELECT MIN(i.a), MAX(i.a), COUNT(*) FROM large_structs WHERE i.a > 150000;;
SELECT MIN(i.a), MAX(i.a), COUNT(*) FROM large_structs WHERE i.a > 150000;;
EXPLAIN SELECT * FROM nested_structs WHERE s.a.b < 2;;
SELECT * FROM nested_structs WHERE s.a.b < 2;;
EXPLAIN SELECT * FROM nested_structs WHERE s.a.c = true AND s.d.e = 5;;
SELECT * FROM nested_structs WHERE s.a.c = true AND s.d.e = 5;;
EXPLAIN SELECT * FROM nested_structs WHERE s.d.f = 'bar';;
SELECT * FROM nested_structs WHERE s.d.f = 'bar';;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/test_structs.parquet') WHERE i.a < 2;;
SELECT * FROM read_parquet('__TEST_DIR__/test_structs.parquet') WHERE i.a < 2;;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/test_structs.parquet') WHERE i.b = true or i.a IS NULL;;
SELECT * FROM read_parquet('__TEST_DIR__/test_structs.parquet') WHERE i.b = true or i.a IS NULL ORDER BY ALL;;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/string_structs.parquet') WHERE s.a = 'foo';;
SELECT * FROM read_parquet('__TEST_DIR__/string_structs.parquet') WHERE s.a = 'foo';;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/nested_structs.parquet') WHERE s.a.b < 2;;
SELECT * FROM read_parquet('__TEST_DIR__/nested_structs.parquet') WHERE s.a.b < 2;;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/nested_structs.parquet') WHERE s.a.c = true AND s.d.e = 5;;
SELECT * FROM read_parquet('__TEST_DIR__/nested_structs.parquet') WHERE s.a.c = true AND s.d.e = 5;;
EXPLAIN SELECT * FROM read_parquet('__TEST_DIR__/large.parquet') WHERE s.i >= 500 AND s.i < 5000;;
SELECT min(s.i), max(s.i) FROM read_parquet('__TEST_DIR__/large.parquet') WHERE s.i >= 500 AND s.i < 5000;;
