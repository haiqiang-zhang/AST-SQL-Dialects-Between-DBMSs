SELECT * FROM mvtest_tv ORDER BY type;
EXPLAIN (costs off)
  CREATE MATERIALIZED VIEW mvtest_tm AS SELECT type, sum(amt) AS totamt FROM mvtest_t GROUP BY type WITH NO DATA;
CREATE MATERIALIZED VIEW mvtest_tm AS SELECT type, sum(amt) AS totamt FROM mvtest_t GROUP BY type WITH NO DATA;
SELECT relispopulated FROM pg_class WHERE oid = 'mvtest_tm'::regclass;
REFRESH MATERIALIZED VIEW mvtest_tm;
SELECT relispopulated FROM pg_class WHERE oid = 'mvtest_tm'::regclass;
CREATE UNIQUE INDEX mvtest_tm_type ON mvtest_tm (type);
SELECT * FROM mvtest_tm ORDER BY type;
EXPLAIN (costs off)
  CREATE MATERIALIZED VIEW mvtest_tvm AS SELECT * FROM mvtest_tv ORDER BY type;
CREATE MATERIALIZED VIEW mvtest_tvm AS SELECT * FROM mvtest_tv ORDER BY type;
SELECT * FROM mvtest_tvm;
CREATE MATERIALIZED VIEW mvtest_tmm AS SELECT sum(totamt) AS grandtot FROM mvtest_tm;
CREATE MATERIALIZED VIEW mvtest_tvmm AS SELECT sum(totamt) AS grandtot FROM mvtest_tvm;
CREATE UNIQUE INDEX mvtest_tvmm_expr ON mvtest_tvmm ((grandtot > 0));
CREATE UNIQUE INDEX mvtest_tvmm_pred ON mvtest_tvmm (grandtot) WHERE grandtot < 0;
CREATE VIEW mvtest_tvv AS SELECT sum(totamt) AS grandtot FROM mvtest_tv;
EXPLAIN (costs off)
  CREATE MATERIALIZED VIEW mvtest_tvvm AS SELECT * FROM mvtest_tvv;
CREATE MATERIALIZED VIEW mvtest_tvvm AS SELECT * FROM mvtest_tvv;
CREATE VIEW mvtest_tvvmv AS SELECT * FROM mvtest_tvvm;
CREATE MATERIALIZED VIEW mvtest_bb AS SELECT * FROM mvtest_tvvmv;
CREATE INDEX mvtest_aa ON mvtest_bb (grandtot);
CREATE SCHEMA mvtest_mvschema;
ALTER MATERIALIZED VIEW mvtest_tvm SET SCHEMA mvtest_mvschema;
SET search_path = mvtest_mvschema, public;
INSERT INTO mvtest_t VALUES (6, 'z', 13);
SELECT * FROM mvtest_tm ORDER BY type;
SELECT * FROM mvtest_tvm ORDER BY type;
REFRESH MATERIALIZED VIEW CONCURRENTLY mvtest_tm;
REFRESH MATERIALIZED VIEW mvtest_tvm;
SELECT * FROM mvtest_tm ORDER BY type;
SELECT * FROM mvtest_tvm ORDER BY type;
RESET search_path;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tmm;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tvmm;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tvvm;
SELECT * FROM mvtest_tmm;
SELECT * FROM mvtest_tvmm;
SELECT * FROM mvtest_tvvm;
REFRESH MATERIALIZED VIEW mvtest_tmm;
REFRESH MATERIALIZED VIEW mvtest_tvmm;
REFRESH MATERIALIZED VIEW mvtest_tvvm;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tmm;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tvmm;
EXPLAIN (costs off)
  SELECT * FROM mvtest_tvvm;
