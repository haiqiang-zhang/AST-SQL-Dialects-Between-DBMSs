CREATE MATERIALIZED VIEW `01851_merge_tree_mv`
ENGINE = Memory AS
SELECT
    n2,
    n3
FROM `01851_merge_tree`;
-- ok
ALTER TABLE `01851_merge_tree`
    DROP COLUMN n4;
ALTER TABLE `01851_merge_tree`
    CLEAR COLUMN n2;
DROP TABLE `01851_merge_tree`;
DROP TABLE `01851_merge_tree_mv`;
