ANALYZE slow_emp4000;
ANALYZE fast_emp4000;
CREATE INDEX grect2ind ON fast_emp4000 USING gist (home_base);
CREATE TEMP TABLE gpolygon_tbl AS
    SELECT polygon(home_base) AS f1 FROM slow_emp4000;
INSERT INTO gpolygon_tbl VALUES ( '(1000,0,0,1000)' );
INSERT INTO gpolygon_tbl VALUES ( '(0,1000,1000,1000)' );
CREATE TEMP TABLE gcircle_tbl AS
    SELECT circle(home_base) AS f1 FROM slow_emp4000;
CREATE INDEX ggpolygonind ON gpolygon_tbl USING gist (f1);
CREATE INDEX ggcircleind ON gcircle_tbl USING gist (f1);
SET enable_seqscan = ON;
SET enable_indexscan = OFF;
SET enable_bitmapscan = OFF;
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];
SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box;
SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;
SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10;
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;
EXPLAIN (COSTS OFF)
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];
SELECT * FROM fast_emp4000
    WHERE home_base <@ '(200,200),(2000,1000)'::box
    ORDER BY (home_base[0])[0];
EXPLAIN (COSTS OFF)
SELECT count(*) FROM fast_emp4000 WHERE home_base && '(1000,1000,0,0)'::box;
EXPLAIN (COSTS OFF)
SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;
SELECT * FROM gpolygon_tbl ORDER BY f1 <-> '(0,0)'::point LIMIT 10;
EXPLAIN (COSTS OFF)
SELECT circle_center(f1), round(radius(f1)) as radius FROM gcircle_tbl ORDER BY f1 <-> '(200,300)'::point LIMIT 10;
EXPLAIN (COSTS OFF)
SELECT point(x,x), (SELECT f1 FROM gpolygon_tbl ORDER BY f1 <-> point(x,x) LIMIT 1) as c FROM generate_series(0,10,1) x;
SELECT point(x,x), (SELECT f1 FROM gpolygon_tbl ORDER BY f1 <-> point(x,x) LIMIT 1) as c FROM generate_series(0,10,1) x;
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
CREATE TABLE array_index_op_test (
	seqno		int4,
	i			int4[],
	t			text[]
);
ANALYZE array_index_op_test;
SELECT * FROM array_index_op_test WHERE i = '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{NULL}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{NULL}' ORDER BY seqno;
SET enable_seqscan = OFF;
SET enable_indexscan = OFF;
SET enable_bitmapscan = ON;
CREATE INDEX intarrayidx ON array_index_op_test USING gin (i);
explain (costs off)
SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{32,17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32,17}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{38,34,32,89}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i = '{47,77}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i = '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i <@ '{}' ORDER BY seqno;
CREATE INDEX textarrayidx ON array_index_op_test USING gin (t);
explain (costs off)
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t <@ '{AAAAAAAA72908,AAAAAAAAAAAAAAAAAAA17075,AA88409,AAAAAAAAAAAAAAAAAA36842,AAAAAAA48038,AAAAAAAAAAAAAA10611}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{AAAAAAAAAA646,A87088}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t <@ '{}' ORDER BY seqno;
DROP INDEX intarrayidx, textarrayidx;
CREATE INDEX botharrayidx ON array_index_op_test USING gin (i, t);
SELECT * FROM array_index_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t @> '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t && '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i @> '{32}' AND t && '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE i && '{32}' AND t @> '{AAAAAAA80240}' ORDER BY seqno;
SELECT * FROM array_index_op_test WHERE t = '{}' ORDER BY seqno;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
CREATE TABLE array_gin_test (a int[]);
INSERT INTO array_gin_test SELECT ARRAY[1, g%5, g] FROM generate_series(1, 10000) g;
CREATE INDEX array_gin_test_idx ON array_gin_test USING gin (a);
SELECT COUNT(*) FROM array_gin_test WHERE a @> '{2}';
DROP TABLE array_gin_test;
CREATE INDEX gin_relopts_test ON array_index_op_test USING gin (i)
  WITH (FASTUPDATE=on, GIN_PENDING_LIST_LIMIT=128);
