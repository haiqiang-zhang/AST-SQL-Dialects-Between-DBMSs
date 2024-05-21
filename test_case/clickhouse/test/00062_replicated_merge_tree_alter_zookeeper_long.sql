-- Tag no-replicated-database: Old syntax is not allowed

DROP TABLE IF EXISTS replicated_alter1;
DROP TABLE IF EXISTS replicated_alter2;
SET replication_alter_partitions_sync = 2;
set allow_deprecated_syntax_for_merge_tree=1;
