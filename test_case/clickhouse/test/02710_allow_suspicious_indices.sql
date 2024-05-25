ALTER TABLE tbl ADD COLUMN `id2` UInt32, MODIFY ORDER BY (id1, id2, id2) SETTINGS allow_suspicious_indices = 1;
DROP TABLE IF EXISTS tbl;
CREATE TABLE tbl (id UInt32) ENGINE = MergeTree() ORDER BY id;
ALTER TABLE tbl ADD INDEX idx (id+1, id, id+1) TYPE minmax SETTINGS allow_suspicious_indices = 1;
