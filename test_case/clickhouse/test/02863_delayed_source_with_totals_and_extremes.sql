-- Tag no-parallel: failpoint is used which can force DelayedSource on other tests

DROP TABLE IF EXISTS 02863_delayed_source;
CREATE TABLE 02863_delayed_source(a Int64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02863_delayed_source/{replica}', 'r1') ORDER BY a;
INSERT INTO 02863_delayed_source VALUES (1), (2);
DROP TABLE 02863_delayed_source;