BEGIN;
ROLLBACK;
BEGIN;
COMMIT;
SELECT amname, amhandler, amtype FROM pg_am where amtype = 't' ORDER BY 1, 2;
CREATE TABLE tableam_parted_heap2 (a text, b int) PARTITION BY list (a);
SET default_table_access_method = 'heap';
CREATE TABLE tableam_parted_a_heap2 PARTITION OF tableam_parted_heap2 FOR VALUES IN ('a');
CREATE TABLE tableam_parted_b_heap2 PARTITION OF tableam_parted_heap2 FOR VALUES IN ('b');
RESET default_table_access_method;
CREATE TABLE tableam_parted_c_heap2 PARTITION OF tableam_parted_heap2 FOR VALUES IN ('c') USING heap;
SELECT
    pc.relkind,
    pa.amname,
    CASE WHEN relkind = 't' THEN
        (SELECT 'toast for ' || relname::regclass FROM pg_class pcm WHERE pcm.reltoastrelid = pc.oid)
    ELSE
        relname::regclass::text
    END COLLATE "C" AS relname
FROM pg_class AS pc,
    pg_am AS pa
WHERE pa.oid = pc.relam
   AND pa.amname = 'heap2'
ORDER BY 3, 1, 2;
SELECT pg_describe_object(classid,objid,objsubid) AS obj
FROM pg_depend, pg_am
WHERE pg_depend.refclassid = 'pg_am'::regclass
    AND pg_am.oid = pg_depend.refobjid
    AND pg_am.amname = 'heap2'
ORDER BY classid, objid, objsubid;
CREATE TABLE heaptable USING heap AS
  SELECT a, repeat(a::text, 100) FROM generate_series(1,9) AS a;
SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heaptable'::regclass;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as objref,
       deptype
  FROM pg_depend
  WHERE classid = 'pg_class'::regclass AND
        objid = 'heaptable'::regclass
  ORDER BY 1, 2;
ALTER TABLE heaptable SET ACCESS METHOD heap;
SELECT pg_describe_object(classid, objid, objsubid) as obj,
       pg_describe_object(refclassid, refobjid, refobjsubid) as objref,
       deptype
  FROM pg_depend
  WHERE classid = 'pg_class'::regclass AND
        objid = 'heaptable'::regclass
  ORDER BY 1, 2;
SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heaptable'::regclass;
SELECT COUNT(a), COUNT(1) FILTER(WHERE a=1) FROM heaptable;
BEGIN;
ROLLBACK;
CREATE MATERIALIZED VIEW heapmv USING heap AS SELECT * FROM heaptable;
SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heapmv'::regclass;
SELECT amname FROM pg_class c, pg_am am
  WHERE c.relam = am.oid AND c.oid = 'heapmv'::regclass;
DROP MATERIALIZED VIEW heapmv;
DROP TABLE heaptable;
CREATE TABLE am_partitioned(x INT, y INT)
  PARTITION BY hash (x);
DROP TABLE am_partitioned;
BEGIN;
ROLLBACK;
