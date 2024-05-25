-- Tag no-replicated-database: Old syntax is not allowed
-- no-shared-merge-tree: implemented replacement

SET replication_alter_partitions_sync = 2;
DROP TABLE IF EXISTS attach_r1;
DROP TABLE IF EXISTS attach_r2;
set allow_deprecated_syntax_for_merge_tree=1;