SELECT * FROM mvtest_tmm;
SELECT * FROM mvtest_tvmm;
SELECT * FROM mvtest_tvvm;
DROP MATERIALIZED VIEW IF EXISTS no_such_mv;
SELECT type, m.totamt AS mtot, v.totamt AS vtot FROM mvtest_tm m LEFT JOIN mvtest_tv v USING (type) ORDER BY type;
BEGIN;
DROP TABLE mvtest_t CASCADE;
ROLLBACK;
CREATE VIEW mvtest_vt1 AS SELECT 1 moo;
CREATE VIEW mvtest_vt2 AS SELECT moo, 2*moo FROM mvtest_vt1 UNION ALL SELECT moo, 3*moo FROM mvtest_vt1;
CREATE MATERIALIZED VIEW mv_test2 AS SELECT moo, 2*moo FROM mvtest_vt2 UNION ALL SELECT moo, 3*moo FROM mvtest_vt2;
CREATE MATERIALIZED VIEW mv_test3 AS SELECT * FROM mv_test2 WHERE moo = 12345;
SELECT relispopulated FROM pg_class WHERE oid = 'mv_test3'::regclass;
DROP VIEW mvtest_vt1 CASCADE;
CREATE TABLE mvtest_foo(a, b) AS VALUES(1, 10);
CREATE MATERIALIZED VIEW mvtest_mv AS SELECT * FROM mvtest_foo;
CREATE UNIQUE INDEX ON mvtest_mv(a);
INSERT INTO mvtest_foo SELECT * FROM mvtest_foo;
DROP TABLE mvtest_foo CASCADE;
CREATE TABLE mvtest_foo(a, b, c) AS VALUES(1, 2, 3);
CREATE MATERIALIZED VIEW mvtest_mv AS SELECT * FROM mvtest_foo;
CREATE UNIQUE INDEX ON mvtest_mv (a);
CREATE UNIQUE INDEX ON mvtest_mv (b);
CREATE UNIQUE INDEX on mvtest_mv (c);
INSERT INTO mvtest_foo VALUES(2, 3, 4);
INSERT INTO mvtest_foo VALUES(3, 4, 5);
REFRESH MATERIALIZED VIEW mvtest_mv;
REFRESH MATERIALIZED VIEW CONCURRENTLY mvtest_mv;
DROP TABLE mvtest_foo CASCADE;
CREATE MATERIALIZED VIEW mvtest_mv1 AS SELECT 1 AS col1 WITH NO DATA;
CREATE MATERIALIZED VIEW mvtest_mv2 AS SELECT * FROM mvtest_mv1
  WHERE col1 = (SELECT LEAST(col1) FROM mvtest_mv1) WITH NO DATA;
DROP MATERIALIZED VIEW mvtest_mv1 CASCADE;
CREATE TABLE mvtest_boxes (id serial primary key, b box);
INSERT INTO mvtest_boxes (b) VALUES
  ('(32,32),(31,31)'),
  ('(2.0000004,2.0000004),(1,1)'),
  ('(1.9999996,1.9999996),(1,1)');
CREATE MATERIALIZED VIEW mvtest_boxmv AS SELECT * FROM mvtest_boxes;
CREATE UNIQUE INDEX mvtest_boxmv_id ON mvtest_boxmv (id);
UPDATE mvtest_boxes SET b = '(2,2),(1,1)' WHERE id = 2;
REFRESH MATERIALIZED VIEW CONCURRENTLY mvtest_boxmv;
SELECT * FROM mvtest_boxmv ORDER BY id;
DROP TABLE mvtest_boxes CASCADE;
CREATE TABLE mvtest_v (i int, j int);
CREATE MATERIALIZED VIEW mvtest_mv_v (ii, jj) AS SELECT i, j FROM mvtest_v;
CREATE MATERIALIZED VIEW mvtest_mv_v_2 (ii) AS SELECT i, j FROM mvtest_v;
CREATE MATERIALIZED VIEW mvtest_mv_v_3 (ii, jj) AS SELECT i, j FROM mvtest_v WITH NO DATA;
CREATE MATERIALIZED VIEW mvtest_mv_v_4 (ii) AS SELECT i, j FROM mvtest_v WITH NO DATA;
ALTER TABLE mvtest_v RENAME COLUMN i TO x;
INSERT INTO mvtest_v values (1, 2);
CREATE UNIQUE INDEX mvtest_mv_v_ii ON mvtest_mv_v (ii);
REFRESH MATERIALIZED VIEW mvtest_mv_v;
UPDATE mvtest_v SET j = 3 WHERE x = 1;
REFRESH MATERIALIZED VIEW CONCURRENTLY mvtest_mv_v;
REFRESH MATERIALIZED VIEW mvtest_mv_v_2;
REFRESH MATERIALIZED VIEW mvtest_mv_v_3;
REFRESH MATERIALIZED VIEW mvtest_mv_v_4;
SELECT * FROM mvtest_v;
SELECT * FROM mvtest_mv_v;
SELECT * FROM mvtest_mv_v_2;
SELECT * FROM mvtest_mv_v_3;
SELECT * FROM mvtest_mv_v_4;
DROP TABLE mvtest_v CASCADE;
CREATE MATERIALIZED VIEW mv_unspecified_types AS
  SELECT 42 as i, 42.5 as num, 'foo' as u, 'foo'::unknown as u2, null as n;
