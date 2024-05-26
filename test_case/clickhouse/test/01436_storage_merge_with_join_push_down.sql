SELECT count() FROM test_merge
JOIN (SELECT 'anystring' AS name) AS n
USING name
WHERE id = 1;
DROP TABLE test1;
DROP TABLE test_merge;
CREATE TABLE test1 (id Int64, name String) ENGINE MergeTree PARTITION BY (id) ORDER BY (id);
CREATE TABLE test_merge AS test1 ENGINE = Merge('default', 'test1');
DROP TABLE test1;
DROP TABLE test_merge;
