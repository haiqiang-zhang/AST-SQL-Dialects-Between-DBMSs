DETACH TABLE mview;
ATTACH TABLE mview;
CREATE TABLE test_table (n Int32, s String) ENGINE MergeTree PARTITION BY n ORDER BY n;
INSERT INTO test_table VALUES (3,'some_val');
SELECT n,s  FROM test_table ORDER BY n;
SELECT n,n2 FROM mview ORDER by n;
