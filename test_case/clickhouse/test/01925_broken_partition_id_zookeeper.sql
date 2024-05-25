set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE old_partition_key (sd Date, dh UInt64, ak UInt32, ed Date) ENGINE=MergeTree(sd, dh, (ak, ed, dh), 8192);
ALTER TABLE old_partition_key DROP PARTITION ID '202103';
DROP TABLE old_partition_key;
