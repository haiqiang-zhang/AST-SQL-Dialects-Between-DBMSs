SELECT num_nonnulls(NULL);
SELECT num_nulls(NULL);
RESET ROLE;
select * from (select (pg_timezone_names()).name) ptn where name='UTC' limit 1;
select count(*) > 0 from
  (select pg_tablespace_databases(oid) as pts from pg_tablespace
   where spcname = 'pg_default') pts
  join pg_database db on pts.pts = db.oid;
SELECT count(*) > 0 AS ok FROM pg_control_checkpoint();
SELECT count(*) > 0 AS ok FROM pg_control_init();
SELECT count(*) > 0 AS ok FROM pg_control_recovery();
SELECT count(*) > 0 AS ok FROM pg_control_system();
SELECT * FROM pg_split_walfile_name(NULL);
CREATE TABLE test_chunk_id (a TEXT, b TEXT STORAGE EXTERNAL);
INSERT INTO test_chunk_id VALUES ('x', repeat('x', 8192));
DROP TABLE test_chunk_id;
