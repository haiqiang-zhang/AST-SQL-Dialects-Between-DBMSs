drop table if exists t_table_select;
CREATE TABLE t_table_select (id UInt32) ENGINE = MergeTree ORDER BY id;
INSERT INTO t_table_select (id) SELECT number FROM numbers(30);
