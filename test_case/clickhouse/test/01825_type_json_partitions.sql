SET allow_experimental_object_type = 1;
CREATE TABLE t_json_partitions (id UInt32, obj JSON)
ENGINE MergeTree ORDER BY id PARTITION BY id;
DROP TABLE t_json_partitions;
