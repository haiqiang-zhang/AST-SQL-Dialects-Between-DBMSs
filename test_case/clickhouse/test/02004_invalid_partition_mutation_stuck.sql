SET mutations_sync=2;
DROP TABLE IF EXISTS rep_data;
DROP TABLE IF EXISTS data;
CREATE TABLE data
(
    p Int,
    t DateTime,
    INDEX idx t TYPE minmax GRANULARITY 1
)
ENGINE = MergeTree
PARTITION BY p
ORDER BY t
SETTINGS number_of_free_entries_in_pool_to_execute_mutation=0;
INSERT INTO data VALUES (1, now());
ALTER TABLE data MATERIALIZE INDEX idx IN PARTITION ID '1';
ALTER TABLE data MATERIALIZE INDEX idx IN PARTITION ID '2';
