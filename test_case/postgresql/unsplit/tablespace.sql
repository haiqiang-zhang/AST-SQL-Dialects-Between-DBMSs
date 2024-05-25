SELECT spcoptions FROM pg_tablespace WHERE spcname = 'regress_tblspacewith';
SELECT regexp_replace(pg_tablespace_location(oid), '(pg_tblspc)/(\d+)', '\1/NNN')
  FROM pg_tablespace  WHERE spcname = 'regress_tblspace';
CREATE TABLE regress_tblspace_test_tbl (num1 bigint, num2 double precision, t text);
INSERT INTO regress_tblspace_test_tbl (num1, num2, t)
  SELECT round(random()*100), random(), 'text'
  FROM generate_series(1, 10) s(i);
CREATE INDEX regress_tblspace_test_tbl_idx ON regress_tblspace_test_tbl (num1);
BEGIN;
ROLLBACK;
SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace';
SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'
  ORDER BY c.relname;
ALTER TABLE regress_tblspace_test_tbl SET TABLESPACE pg_default;
SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'
  ORDER BY c.relname;
ALTER INDEX regress_tblspace_test_tbl_idx SET TABLESPACE pg_default;
SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'
  ORDER BY c.relname;
SELECT c.relname FROM pg_class c, pg_tablespace s
  WHERE c.reltablespace = s.oid AND s.spcname = 'regress_tblspace'
  ORDER BY c.relname;
DROP TABLE regress_tblspace_test_tbl;
CREATE TABLE tbspace_reindex_part (c1 int, c2 int) PARTITION BY RANGE (c1);
CREATE TABLE tbspace_reindex_part_0 PARTITION OF tbspace_reindex_part
  FOR VALUES FROM (0) TO (10) PARTITION BY list (c2);
CREATE TABLE tbspace_reindex_part_0_1 PARTITION OF tbspace_reindex_part_0
  FOR VALUES IN (1);
CREATE TABLE tbspace_reindex_part_0_2 PARTITION OF tbspace_reindex_part_0
  FOR VALUES IN (2);
CREATE TABLE tbspace_reindex_part_10 PARTITION OF tbspace_reindex_part
   FOR VALUES FROM (10) TO (20) PARTITION BY list (c2);
CREATE INDEX tbspace_reindex_part_index ON ONLY tbspace_reindex_part (c1);
CREATE INDEX tbspace_reindex_part_index_0 ON ONLY tbspace_reindex_part_0 (c1);
ALTER INDEX tbspace_reindex_part_index ATTACH PARTITION tbspace_reindex_part_index_0;
CREATE INDEX tbspace_reindex_part_index_10 ON ONLY tbspace_reindex_part_10 (c1);
ALTER INDEX tbspace_reindex_part_index ATTACH PARTITION tbspace_reindex_part_index_10;
CREATE INDEX tbspace_reindex_part_index_0_1 ON ONLY tbspace_reindex_part_0_1 (c1);
ALTER INDEX tbspace_reindex_part_index_0 ATTACH PARTITION tbspace_reindex_part_index_0_1;
CREATE INDEX tbspace_reindex_part_index_0_2 ON ONLY tbspace_reindex_part_0_2 (c1);
ALTER INDEX tbspace_reindex_part_index_0 ATTACH PARTITION tbspace_reindex_part_index_0_2;
SELECT relid, parentrelid, level FROM pg_partition_tree('tbspace_reindex_part_index')
  ORDER BY relid, level;
CREATE TEMP TABLE reindex_temp_before AS
  SELECT oid, relname, relfilenode, reltablespace
  FROM pg_class
    WHERE relname ~ 'tbspace_reindex_part_index';
SELECT b.relname,
       CASE WHEN a.relfilenode = b.relfilenode THEN 'relfilenode is unchanged'
       ELSE 'relfilenode has changed' END AS filenode,
       CASE WHEN a.reltablespace = b.reltablespace THEN 'reltablespace is unchanged'
       ELSE 'reltablespace has changed' END AS tbspace
  FROM reindex_temp_before b JOIN pg_class a ON b.relname = a.relname
  ORDER BY 1;
DROP TABLE tbspace_reindex_part;
CREATE SCHEMA testschema;
SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'foo';
SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'asselect';
PREPARE selectsource(int) AS SELECT $1;
SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'asexecute';
SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname = 'foo_idx';
CREATE TABLE testschema.part (a int) PARTITION BY LIST (a);
SET default_tablespace TO pg_global;
RESET default_tablespace;
CREATE TABLE testschema.part_1 PARTITION OF testschema.part FOR VALUES IN (1);
CREATE TABLE testschema.part_2 PARTITION OF testschema.part FOR VALUES IN (2);
SET default_tablespace TO pg_global;
CREATE TABLE testschema.part_4 PARTITION OF testschema.part FOR VALUES IN (4)
  TABLESPACE pg_default;
ALTER TABLE testschema.part SET TABLESPACE pg_default;
RESET default_tablespace;
CREATE TABLE testschema.part_78 PARTITION OF testschema.part FOR VALUES IN (7, 8)
  PARTITION BY LIST (a);
SELECT relname, spcname FROM pg_catalog.pg_class c
    JOIN pg_catalog.pg_namespace n ON (c.relnamespace = n.oid)
    LEFT JOIN pg_catalog.pg_tablespace t ON c.reltablespace = t.oid
    where c.relname LIKE 'part%' AND n.nspname = 'testschema' order by relname;
RESET default_tablespace;
DROP TABLE testschema.part;
CREATE TABLE testschema.part (a int) PARTITION BY LIST (a);
CREATE TABLE testschema.part1 PARTITION OF testschema.part FOR VALUES IN (1);
CREATE TABLE testschema.part2 PARTITION OF testschema.part FOR VALUES IN (2);
SELECT relname, spcname FROM pg_catalog.pg_tablespace t, pg_catalog.pg_class c
    where c.reltablespace = t.oid AND c.relname LIKE 'part%_idx' ORDER BY relname;
SET default_tablespace TO 'pg_default';
SET default_tablespace TO '';
CREATE TABLE testschema.dflt2 (a int PRIMARY KEY) PARTITION BY LIST (a);
SET default_tablespace TO '';
SET default_tablespace TO '';
SET default_tablespace TO '';
CREATE TABLE testschema.test_tab(a int, b int, c int);
ALTER TABLE testschema.test_tab ADD CONSTRAINT test_tab_unique UNIQUE (a);
CREATE INDEX test_tab_a_idx ON testschema.test_tab (a);
SET default_tablespace TO '';
CREATE INDEX test_tab_b_idx ON testschema.test_tab (b);
ALTER TABLE testschema.test_tab ALTER b TYPE bigint, ADD UNIQUE (c);
DROP TABLE testschema.test_tab;
CREATE TABLE testschema.atable AS VALUES (1), (2);
CREATE UNIQUE INDEX anindex ON testschema.atable(column1);
INSERT INTO testschema.atable VALUES(3);
SELECT COUNT(*) FROM testschema.atable;
CREATE MATERIALIZED VIEW testschema.amv AS SELECT * FROM testschema.atable;
REFRESH MATERIALIZED VIEW testschema.amv;
SELECT COUNT(*) FROM testschema.amv;
CREATE TABLE testschema.tablespace_acl (c int);
ALTER TABLE testschema.tablespace_acl ALTER c TYPE bigint;
RESET ROLE;
DROP SCHEMA testschema CASCADE;
