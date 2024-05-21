DROP TABLE IF EXISTS x;
DROP TABLE IF EXISTS y;
CREATE TABLE x AS system.numbers ENGINE = MergeTree ORDER BY number;
CREATE TABLE y AS system.numbers ENGINE = MergeTree ORDER BY number;
INSERT INTO FUNCTION cluster('test_shard_localhost', currentDatabase(), x) SELECT * FROM numbers(10);
INSERT INTO FUNCTION cluster('test_cluster_two_shards_localhost', currentDatabase(), x) SELECT * FROM numbers(10);
SELECT * FROM x ORDER BY number;
DROP TABLE x;
DROP TABLE y;