--- Verify that ReplacingMergeTree properly handles _is_deleted:
--- SELECT FINAL should take `_is_deleted` into consideration when there is only one partition.
-- { echoOn }

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
SELECT count() FROM t FINAL;
-- Previously, `do_not_merge_across_partitions_select_final = 1` showed more rows, 
-- as if no rows were deleted.
SELECT count() FROM t FINAL SETTINGS do_not_merge_across_partitions_select_final = 1;
SELECT count() FROM t FINAL SETTINGS do_not_merge_across_partitions_select_final = 0;
DROP TABLE t;
