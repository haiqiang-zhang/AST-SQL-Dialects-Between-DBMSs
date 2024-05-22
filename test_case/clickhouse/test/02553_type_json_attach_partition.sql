SET allow_experimental_object_type = 1;
DROP TABLE IF EXISTS t_json_attach_partition;
CREATE TABLE t_json_attach_partition(b UInt64, c JSON) ENGINE = MergeTree ORDER BY tuple();
ALTER TABLE t_json_attach_partition DETACH PARTITION tuple();
ALTER TABLE t_json_attach_partition ATTACH PARTITION tuple();
DROP TABLE t_json_attach_partition;
