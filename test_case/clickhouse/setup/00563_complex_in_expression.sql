DROP TABLE IF EXISTS test_00563;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE test_00563 ( dt Date, site_id Int32, site_key String ) ENGINE = MergeTree(dt, (site_id, site_key, dt), 8192);
INSERT INTO test_00563 (dt,site_id, site_key) VALUES ('2018-1-29', 100, 'key');
