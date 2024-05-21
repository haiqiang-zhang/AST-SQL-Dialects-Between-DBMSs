-- we need exact block-numbers
SET insert_keeper_fault_injection_probability=0;
DROP TABLE IF EXISTS table_with_some_columns;
CREATE TABLE table_with_some_columns(
    key UInt64,
    value0 UInt8
)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/table_with_some_columns', '1')
ORDER BY key
SETTINGS allow_experimental_block_number_column=1,
ratio_of_defaults_for_sparse_serialization=0.0001,
min_bytes_for_wide_part = 0,
replace_long_file_name_to_hash=0;
OPTIMIZE TABLE table_with_some_columns FINAL;
OPTIMIZE TABLE table_with_some_columns FINAL;
set alter_sync = 2;
ALTER TABLE table_with_some_columns DROP COLUMN value0;
OPTIMIZE TABLE table_with_some_columns FINAL;
DROP TABLE IF EXISTS table_with_some_columns;