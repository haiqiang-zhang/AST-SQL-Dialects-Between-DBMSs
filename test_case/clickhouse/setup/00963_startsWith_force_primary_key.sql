DROP TABLE IF EXISTS test_startsWith;
CREATE TABLE test_startsWith (a String) Engine = MergeTree PARTITION BY tuple() ORDER BY a;
INSERT INTO test_startsWith (a) values ('a'), ('abcd'), ('bbb'), (''), ('abc');
