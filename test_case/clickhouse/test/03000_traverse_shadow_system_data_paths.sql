DROP TABLE IF EXISTS 03000_traverse_shadow_system_data_path_table;
CREATE TABLE 03000_traverse_shadow_system_data_path_table (
    id Int64,
    data String
) ENGINE=MergeTree()
ORDER BY id
SETTINGS storage_policy='s3_cache';
INSERT INTO 03000_traverse_shadow_system_data_path_table VALUES (0, 'data');
ALTER TABLE 03000_traverse_shadow_system_data_path_table FREEZE WITH NAME '03000_traverse_shadow_system_data_path_table_backup';
DROP TABLE IF EXISTS 03000_traverse_shadow_system_data_path_table;