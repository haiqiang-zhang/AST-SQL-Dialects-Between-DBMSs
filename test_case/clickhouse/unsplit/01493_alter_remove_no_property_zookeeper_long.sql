DROP TABLE IF EXISTS no_prop_table;
CREATE TABLE no_prop_table
(
    some_column UInt64
)
ENGINE MergeTree()
ORDER BY tuple();
SHOW CREATE TABLE no_prop_table;
SHOW CREATE TABLE no_prop_table;
DROP TABLE IF EXISTS no_prop_table;
DROP TABLE IF EXISTS r_no_prop_table;
DROP TABLE IF EXISTS r_no_prop_table;
