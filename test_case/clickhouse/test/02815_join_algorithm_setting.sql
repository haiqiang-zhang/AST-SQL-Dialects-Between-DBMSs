SELECT value == 'default' FROM system.settings WHERE name = 'join_algorithm';
SELECT countIf(explain like '%Algorithm: DirectKeyValueJoin%'), countIf(explain like '%Algorithm: HashJoin%') FROM (
    EXPLAIN PLAN actions = 1
    SELECT * FROM ( SELECT k AS key FROM t2 ) AS t2
    INNER JOIN rdb ON rdb.key = t2.key
    ORDER BY key ASC
);
SET join_algorithm = 'direct, hash';
SELECT value == 'direct,hash' FROM system.settings WHERE name = 'join_algorithm';
SET join_algorithm = 'hash, direct';
SELECT value == 'hash,direct' FROM system.settings WHERE name = 'join_algorithm';
SET join_algorithm = 'grace_hash,hash';
SELECT value == 'grace_hash,hash' FROM system.settings WHERE name = 'join_algorithm';
SET join_algorithm = 'grace_hash, hash, auto';
SELECT value = 'grace_hash,hash,auto' FROM system.settings WHERE name = 'join_algorithm';
DROP DICTIONARY IF EXISTS dict;
DROP TABLE IF EXISTS src;
CREATE TABLE src (id UInt64, s String) ENGINE = MergeTree ORDER BY id
AS SELECT number, toString(number) FROM numbers(1000000);
CREATE DICTIONARY dict(
  id UInt64,
  s  String
) PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE 'src' DB currentDatabase()))
LIFETIME (MIN 0 MAX 0)
LAYOUT(HASHED());
SET join_algorithm = 'default';
SET join_algorithm = 'direct,hash';
SET join_algorithm = 'hash,direct';
