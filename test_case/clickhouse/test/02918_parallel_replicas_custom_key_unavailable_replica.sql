DROP TABLE IF EXISTS 02918_parallel_replicas;
CREATE TABLE 02918_parallel_replicas (x String, y Int32) ENGINE = MergeTree ORDER BY cityHash64(x);
INSERT INTO 02918_parallel_replicas SELECT toString(number), number % 4 FROM numbers(1000);
SET prefer_localhost_replica=0;
SET use_hedged_requests=0;
DROP TABLE 02918_parallel_replicas;
