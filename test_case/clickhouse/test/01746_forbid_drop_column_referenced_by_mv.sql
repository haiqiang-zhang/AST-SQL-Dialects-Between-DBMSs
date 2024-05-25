DROP TABLE IF EXISTS `01746_merge_tree`;
CREATE TABLE `01746_merge_tree`
(
    `n1` Int8,
    `n2` Int8,
    `n3` Int8,
    `n4` Int8
)
ENGINE = MergeTree
ORDER BY n1;
DROP TABLE IF EXISTS `01746_merge_tree_mv`;
CREATE MATERIALIZED VIEW `01746_merge_tree_mv`
ENGINE = Memory AS
SELECT
    n2,
    n3
FROM `01746_merge_tree`;
-- ok
ALTER TABLE `01746_merge_tree`
    DROP COLUMN n4;
DROP TABLE `01746_merge_tree`;
DROP TABLE `01746_merge_tree_mv`;
DROP TABLE IF EXISTS `01746_null`;
CREATE TABLE `01746_null`
(
    `n1` Int8,
    `n2` Int8,
    `n3` Int8
)
ENGINE = Null;
DROP TABLE IF EXISTS `01746_null_mv`;
CREATE MATERIALIZED VIEW `01746_null_mv`
ENGINE = Memory AS
SELECT
    n1,
    n2
FROM `01746_null`;
-- ok
ALTER TABLE `01746_null`
    DROP COLUMN n3;
DROP TABLE `01746_null`;
DROP TABLE `01746_null_mv`;
DROP TABLE IF EXISTS `01746_local`;
CREATE TABLE `01746_local`
(
    `n1` Int8,
    `n2` Int8,
    `n3` Int8
)
ENGINE = Memory;
DROP TABLE IF EXISTS `01746_dist`;
DROP TABLE IF EXISTS `01746_dist_mv`;
DROP TABLE `01746_local`;
DROP TABLE IF EXISTS `01746_merge_t`;
CREATE TABLE `01746_merge_t`
(
    `n1` Int8,
    `n2` Int8,
    `n3` Int8
)
ENGINE = Memory;
DROP TABLE IF EXISTS `01746_merge`;
CREATE TABLE `01746_merge` AS `01746_merge_t`
ENGINE = Merge(currentDatabase(), '01746_merge_t');
DROP TABLE IF EXISTS `01746_merge_mv`;
CREATE MATERIALIZED VIEW `01746_merge_mv`
ENGINE = Memory AS
SELECT
    n1,
    n2
FROM `01746_merge`;
-- ok
ALTER TABLE `01746_merge`
    DROP COLUMN n3;
DROP TABLE `01746_merge_t`;
DROP TABLE `01746_merge`;
DROP TABLE `01746_merge_mv`;
DROP TABLE IF EXISTS `01746_buffer_t`;
CREATE TABLE `01746_buffer_t`
(
    `n1` Int8,
    `n2` Int8,
    `n3` Int8
)
ENGINE = Memory;
DROP TABLE IF EXISTS `01746_buffer`;
CREATE TABLE `01746_buffer` AS `01746_buffer_t`
ENGINE = Buffer(currentDatabase(), `01746_buffer_t`, 16, 10, 100, 10000, 1000000, 10000000, 100000000);
DROP TABLE IF EXISTS `01746_buffer_mv`;
CREATE MATERIALIZED VIEW `01746_buffer_mv`
ENGINE = Memory AS
SELECT
    n1,
    n2
FROM `01746_buffer`;
-- ok
ALTER TABLE `01746_buffer`
    DROP COLUMN n3;
DROP TABLE `01746_buffer_t`;
DROP TABLE `01746_buffer`;
DROP TABLE `01746_buffer_mv`;