CREATE UNLOGGED TABLE unlogged_hash_table (id int4);
CREATE INDEX unlogged_hash_index ON unlogged_hash_table USING hash (id int4_ops);
DROP TABLE unlogged_hash_table;
SET maintenance_work_mem = '1MB';
RESET maintenance_work_mem;
CREATE TABLE unique_tbl (i int, t text);
CREATE UNIQUE INDEX unique_idx1 ON unique_tbl (i) NULLS DISTINCT;
CREATE UNIQUE INDEX unique_idx2 ON unique_tbl (i) NULLS NOT DISTINCT;
INSERT INTO unique_tbl VALUES (1, 'one');
INSERT INTO unique_tbl VALUES (2, 'two');
INSERT INTO unique_tbl VALUES (3, 'three');
INSERT INTO unique_tbl VALUES (4, 'four');
INSERT INTO unique_tbl VALUES (5, 'one');
INSERT INTO unique_tbl (t) VALUES ('six');
DROP INDEX unique_idx1, unique_idx2;
INSERT INTO unique_tbl (t) VALUES ('seven');
CREATE UNIQUE INDEX unique_idx3 ON unique_tbl (i) NULLS DISTINCT;
DELETE FROM unique_tbl WHERE t = 'seven';
CREATE UNIQUE INDEX unique_idx4 ON unique_tbl (i) NULLS NOT DISTINCT;
SELECT pg_get_indexdef('unique_idx3'::regclass);
DROP TABLE unique_tbl;
CREATE TABLE func_index_heap (f1 text, f2 text);
CREATE UNIQUE INDEX func_index_index on func_index_heap (textcat(f1,f2));
INSERT INTO func_index_heap VALUES('ABC','DEF');
INSERT INTO func_index_heap VALUES('AB','CDEFG');
INSERT INTO func_index_heap VALUES('QWE','RTY');
INSERT INTO func_index_heap VALUES('QWERTY');
DROP TABLE func_index_heap;
CREATE TABLE func_index_heap (f1 text, f2 text);
CREATE UNIQUE INDEX func_index_index on func_index_heap ((f1 || f2) text_ops);
INSERT INTO func_index_heap VALUES('ABC','DEF');
INSERT INTO func_index_heap VALUES('AB','CDEFG');
INSERT INTO func_index_heap VALUES('QWE','RTY');
INSERT INTO func_index_heap VALUES('QWERTY');
CREATE TABLE covering_index_heap (f1 int, f2 int, f3 text);
CREATE UNIQUE INDEX covering_index_index on covering_index_heap (f1,f2) INCLUDE(f3);
INSERT INTO covering_index_heap VALUES(1,1,'AAA');
INSERT INTO covering_index_heap VALUES(1,2,'AAA');
INSERT INTO covering_index_heap VALUES(1,4,'AAA');
CREATE UNIQUE INDEX covering_pkey on covering_index_heap (f1,f2) INCLUDE(f3);
ALTER TABLE covering_index_heap ADD CONSTRAINT covering_pkey PRIMARY KEY USING INDEX
covering_pkey;
DROP TABLE covering_index_heap;
CREATE TABLE concur_heap (f1 text, f2 text);
CREATE INDEX CONCURRENTLY concur_index1 ON concur_heap(f2,f1);
CREATE INDEX CONCURRENTLY IF NOT EXISTS concur_index1 ON concur_heap(f2,f1);
INSERT INTO concur_heap VALUES  ('a','b');
INSERT INTO concur_heap VALUES  ('b','b');
CREATE UNIQUE INDEX CONCURRENTLY concur_index2 ON concur_heap(f1);
CREATE UNIQUE INDEX CONCURRENTLY IF NOT EXISTS concur_index2 ON concur_heap(f1);
CREATE INDEX CONCURRENTLY concur_index4 on concur_heap(f2) WHERE f1='a';
CREATE INDEX CONCURRENTLY concur_index5 on concur_heap(f2) WHERE f1='x';
CREATE INDEX CONCURRENTLY on concur_heap((f2||f1));
BEGIN;
COMMIT;
END;
BEGIN;
CREATE INDEX std_index on concur_heap(f2);
COMMIT;
VACUUM FULL concur_heap;
DELETE FROM concur_heap WHERE f1 = 'b';
VACUUM FULL concur_heap;
REINDEX TABLE concur_heap;
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
DROP INDEX CONCURRENTLY concur_temp_ind;
DROP TABLE concur_temp;
BEGIN;
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DROP;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
COMMIT;
CREATE TEMP TABLE concur_temp (f1 int, f2 text)
  ON COMMIT DELETE ROWS;
