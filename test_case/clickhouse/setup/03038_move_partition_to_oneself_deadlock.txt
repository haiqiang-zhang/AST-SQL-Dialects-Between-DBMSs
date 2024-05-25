DROP TABLE IF EXISTS move_partition_to_oneself;
CREATE TABLE move_partition_to_oneself (key UInt64 CODEC(NONE)) ENGINE = MergeTree ORDER BY tuple();
INSERT INTO move_partition_to_oneself SELECT number FROM numbers(1e6);
