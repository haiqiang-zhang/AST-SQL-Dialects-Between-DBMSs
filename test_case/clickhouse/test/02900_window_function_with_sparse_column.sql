SELECT last_value(value) OVER (ORDER BY time ASC) as last_value
FROM test1
WHERE (key = 3);
SELECT last_value(value) OVER (PARTITION BY id ORDER BY time ASC) as last_value
FROM test1;
CREATE TABLE test2
(
    time DateTime,
    value String
)
ENGINE = MergeTree
ORDER BY (time) AS SELECT 0, '';
SELECT any(value) OVER (ORDER BY time ASC) FROM test2;
SELECT last_value(value) OVER (ORDER BY time ASC) FROM test2;
