reset role;
create table event_trigger_fire1 (a int);
create table event_trigger_fire2 (a int);
create table event_trigger_fire3 (a int);
create table event_trigger_fire4 (a int);
create table event_trigger_fire5 (a int);
grant all on table event_trigger_fire1 to public;
comment on table event_trigger_fire1 is 'here is a comment';
revoke all on table event_trigger_fire1 from public;
drop table event_trigger_fire1;
drop event trigger if exists regress_event_trigger2;
drop event trigger if exists regress_event_trigger2;
CREATE TEMP TABLE a_temp_tbl ();
END;
RESET SESSION AUTHORIZATION;
CREATE TABLE undroppable_objs (
	object_type text,
	object_identity text
);
INSERT INTO undroppable_objs VALUES
('table', 'schema_one.table_three'),
('table', 'audit_tbls.schema_two_table_three');
CREATE TABLE dropped_objects (
	type text,
	schema text,
	object text
);
END;
DELETE FROM undroppable_objs WHERE object_identity = 'audit_tbls.schema_two_table_three';
DELETE FROM undroppable_objs WHERE object_identity = 'schema_one.table_three';
SELECT * FROM dropped_objects WHERE schema IS NULL OR schema <> 'pg_toast';
SELECT * FROM dropped_objects WHERE type = 'schema';
END;
END;
CREATE SCHEMA evttrig
	CREATE TABLE one (col_a SERIAL PRIMARY KEY, col_b text DEFAULT 'forty two', col_c SERIAL)
	CREATE INDEX one_idx ON one (col_b)
	CREATE TABLE two (col_c INTEGER CHECK (col_c > 0) REFERENCES one DEFAULT 42)
	CREATE TABLE id (col_d int NOT NULL GENERATED ALWAYS AS IDENTITY);
CREATE TABLE evttrig.parted (
    id int PRIMARY KEY)
    PARTITION BY RANGE (id);
CREATE TABLE evttrig.part_1_10 PARTITION OF evttrig.parted (id)
  FOR VALUES FROM (1) TO (10);
CREATE TABLE evttrig.part_10_20 PARTITION OF evttrig.parted (id)
  FOR VALUES FROM (10) TO (20) PARTITION BY RANGE (id);
CREATE TABLE evttrig.part_10_15 PARTITION OF evttrig.part_10_20 (id)
  FOR VALUES FROM (10) TO (15);
CREATE TABLE evttrig.part_15_20 PARTITION OF evttrig.part_10_20 (id)
  FOR VALUES FROM (15) TO (20);
ALTER TABLE evttrig.two DROP COLUMN col_c;
ALTER TABLE evttrig.one ALTER COLUMN col_b DROP DEFAULT;
ALTER TABLE evttrig.one DROP CONSTRAINT one_pkey;
ALTER TABLE evttrig.one DROP COLUMN col_c;
ALTER TABLE evttrig.id ALTER COLUMN col_d SET DATA TYPE bigint;
ALTER TABLE evttrig.id ALTER COLUMN col_d DROP IDENTITY,
  ALTER COLUMN col_d SET DATA TYPE int;
DROP INDEX evttrig.one_idx;
DROP SCHEMA evttrig CASCADE;
DROP TABLE a_temp_tbl;
END;
create table rewriteme (id serial primary key, foo float, bar timestamptz);
insert into rewriteme
     select x * 1.001 from generate_series(1, 500) as t(x);
alter table rewriteme alter column foo type numeric;
alter table rewriteme add column baz int default 0;
END;
alter table rewriteme
 add column onemore int default 0,
 add column another int default -1,
 alter column foo type numeric(10,4);
