SET extra_float_digits = 0;
CREATE TEMP TABLE point_gist_tbl(f1 point);
INSERT INTO point_gist_tbl SELECT '(0,0)' FROM generate_series(0,1000);
CREATE INDEX point_gist_tbl_index ON point_gist_tbl USING gist (f1);
INSERT INTO point_gist_tbl VALUES ('(0.0000009,0.0000009)');
SET enable_seqscan TO true;
SET enable_indexscan TO false;
SET enable_bitmapscan TO false;
