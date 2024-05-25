-- we need exact block-numbers
SET insert_keeper_fault_injection_probability=0;
DROP TABLE IF EXISTS table_with_some_columns;
set alter_sync = 2;
DROP TABLE IF EXISTS table_with_some_columns;
