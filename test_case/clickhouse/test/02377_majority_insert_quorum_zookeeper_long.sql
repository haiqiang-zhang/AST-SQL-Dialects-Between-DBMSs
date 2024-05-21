-- no-replicated-database:
--   The number of replicas is doubled, so `SYSTEM STOP FETCHES` stop not enough replicas.

SET insert_quorum_parallel = false;
SET select_sequential_consistency = 1;
DROP TABLE IF EXISTS quorum1;
DROP TABLE IF EXISTS quorum2;
DROP TABLE IF EXISTS quorum3;
CREATE TABLE quorum1(x UInt32, y Date) ENGINE ReplicatedMergeTree('/clickhouse/tables/{database}/test_02377/quorum', '1') ORDER BY x PARTITION BY y;
CREATE TABLE quorum2(x UInt32, y Date) ENGINE ReplicatedMergeTree('/clickhouse/tables/{database}/test_02377/quorum', '2') ORDER BY x PARTITION BY y;
SET insert_quorum = 'auto';
SET insert_keeper_fault_injection_probability=0;
INSERT INTO quorum1 VALUES (1, '2018-11-15');
INSERT INTO quorum1 VALUES (2, '2018-11-15');
INSERT INTO quorum1 VALUES (3, '2018-12-16');
SELECT x FROM quorum1 ORDER BY x;
SELECT x FROM quorum2 ORDER BY x;
DROP TABLE quorum1;
DROP TABLE quorum2;
CREATE TABLE quorum1(x UInt32, y Date) ENGINE ReplicatedMergeTree('/clickhouse/tables/{database}/test_02377/quorum1', '1') ORDER BY x PARTITION BY y;
CREATE TABLE quorum2(x UInt32, y Date) ENGINE ReplicatedMergeTree('/clickhouse/tables/{database}/test_02377/quorum1', '2') ORDER BY x PARTITION BY y;
CREATE TABLE quorum3(x UInt32, y Date) ENGINE ReplicatedMergeTree('/clickhouse/tables/{database}/test_02377/quorum1', '3') ORDER BY x PARTITION BY y;
-- stop replica 3
SYSTEM STOP FETCHES quorum3;
INSERT INTO quorum1 VALUES (1, '2018-11-15');
SELECT x FROM quorum1 ORDER BY x;
SELECT x FROM quorum2 ORDER BY x;
SELECT x FROM quorum3 ORDER BY x;
-- Sync replica 3
SYSTEM START FETCHES quorum3;
SYSTEM SYNC REPLICA quorum3;
SELECT x FROM quorum3 ORDER BY x;
SYSTEM STOP FETCHES quorum2;
SYSTEM STOP FETCHES quorum3;
SET insert_quorum_timeout = 5000;
INSERT INTO quorum1 VALUES (2, '2018-11-15');
SELECT x FROM quorum1 ORDER BY x;
SELECT x FROM quorum2 ORDER BY x;
SELECT x FROM quorum3 ORDER BY x;
SYSTEM START FETCHES quorum2;
SYSTEM SYNC REPLICA quorum2;
SYSTEM START FETCHES quorum3;
SYSTEM SYNC REPLICA quorum3;
SET insert_quorum_timeout = 600000;
INSERT INTO quorum1 VALUES (3, '2018-11-15');
SELECT x FROM quorum1 ORDER BY x;
SYSTEM SYNC REPLICA quorum2;
SYSTEM SYNC REPLICA quorum3;
SELECT x FROM quorum2 ORDER BY x;
SELECT x FROM quorum3 ORDER BY x;
DROP TABLE quorum1;
DROP TABLE quorum2;
DROP TABLE quorum3;