SET allow_experimental_analyzer=1;
CREATE TABLE test (
  id UInt64
)
ENGINE = MergeTree()
SAMPLE BY intHash32(id)
ORDER BY intHash32(id);
