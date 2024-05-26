SYSTEM STOP MERGES join_on_disk;
CREATE TABLE join_on_disk (id Int) Engine=MergeTree() ORDER BY id;
INSERT INTO join_on_disk SELECT number as id FROM numbers_mt(50000);
INSERT INTO join_on_disk SELECT number as id FROM numbers_mt(1000);
DROP TABLE join_on_disk;
