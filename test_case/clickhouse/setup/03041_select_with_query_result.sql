SET allow_experimental_analyzer=1;
DROP TABLE IF EXISTS parent;
DROP TABLE IF EXISTS join_table_1;
DROP TABLE IF EXISTS join_table_2;
CREATE TABLE parent(
    a_id Int64,
    b_id Int64,
    c_id Int64,
    created_at Int64
)
ENGINE=MergeTree()
ORDER BY (a_id, b_id, c_id, created_at);
CREATE TABLE join_table_1(
    a_id Int64,
    b_id Int64
)
ENGINE=MergeTree()
ORDER BY (a_id, b_id);
CREATE TABLE join_table_2(
    c_id Int64,
    created_at Int64
)
ENGINE=MergeTree()
ORDER BY (c_id, created_at);