SELECT * FROM mv_unspecified_types;
DROP MATERIALIZED VIEW mv_unspecified_types;
create materialized view mvtest_error as select 1/0 as x with no data;
drop materialized view mvtest_error;
CREATE TABLE mvtest_v AS SELECT generate_series(1,10) AS a;
CREATE MATERIALIZED VIEW mvtest_mv_v AS SELECT a FROM mvtest_v WHERE a <= 5;
DELETE FROM mvtest_v WHERE EXISTS ( SELECT * FROM mvtest_mv_v WHERE mvtest_mv_v.a = mvtest_v.a );
SELECT * FROM mvtest_v;
SELECT * FROM mvtest_mv_v;
DROP TABLE mvtest_v CASCADE;
RESET ROLE;
SET search_path = mvtest_mvschema, public;
CREATE OR REPLACE FUNCTION mvtest_drop_the_index()
  RETURNS bool AS $$
BEGIN
  EXECUTE 'DROP INDEX IF EXISTS mvtest_mvschema.mvtest_drop_idx';
  RETURN true;
END;
$$ LANGUAGE plpgsql;
CREATE MATERIALIZED VIEW drop_idx_matview AS
  SELECT 1 as i WHERE mvtest_drop_the_index();
CREATE UNIQUE INDEX mvtest_drop_idx ON drop_idx_matview (i);
DROP MATERIALIZED VIEW drop_idx_matview;
RESET search_path;
BEGIN;
CREATE FUNCTION mvtest_func()
  RETURNS void AS $$
BEGIN
  CREATE MATERIALIZED VIEW mvtest1 AS SELECT 1 AS x;
  CREATE MATERIALIZED VIEW mvtest2 AS SELECT 1 AS x WITH NO DATA;
END;
$$ LANGUAGE plpgsql;
SELECT mvtest_func();
SELECT * FROM mvtest1;
ROLLBACK;
CREATE SCHEMA matview_schema;
GRANT ALL ON SCHEMA matview_schema TO public;
CREATE MATERIALIZED VIEW matview_schema.mv_withdata1 (a) AS
  SELECT generate_series(1, 10) WITH DATA;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE MATERIALIZED VIEW matview_schema.mv_withdata2 (a) AS
  SELECT generate_series(1, 10) WITH DATA;
REFRESH MATERIALIZED VIEW matview_schema.mv_withdata2;
CREATE MATERIALIZED VIEW matview_schema.mv_nodata1 (a) AS
  SELECT generate_series(1, 10) WITH NO DATA;
RESET SESSION AUTHORIZATION;
DROP SCHEMA matview_schema CASCADE;
CREATE MATERIALIZED VIEW matview_ine_tab AS SELECT 1;
CREATE MATERIALIZED VIEW IF NOT EXISTS matview_ine_tab AS
  SELECT 1 / 0;
CREATE MATERIALIZED VIEW IF NOT EXISTS matview_ine_tab AS
  SELECT 1 / 0 WITH NO DATA;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE MATERIALIZED VIEW IF NOT EXISTS matview_ine_tab AS
    SELECT 1 / 0;
EXPLAIN (ANALYZE, COSTS OFF, SUMMARY OFF, TIMING OFF)
  CREATE MATERIALIZED VIEW IF NOT EXISTS matview_ine_tab AS
    SELECT 1 / 0 WITH NO DATA;
DROP MATERIALIZED VIEW matview_ine_tab;