INSERT INTO concur_temp VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX CONCURRENTLY concur_temp_ind ON concur_temp(f1);
DROP INDEX CONCURRENTLY concur_temp_ind;
DROP TABLE concur_temp;
DROP INDEX CONCURRENTLY "concur_index2";
DROP INDEX CONCURRENTLY IF EXISTS "concur_index2";
BEGIN;
ROLLBACK;
DROP INDEX CONCURRENTLY IF EXISTS "concur_index3";
DROP INDEX CONCURRENTLY "concur_index4";
DROP INDEX CONCURRENTLY "concur_index5";
DROP INDEX CONCURRENTLY "concur_index1";
DROP INDEX CONCURRENTLY "concur_heap_expr_idx";
DROP TABLE concur_heap;
CREATE TABLE cwi_test( a int , b varchar(10), c char);
INSERT INTO cwi_test VALUES(1, 2), (3, 4), (5, 6);
CREATE UNIQUE INDEX cwi_uniq_idx ON cwi_test(a , b);
ALTER TABLE cwi_test ADD primary key USING INDEX cwi_uniq_idx;
CREATE UNIQUE INDEX cwi_uniq2_idx ON cwi_test(b , a);
ALTER TABLE cwi_test DROP CONSTRAINT cwi_uniq_idx,
	ADD CONSTRAINT cwi_replaced_pkey PRIMARY KEY
		USING INDEX cwi_uniq2_idx;
CREATE UNIQUE INDEX cwi_uniq3_idx ON cwi_test(a desc);
CREATE UNIQUE INDEX cwi_uniq4_idx ON cwi_test(b collate "POSIX");
DROP TABLE cwi_test;
CREATE TABLE cwi_test(a int) PARTITION BY hash (a);
create unique index on cwi_test (a);
DROP TABLE cwi_test;
CREATE TABLE cwi_test(a int, b int);
CREATE UNIQUE INDEX cwi_a_nnd ON cwi_test (a) NULLS NOT DISTINCT;
DROP TABLE cwi_test;
CREATE TABLE syscol_table (a INT);
DROP TABLE syscol_table;
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = ON;
SET enable_seqscan = OFF;
SET enable_indexscan = ON;
SET enable_bitmapscan = OFF;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
SET enable_indexonlyscan = OFF;
RESET enable_indexonlyscan;
create temp table boolindex (b bool, i int, unique(b, i), junk float);
explain (costs off)
  select * from boolindex order by b, i limit 10;
explain (costs off)
  select * from boolindex where b order by i limit 10;
explain (costs off)
  select * from boolindex where b = true order by i desc limit 10;
explain (costs off)
  select * from boolindex where not b order by i limit 10;
explain (costs off)
  select * from boolindex where b is true order by i desc limit 10;
explain (costs off)
  select * from boolindex where b is false order by i desc limit 10;
CREATE TABLE reindex_verbose(id integer primary key);
REINDEX (VERBOSE) TABLE reindex_verbose;
DROP TABLE reindex_verbose;
CREATE TABLE concur_reindex_tab (c1 int);
REINDEX TABLE concur_reindex_tab;
REINDEX (CONCURRENTLY) TABLE concur_reindex_tab;
ALTER TABLE concur_reindex_tab ADD COLUMN c2 text;
CREATE UNIQUE INDEX concur_reindex_ind1 ON concur_reindex_tab(c1);
CREATE INDEX concur_reindex_ind2 ON concur_reindex_tab(c2);
CREATE UNIQUE INDEX concur_reindex_ind3 ON concur_reindex_tab(abs(c1));
CREATE INDEX concur_reindex_ind4 ON concur_reindex_tab(c1, c1, c2);
ALTER TABLE concur_reindex_tab ADD PRIMARY KEY USING INDEX concur_reindex_ind1;
CREATE TABLE concur_reindex_tab2 (c1 int REFERENCES concur_reindex_tab);
INSERT INTO concur_reindex_tab VALUES  (1, 'a');
INSERT INTO concur_reindex_tab VALUES  (2, 'a');
CREATE TABLE concur_reindex_tab3 (c1 int, c2 int4range, EXCLUDE USING gist (c2 WITH &&));
INSERT INTO concur_reindex_tab3 VALUES  (3, '[1,2]');
REINDEX TABLE CONCURRENTLY concur_reindex_tab3;
CREATE MATERIALIZED VIEW concur_reindex_matview AS SELECT * FROM concur_reindex_tab;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_tab'::regclass,
            'concur_reindex_ind1'::regclass,
	    'concur_reindex_ind2'::regclass,
	    'concur_reindex_ind3'::regclass,
	    'concur_reindex_ind4'::regclass,
	    'concur_reindex_matview'::regclass)
  ORDER BY 1, 2;
