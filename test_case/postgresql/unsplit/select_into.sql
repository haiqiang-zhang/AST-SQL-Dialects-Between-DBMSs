CREATE SCHEMA selinto_schema;
GRANT ALL ON SCHEMA selinto_schema TO public;
CREATE TABLE selinto_schema.tbl_withdata1 (a)
  AS SELECT generate_series(1,3) WITH DATA;
INSERT INTO selinto_schema.tbl_withdata1 VALUES (4);
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE selinto_schema.tbl_withdata2 (a) AS
  SELECT generate_series(1,3) WITH DATA;
CREATE TABLE selinto_schema.tbl_nodata1 (a) AS
  SELECT generate_series(1,3) WITH NO DATA;
PREPARE data_sel AS SELECT generate_series(1,3);
CREATE TABLE selinto_schema.tbl_withdata3 (a) AS
  EXECUTE data_sel WITH DATA;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE selinto_schema.tbl_withdata4 (a) AS
  EXECUTE data_sel WITH DATA;
CREATE TABLE selinto_schema.tbl_nodata3 (a) AS
  EXECUTE data_sel WITH NO DATA;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE selinto_schema.tbl_nodata4 (a) AS
  EXECUTE data_sel WITH NO DATA;
RESET SESSION AUTHORIZATION;
RESET SESSION AUTHORIZATION;
DEALLOCATE data_sel;
DROP SCHEMA selinto_schema CASCADE;
CREATE TABLE ctas_base (i int, j int);
INSERT INTO ctas_base VALUES (1, 2);
CREATE TABLE ctas_nodata (ii, jj) AS SELECT i, j FROM ctas_base;
CREATE TABLE ctas_nodata_2 (ii, jj) AS SELECT i, j FROM ctas_base WITH NO DATA;
CREATE TABLE ctas_nodata_3 (ii) AS SELECT i, j FROM ctas_base;
CREATE TABLE ctas_nodata_4 (ii) AS SELECT i, j FROM ctas_base WITH NO DATA;
SELECT * FROM ctas_nodata;
SELECT * FROM ctas_nodata_2;
SELECT * FROM ctas_nodata_3;
SELECT * FROM ctas_nodata_4;
DROP TABLE ctas_base;
DROP TABLE ctas_nodata;
DROP TABLE ctas_nodata_2;
DROP TABLE ctas_nodata_3;
DROP TABLE ctas_nodata_4;
CREATE TABLE ctas_ine_tbl AS SELECT 1;
CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS SELECT 1 / 0;
CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS SELECT 1 / 0 WITH NO DATA;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS SELECT 1 / 0;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS SELECT 1 / 0 WITH NO DATA;
PREPARE ctas_ine_query AS SELECT 1 / 0;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE TABLE IF NOT EXISTS ctas_ine_tbl AS EXECUTE ctas_ine_query;
DROP TABLE ctas_ine_tbl;
