SET enable_hashjoin TO off;
SET enable_bitmapscan TO off;
SET enable_mergejoin TO off;
CREATE TABLE expr_key (x numeric, t text);
INSERT INTO expr_key (x, t)
SELECT d1::numeric, d1::text FROM (
    SELECT round((d / pi())::numeric, 7) AS d1 FROM generate_series(1, 20) AS d
) t;
INSERT INTO expr_key SELECT * FROM expr_key;
CREATE INDEX expr_key_idx_x_t ON expr_key (x, t);