REINDEX INDEX CONCURRENTLY concur_reindex_ind1;
REINDEX TABLE CONCURRENTLY concur_reindex_tab;
REINDEX TABLE CONCURRENTLY concur_reindex_matview;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_tab'::regclass,
            'concur_reindex_ind1'::regclass,
	    'concur_reindex_ind2'::regclass,
	    'concur_reindex_ind3'::regclass,
	    'concur_reindex_ind4'::regclass,
	    'concur_reindex_matview'::regclass)
  ORDER BY 1, 2;
CREATE TABLE testcomment (i int);
CREATE INDEX testcomment_idx1 ON testcomment (i);
COMMENT ON INDEX testcomment_idx1 IS 'test comment';
SELECT obj_description('testcomment_idx1'::regclass, 'pg_class');
REINDEX TABLE testcomment;
REINDEX TABLE CONCURRENTLY testcomment;
DROP TABLE testcomment;
CREATE TABLE concur_clustered(i int);
CREATE INDEX concur_clustered_i_idx ON concur_clustered(i);
ALTER TABLE concur_clustered CLUSTER ON concur_clustered_i_idx;
REINDEX TABLE CONCURRENTLY concur_clustered;
SELECT indexrelid::regclass, indisclustered FROM pg_index
  WHERE indrelid = 'concur_clustered'::regclass;
DROP TABLE concur_clustered;
CREATE TABLE concur_replident(i int NOT NULL);
CREATE UNIQUE INDEX concur_replident_i_idx ON concur_replident(i);
ALTER TABLE concur_replident REPLICA IDENTITY
  USING INDEX concur_replident_i_idx;
SELECT indexrelid::regclass, indisreplident FROM pg_index
  WHERE indrelid = 'concur_replident'::regclass;
REINDEX TABLE CONCURRENTLY concur_replident;
SELECT indexrelid::regclass, indisreplident FROM pg_index
  WHERE indrelid = 'concur_replident'::regclass;
DROP TABLE concur_replident;
CREATE TABLE concur_appclass_tab(i tsvector, j tsvector, k tsvector);
CREATE INDEX concur_appclass_ind on concur_appclass_tab
  USING gist (i tsvector_ops (siglen='1000'), j tsvector_ops (siglen='500'));
CREATE INDEX concur_appclass_ind_2 on concur_appclass_tab
  USING gist (k tsvector_ops (siglen='300'), j tsvector_ops);
REINDEX TABLE CONCURRENTLY concur_appclass_tab;
DROP TABLE concur_appclass_tab;
CREATE TABLE concur_reindex_part (c1 int, c2 int) PARTITION BY RANGE (c1);
CREATE TABLE concur_reindex_part_0 PARTITION OF concur_reindex_part
  FOR VALUES FROM (0) TO (10) PARTITION BY list (c2);
CREATE TABLE concur_reindex_part_0_1 PARTITION OF concur_reindex_part_0
  FOR VALUES IN (1);
CREATE TABLE concur_reindex_part_0_2 PARTITION OF concur_reindex_part_0
  FOR VALUES IN (2);
CREATE TABLE concur_reindex_part_10 PARTITION OF concur_reindex_part
  FOR VALUES FROM (10) TO (20) PARTITION BY list (c2);
