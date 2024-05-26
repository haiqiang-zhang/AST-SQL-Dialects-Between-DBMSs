CREATE TABLE tbl_include_reg (c1 int, c2 int, c3 int, c4 box);
INSERT INTO tbl_include_reg SELECT x, 2*x, 3*x, box('4,4,4,4') FROM generate_series(1,10) AS x;
CREATE INDEX tbl_include_reg_idx ON tbl_include_reg (c1, c2) INCLUDE (c3, c4);
CREATE INDEX ON tbl_include_reg (c1, c2) INCLUDE (c1, c3);
