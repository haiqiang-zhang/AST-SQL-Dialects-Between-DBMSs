CREATE TABLE test_table_raw(id VARCHAR, name VARCHAR);
INSERT INTO test_table_raw VALUES
	('abc001','foo'),
	('abc002','bar'),
	('abc001','foo2'),
	('abc002','bar2');
CREATE TABLE test_table(id VARCHAR PRIMARY KEY, name VARCHAR);
SELECT * FROM test_table_raw;
