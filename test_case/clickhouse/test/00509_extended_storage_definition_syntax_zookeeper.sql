-- no-shared-merge-tree: boring test, nothing new

SET optimize_on_insert = 0;
SELECT '*** Replicated with sampling ***';
DROP TABLE IF EXISTS replicated_with_sampling;
SELECT '*** Replacing with implicit version ***';
DROP TABLE IF EXISTS replacing;
CREATE TABLE replacing(d Date, x UInt32, s String) ENGINE = ReplacingMergeTree ORDER BY x PARTITION BY d;
INSERT INTO replacing VALUES ('2017-10-23', 1, 'a');
INSERT INTO replacing VALUES ('2017-10-23', 1, 'b');
INSERT INTO replacing VALUES ('2017-10-23', 1, 'c');
OPTIMIZE TABLE replacing PARTITION '2017-10-23' FINAL;
SELECT * FROM replacing;
DROP TABLE replacing;
SELECT '*** Replicated Collapsing ***';
DROP TABLE IF EXISTS replicated_collapsing;
SELECT '*** Replicated VersionedCollapsing ***';
DROP TABLE IF EXISTS replicated_versioned_collapsing;
SELECT '*** Table definition with SETTINGS ***';
DROP TABLE IF EXISTS with_settings;
SELECT is_leader FROM system.replicas WHERE database = currentDatabase() AND table = 'with_settings';