CREATE MATERIALIZED VIEW heapmv USING heap AS SELECT 1 AS a;
DROP MATERIALIZED VIEW heapmv;
alter table rewriteme alter column foo type numeric(12,4);
begin;
set timezone to 'UTC';
alter table rewriteme alter column bar type timestamp;
set timezone to '0';
alter table rewriteme alter column bar type timestamptz;
set timezone to 'Europe/London';
alter table rewriteme alter column bar type timestamp;
rollback;
END;
create type rewritetype as (a int);
create table rewritemetoo1 of rewritetype;
create table rewritemetoo2 of rewritetype;
alter type rewritetype alter attribute a type text cascade;
create table rewritemetoo3 (a rewritetype);
drop table rewriteme;
END;
END;
CREATE TABLE concur_reindex_tab (c1 int);
CREATE INDEX concur_reindex_ind ON concur_reindex_tab (c1);
REINDEX INDEX concur_reindex_ind;
REINDEX TABLE concur_reindex_tab;
REINDEX INDEX CONCURRENTLY concur_reindex_ind;
REINDEX TABLE CONCURRENTLY concur_reindex_tab;
REINDEX INDEX concur_reindex_ind;
REINDEX INDEX CONCURRENTLY concur_reindex_ind;
DROP INDEX concur_reindex_ind;
REINDEX TABLE concur_reindex_tab;
REINDEX TABLE CONCURRENTLY concur_reindex_tab;
CREATE SCHEMA concur_reindex_schema;
REINDEX SCHEMA concur_reindex_schema;
REINDEX SCHEMA CONCURRENTLY concur_reindex_schema;
CREATE TABLE concur_reindex_schema.tab (a int);
CREATE INDEX ind ON concur_reindex_schema.tab (a);
REINDEX SCHEMA concur_reindex_schema;
REINDEX SCHEMA CONCURRENTLY concur_reindex_schema;
DROP INDEX concur_reindex_schema.ind;
REINDEX SCHEMA concur_reindex_schema;
REINDEX SCHEMA CONCURRENTLY concur_reindex_schema;
DROP SCHEMA concur_reindex_schema CASCADE;
CREATE TABLE concur_reindex_part (id int) PARTITION BY RANGE (id);
REINDEX TABLE concur_reindex_part;
REINDEX TABLE CONCURRENTLY concur_reindex_part;
CREATE TABLE concur_reindex_child PARTITION OF concur_reindex_part
  FOR VALUES FROM (0) TO (10);
REINDEX TABLE concur_reindex_part;
REINDEX TABLE CONCURRENTLY concur_reindex_part;
CREATE INDEX concur_reindex_partidx ON concur_reindex_part (id);
REINDEX INDEX concur_reindex_partidx;
REINDEX INDEX CONCURRENTLY concur_reindex_partidx;
REINDEX TABLE concur_reindex_part;
REINDEX TABLE CONCURRENTLY concur_reindex_part;
DROP TABLE concur_reindex_part;
DROP TABLE concur_reindex_tab;
RESET SESSION AUTHORIZATION;
CREATE TABLE event_trigger_test (a integer, b text);
END;
END;
END;
CREATE POLICY p1 ON event_trigger_test USING (FALSE);
ALTER POLICY p1 ON event_trigger_test USING (TRUE);
ALTER POLICY p1 ON event_trigger_test RENAME TO p2;
DROP POLICY p2 ON event_trigger_test;
SELECT
    e.evtname,
    pg_describe_object('pg_event_trigger'::regclass, e.oid, 0) as descr,
    b.type, b.object_names, b.object_args,
    pg_identify_object(a.classid, a.objid, a.objsubid) as ident
  FROM pg_event_trigger as e,
    LATERAL pg_identify_object_as_address('pg_event_trigger'::regclass, e.oid, 0) as b,
    LATERAL pg_get_object_address(b.type, b.object_names, b.object_args) as a
  ORDER BY e.evtname;
CREATE POLICY pguc ON event_trigger_test USING (FALSE);
DROP POLICY pguc ON event_trigger_test;
CREATE POLICY pguc ON event_trigger_test USING (FALSE);
DROP POLICY pguc ON event_trigger_test;
