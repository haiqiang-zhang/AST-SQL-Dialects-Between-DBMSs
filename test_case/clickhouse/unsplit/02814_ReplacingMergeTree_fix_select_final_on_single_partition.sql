DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    `account_id` UInt64,
    `_is_deleted` UInt8,
    `_version` UInt64
)
ENGINE = ReplacingMergeTree(_version, _is_deleted)
ORDER BY (account_id);
INSERT INTO t SELECT number, 0, 1 FROM numbers(1e3);
INSERT INTO t SELECT number, 1, 1 FROM numbers(1e2);
OPTIMIZE TABLE t FINAL;
SELECT count() FROM t;
DROP TABLE t;
