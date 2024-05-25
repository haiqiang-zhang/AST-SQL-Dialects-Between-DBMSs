SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
ALTER TABLE reloptions_test SET (fillfactor=31,
	autovacuum_analyze_scale_factor = 0.3);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
ALTER TABLE reloptions_test SET (autovacuum_enabled, fillfactor=32);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
ALTER TABLE reloptions_test RESET (fillfactor);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
ALTER TABLE reloptions_test RESET (autovacuum_enabled,
	autovacuum_analyze_scale_factor);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass AND
       reloptions IS NULL;
ALTER TABLE reloptions_test RESET (illegal_option);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
DROP TABLE reloptions_test;
CREATE TEMP TABLE reloptions_test(i INT NOT NULL, j text)
	WITH (vacuum_truncate=false,
	toast.vacuum_truncate=false,
	autovacuum_enabled=false);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
VACUUM (FREEZE, DISABLE_PAGE_SKIPPING) reloptions_test;
SELECT pg_relation_size('reloptions_test') > 0;
SELECT reloptions FROM pg_class WHERE oid =
	(SELECT reltoastrelid FROM pg_class
	WHERE oid = 'reloptions_test'::regclass);
ALTER TABLE reloptions_test RESET (vacuum_truncate);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
VACUUM (FREEZE, DISABLE_PAGE_SKIPPING) reloptions_test;
SELECT pg_relation_size('reloptions_test') = 0;
DROP TABLE reloptions_test;
CREATE TABLE reloptions_test (s VARCHAR)
	WITH (toast.autovacuum_vacuum_cost_delay = 23);
ALTER TABLE reloptions_test SET (toast.autovacuum_vacuum_cost_delay = 24);
ALTER TABLE reloptions_test RESET (toast.autovacuum_vacuum_cost_delay);
DROP TABLE reloptions_test;
CREATE TABLE reloptions_test (s VARCHAR) WITH
	(toast.autovacuum_vacuum_cost_delay = 23,
	autovacuum_vacuum_cost_delay = 24, fillfactor = 40);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test'::regclass;
SELECT reloptions FROM pg_class WHERE oid = (
	SELECT reltoastrelid FROM pg_class WHERE oid = 'reloptions_test'::regclass);
CREATE INDEX reloptions_test_idx ON reloptions_test (s) WITH (fillfactor=30);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test_idx'::regclass;
ALTER INDEX reloptions_test_idx SET (fillfactor=40);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test_idx'::regclass;
CREATE INDEX reloptions_test_idx3 ON reloptions_test (s);
ALTER INDEX reloptions_test_idx3 SET (fillfactor=40);
SELECT reloptions FROM pg_class WHERE oid = 'reloptions_test_idx3'::regclass;
