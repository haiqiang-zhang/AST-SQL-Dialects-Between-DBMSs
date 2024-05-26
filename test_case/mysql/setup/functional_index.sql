CREATE TABLE t1 (int_col INTEGER, string_col VARCHAR(255));
INSERT INTO t1 (int_col, string_col) VALUES (-1, "foo"), (1, "bar");
CREATE INDEX int_func_index ON t1 ((ABS(int_col)));
CREATE INDEX string_func_index ON t1 ((SUBSTRING(string_col, 1, 2)));