CREATE INDEX concur_reindex_part_index ON ONLY concur_reindex_part (c1);
CREATE INDEX concur_reindex_part_index_0 ON ONLY concur_reindex_part_0 (c1);
ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_0;
CREATE INDEX concur_reindex_part_index_10 ON ONLY concur_reindex_part_10 (c1);
ALTER INDEX concur_reindex_part_index ATTACH PARTITION concur_reindex_part_index_10;
CREATE INDEX concur_reindex_part_index_0_1 ON ONLY concur_reindex_part_0_1 (c1);
ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_1;
CREATE INDEX concur_reindex_part_index_0_2 ON ONLY concur_reindex_part_0_2 (c1);
ALTER INDEX concur_reindex_part_index_0 ATTACH PARTITION concur_reindex_part_index_0_2;
SELECT relid, parentrelid, level FROM pg_partition_tree('concur_reindex_part_index')
  ORDER BY relid, level;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_part'::regclass,
            'concur_reindex_part_0'::regclass,
            'concur_reindex_part_0_1'::regclass,
            'concur_reindex_part_0_2'::regclass,
            'concur_reindex_part_index'::regclass,
            'concur_reindex_part_index_0'::regclass,
            'concur_reindex_part_index_0_1'::regclass,
            'concur_reindex_part_index_0_2'::regclass)
  ORDER BY 1, 2;
REINDEX INDEX CONCURRENTLY concur_reindex_part_index_0_1;
REINDEX INDEX CONCURRENTLY concur_reindex_part_index_0_2;
REINDEX TABLE CONCURRENTLY concur_reindex_part_0_1;
REINDEX TABLE CONCURRENTLY concur_reindex_part_0_2;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid,refobjid,refobjsubid) as objref,
       deptype
FROM pg_depend
WHERE classid = 'pg_class'::regclass AND
  objid in ('concur_reindex_part'::regclass,
            'concur_reindex_part_0'::regclass,
            'concur_reindex_part_0_1'::regclass,
            'concur_reindex_part_0_2'::regclass,
            'concur_reindex_part_index'::regclass,
            'concur_reindex_part_index_0'::regclass,
            'concur_reindex_part_index_0_1'::regclass,
            'concur_reindex_part_index_0_2'::regclass)
  ORDER BY 1, 2;
BEGIN;
ROLLBACK;
REINDEX INDEX concur_reindex_part_index;
REINDEX INDEX CONCURRENTLY concur_reindex_part_index;
BEGIN;
ROLLBACK;
REINDEX TABLE concur_reindex_part;
REINDEX TABLE CONCURRENTLY concur_reindex_part;
DROP TABLE concur_reindex_part;
BEGIN;
COMMIT;
DROP MATERIALIZED VIEW concur_reindex_matview;
DROP TABLE concur_reindex_tab, concur_reindex_tab2, concur_reindex_tab3;
CREATE TABLE concur_reindex_tab4 (c1 int);
INSERT INTO concur_reindex_tab4 VALUES (1), (1), (2);
DELETE FROM concur_reindex_tab4 WHERE c1 = 1;
REINDEX TABLE CONCURRENTLY concur_reindex_tab4;
DROP TABLE concur_reindex_tab4;
CREATE TABLE concur_exprs_tab (c1 int , c2 boolean);
INSERT INTO concur_exprs_tab (c1, c2) VALUES (1369652450, FALSE),
  (414515746, TRUE),
  (897778963, FALSE);
CREATE UNIQUE INDEX concur_exprs_index_expr
  ON concur_exprs_tab ((c1::text COLLATE "C"));
CREATE UNIQUE INDEX concur_exprs_index_pred ON concur_exprs_tab (c1)
  WHERE (c1::text > 500000000::text COLLATE "C");
CREATE UNIQUE INDEX concur_exprs_index_pred_2
  ON concur_exprs_tab ((1 / c1))
  WHERE ('-H') >= (c2::TEXT) COLLATE "C";
ALTER INDEX concur_exprs_index_expr ALTER COLUMN 1 SET STATISTICS 100;
ANALYZE concur_exprs_tab;
REINDEX TABLE CONCURRENTLY concur_exprs_tab;
ALTER TABLE concur_exprs_tab ALTER c2 TYPE TEXT;
SELECT attrelid::regclass, attnum, attstattarget
  FROM pg_attribute WHERE attrelid IN (
    'concur_exprs_index_expr'::regclass,
    'concur_exprs_index_pred'::regclass,
    'concur_exprs_index_pred_2'::regclass)
  ORDER BY attrelid::regclass::text, attnum;
