SET allow_experimental_analyzer=1;
CREATE TABLE test (
  id UInt64
)
ENGINE = MergeTree()
SAMPLE BY intHash32(id)
ORDER BY intHash32(id);
SELECT
  any(id),
  any(id) AS id
FROM test
SETTINGS prefer_column_name_to_alias = 1;
