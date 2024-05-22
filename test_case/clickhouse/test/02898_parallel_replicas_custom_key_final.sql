DROP TABLE IF EXISTS 02898_parallel_replicas_final;
CREATE TABLE 02898_parallel_replicas_final (x String, y Int32) ENGINE = ReplacingMergeTree ORDER BY cityHash64(x);
INSERT INTO 02898_parallel_replicas_final SELECT toString(number), number % 3 FROM numbers(1000);
DROP TABLE 02898_parallel_replicas_final;