DROP TABLE concur_exprs_tab;
CREATE TEMP TABLE concur_temp_tab_1 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp_tab_1 VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX concur_temp_ind_1 ON concur_temp_tab_1(c2);
REINDEX TABLE CONCURRENTLY concur_temp_tab_1;
REINDEX INDEX CONCURRENTLY concur_temp_ind_1;
BEGIN;
COMMIT;
CREATE TEMP TABLE concur_temp_tab_2 (c1 int, c2 text)
  ON COMMIT DELETE ROWS;
CREATE INDEX concur_temp_ind_2 ON concur_temp_tab_2(c2);
REINDEX TABLE CONCURRENTLY concur_temp_tab_2;
REINDEX INDEX CONCURRENTLY concur_temp_ind_2;
BEGIN;
CREATE TEMP TABLE concur_temp_tab_3 (c1 int, c2 text)
  ON COMMIT PRESERVE ROWS;
INSERT INTO concur_temp_tab_3 VALUES (1, 'foo'), (2, 'bar');
CREATE INDEX concur_temp_ind_3 ON concur_temp_tab_3(c2);
COMMIT;
CREATE TABLE reindex_temp_before AS
SELECT oid, relname, relfilenode, relkind, reltoastrelid
  FROM pg_class
  WHERE relname IN ('concur_temp_ind_1', 'concur_temp_ind_2');
SELECT  b.relname,
        b.relkind,
        CASE WHEN a.relfilenode = b.relfilenode THEN 'relfilenode is unchanged'
        ELSE 'relfilenode has changed' END
  FROM reindex_temp_before b JOIN pg_class a ON b.oid = a.oid
  ORDER BY 1;
DROP TABLE concur_temp_tab_1, concur_temp_tab_2, reindex_temp_before;
CREATE SCHEMA schema_to_reindex;
SET search_path = 'schema_to_reindex';
CREATE TABLE table1(col1 SERIAL PRIMARY KEY);
INSERT INTO table1 SELECT generate_series(1,400);
CREATE TABLE table2(col1 SERIAL PRIMARY KEY, col2 TEXT NOT NULL);
INSERT INTO table2 SELECT generate_series(1,400), 'abc';
CREATE INDEX ON table2(col2);
CREATE MATERIALIZED VIEW matview AS SELECT col1 FROM table2;
CREATE INDEX ON matview(col1);
CREATE VIEW view AS SELECT col2 FROM table2;
CREATE TABLE reindex_before AS
SELECT oid, relname, relfilenode, relkind, reltoastrelid
	FROM pg_class
	where relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'schema_to_reindex');
INSERT INTO reindex_before
SELECT oid, 'pg_toast_TABLE', relfilenode, relkind, reltoastrelid
FROM pg_class WHERE oid IN
	(SELECT reltoastrelid FROM reindex_before WHERE reltoastrelid > 0);
INSERT INTO reindex_before
SELECT oid, 'pg_toast_TABLE_index', relfilenode, relkind, reltoastrelid
FROM pg_class where oid in
	(select indexrelid from pg_index where indrelid in
		(select reltoastrelid from reindex_before where reltoastrelid > 0));
REINDEX SCHEMA schema_to_reindex;
CREATE TABLE reindex_after AS SELECT oid, relname, relfilenode, relkind
	FROM pg_class
	where relnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'schema_to_reindex');
SELECT  b.relname,
        b.relkind,
        CASE WHEN a.relfilenode = b.relfilenode THEN 'relfilenode is unchanged'
        ELSE 'relfilenode has changed' END
  FROM reindex_before b JOIN pg_class a ON b.oid = a.oid
  ORDER BY 1;
REINDEX SCHEMA schema_to_reindex;
BEGIN;
END;
REINDEX SCHEMA CONCURRENTLY schema_to_reindex;
REINDEX SCHEMA schema_to_reindex;
RESET ROLE;
RESET ROLE;
DROP SCHEMA schema_to_reindex CASCADE;
