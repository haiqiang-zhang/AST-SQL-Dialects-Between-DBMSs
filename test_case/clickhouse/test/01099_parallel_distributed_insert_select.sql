-- set distributed_foreground_insert = 1;
SET allow_experimental_parallel_reading_from_replicas = 0;
SET prefer_localhost_replica = 1;
DROP TABLE IF EXISTS local_01099_a;
DROP TABLE IF EXISTS local_01099_b;
DROP TABLE IF EXISTS distributed_01099_a;
DROP TABLE IF EXISTS distributed_01099_b;
SET parallel_distributed_insert_select=1;
SELECT 'parallel_distributed_insert_select=1';
-- test_shard_localhost
--

SELECT 'test_shard_localhost';
CREATE TABLE local_01099_a (number UInt64) ENGINE = Log;
CREATE TABLE local_01099_b (number UInt64) ENGINE = Log;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SELECT * FROM distributed_01099_b;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
-- test_cluster_two_shards_localhost
--

SELECT 'test_cluster_two_shards_localhost';
CREATE TABLE local_01099_a (number UInt64) ENGINE = Log;
CREATE TABLE local_01099_b (number UInt64) ENGINE = Log;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
-- test_cluster_two_shards
--

SELECT 'test_cluster_two_shards';
CREATE TABLE local_01099_a (number UInt64) ENGINE = Log;
CREATE TABLE local_01099_b (number UInt64) ENGINE = Log;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SET prefer_localhost_replica=1;
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SYSTEM FLUSH DISTRIBUTED distributed_01099_b;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
SELECT 'test_cluster_1_shard_3_replicas_1_unavailable';
CREATE TABLE local_01099_a (number UInt64) ENGINE = MergeTree() ORDER BY number;
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SET prefer_localhost_replica=1;
-- (since parallel_distributed_insert_select=2)
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
SET send_logs_level='fatal';
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
SET send_logs_level='warning';
SELECT 'test_cluster_1_shard_3_replicas_1_unavailable with storageCluster';
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
SET send_logs_level='error';
SET send_logs_level='warning';
SET prefer_localhost_replica=1;
-- (since parallel_distributed_insert_select=2)
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_b;
SET send_logs_level='fatal';
DROP TABLE distributed_01099_b;
SET send_logs_level='warning';
SET parallel_distributed_insert_select=2;
SELECT 'parallel_distributed_insert_select=2';
-- test_shard_localhost
--

SELECT 'test_shard_localhost';
CREATE TABLE local_01099_a (number UInt64) ENGINE = Log;
CREATE TABLE local_01099_b (number UInt64) ENGINE = Log;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SELECT * FROM distributed_01099_b;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
-- test_cluster_two_shards_localhost
--

SELECT 'test_cluster_two_shards_localhost';
--     DB::Exception: std::system_error: Resource deadlock avoided.
-- So use MergeTree instead.
CREATE TABLE local_01099_a (number UInt64) ENGINE = MergeTree() ORDER BY number;
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
-- test_cluster_two_shards
--

SELECT 'test_cluster_two_shards';
CREATE TABLE local_01099_a (number UInt64) ENGINE = MergeTree() ORDER BY number;
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SET prefer_localhost_replica=1;
-- (since parallel_distributed_insert_select=2)
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
SELECT 'test_cluster_1_shard_3_replicas_1_unavailable';
CREATE TABLE local_01099_a (number UInt64) ENGINE = MergeTree() ORDER BY number;
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
INSERT INTO local_01099_a SELECT number from system.numbers limit 3;
INSERT INTO distributed_01099_b SELECT * from distributed_01099_a;
SET prefer_localhost_replica=1;
-- (since parallel_distributed_insert_select=2)
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_a;
DROP TABLE local_01099_b;
DROP TABLE distributed_01099_a;
DROP TABLE distributed_01099_b;
SELECT 'test_cluster_1_shard_3_replicas_1_unavailable with storageCluster';
CREATE TABLE local_01099_b (number UInt64) ENGINE = MergeTree() ORDER BY number;
SYSTEM STOP DISTRIBUTED SENDS distributed_01099_b;
SET prefer_localhost_replica=0;
SET send_logs_level='error';
SET send_logs_level='warning';
SET prefer_localhost_replica=1;
-- (since parallel_distributed_insert_select=2)
SELECT 'distributed';
SELECT number, count(number) FROM distributed_01099_b group by number order by number;
SELECT 'local';
SELECT number, count(number) FROM local_01099_b group by number order by number;
DROP TABLE local_01099_b;
SET send_logs_level='fatal';
DROP TABLE distributed_01099_b;
SET send_logs_level='warning';