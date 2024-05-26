DROP TABLE IF EXISTS t_materialize_column;
CREATE TABLE t_materialize_column (i Int32)
ENGINE = MergeTree ORDER BY i PARTITION BY i
SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO t_materialize_column VALUES (1);
ALTER TABLE t_materialize_column ADD COLUMN s LowCardinality(String) DEFAULT toString(i);
ALTER TABLE t_materialize_column MATERIALIZE COLUMN s SETTINGS mutations_sync = 2;
