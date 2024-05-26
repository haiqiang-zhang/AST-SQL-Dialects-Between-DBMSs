SELECT * FROM pg_partition_tree(NULL);
SELECT * FROM pg_partition_ancestors(NULL);
SELECT pg_partition_root(NULL);
CREATE TABLE ptif_test (a int, b int) PARTITION BY range (a);
CREATE TABLE ptif_test0 PARTITION OF ptif_test
  FOR VALUES FROM (minvalue) TO (0) PARTITION BY list (b);
CREATE TABLE ptif_test01 PARTITION OF ptif_test0 FOR VALUES IN (1);
CREATE TABLE ptif_test1 PARTITION OF ptif_test
  FOR VALUES FROM (0) TO (100) PARTITION BY list (b);
CREATE TABLE ptif_test11 PARTITION OF ptif_test1 FOR VALUES IN (1);
CREATE TABLE ptif_test2 PARTITION OF ptif_test
  FOR VALUES FROM (100) TO (200);
CREATE TABLE ptif_test3 PARTITION OF ptif_test
  FOR VALUES FROM (200) TO (maxvalue) PARTITION BY list (b);
CREATE INDEX ptif_test_index ON ONLY ptif_test (a);
CREATE INDEX ptif_test0_index ON ONLY ptif_test0 (a);
ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test0_index;
CREATE INDEX ptif_test01_index ON ptif_test01 (a);
ALTER INDEX ptif_test0_index ATTACH PARTITION ptif_test01_index;
CREATE INDEX ptif_test1_index ON ONLY ptif_test1 (a);
ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test1_index;
CREATE INDEX ptif_test11_index ON ptif_test11 (a);
ALTER INDEX ptif_test1_index ATTACH PARTITION ptif_test11_index;
CREATE INDEX ptif_test2_index ON ptif_test2 (a);
ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test2_index;
CREATE INDEX ptif_test3_index ON ptif_test3 (a);
ALTER INDEX ptif_test_index ATTACH PARTITION ptif_test3_index;
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test0') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test01') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test3') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree(pg_partition_root('ptif_test01')) p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test0_index') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test01_index') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree('ptif_test3_index') p
  JOIN pg_class c ON (p.relid = c.oid);
SELECT relid, parentrelid, level, isleaf
  FROM pg_partition_tree(pg_partition_root('ptif_test01_index')) p
  JOIN pg_class c ON (p.relid = c.oid);
DROP TABLE ptif_test;
CREATE TABLE ptif_normal_table(a int);
DROP TABLE ptif_normal_table;
CREATE VIEW ptif_test_view AS SELECT 1;
CREATE MATERIALIZED VIEW ptif_test_matview AS SELECT 1;
CREATE TABLE ptif_li_parent ();
CREATE TABLE ptif_li_child () INHERITS (ptif_li_parent);
DROP VIEW ptif_test_view;
DROP MATERIALIZED VIEW ptif_test_matview;
DROP TABLE ptif_li_parent, ptif_li_child;
