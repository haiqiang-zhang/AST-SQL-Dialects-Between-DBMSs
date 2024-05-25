PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);
PRAGMA storage_info('integers');
INSERT INTO integers VALUES (1, 1), (2, NULL), (3, 3), (4, 5);
PRAGMA storage_info('integers');
CREATE VIEW v1 AS SELECT 42;
CREATE TABLE different_types(i INTEGER, j VARCHAR, k STRUCT(k INTEGER, l VARCHAR));
INSERT INTO different_types VALUES (1, 'hello', {'k': 3, 'l': 'hello'}), (2, 'world', {'k': 3, 'l': 'thisisaverylongstring'});
PRAGMA storage_info('different_types');
CREATE TABLE nested_lists AS SELECT
	[1, 2, 3] i,
	[['hello', 'world'], [NULL]] j,
	[{'a': 3}, {'a': 4}] k;
PRAGMA storage_info('nested_lists');
