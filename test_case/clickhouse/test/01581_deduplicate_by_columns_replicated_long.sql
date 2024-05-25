--- See also tests/queries/0_stateless/01581_deduplicate_by_columns_local.sql

--- replicated case

-- Just in case if previous tests run left some stuff behind.
DROP TABLE IF EXISTS replicated_deduplicate_by_columns_r1 SYNC;
DROP TABLE IF EXISTS replicated_deduplicate_by_columns_r2 SYNC;
SET replication_alter_partitions_sync = 2;
SELECT 'check that we have a data';
SELECT 'after old OPTIMIZE DEDUPLICATE';
SELECT 'check data again after multiple deduplications with new syntax';
