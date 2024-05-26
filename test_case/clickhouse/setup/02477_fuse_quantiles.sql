SET allow_experimental_analyzer = 1;
SET optimize_syntax_fuse_functions = 1;
DROP TABLE IF EXISTS fuse_tbl;
CREATE TABLE fuse_tbl(a Nullable(Int32), b Int32) Engine = Log;
INSERT INTO fuse_tbl SELECT number, number + 1 FROM numbers(1000);
