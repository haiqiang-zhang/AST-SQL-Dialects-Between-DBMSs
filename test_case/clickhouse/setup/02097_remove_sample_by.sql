DROP TABLE IF EXISTS t_remove_sample_by;
CREATE TABLE t_remove_sample_by(id UInt64) ENGINE = MergeTree ORDER BY id SAMPLE BY id;
ALTER TABLE t_remove_sample_by REMOVE SAMPLE BY;