SET client_min_messages TO 'warning';
RESET client_min_messages;
SELECT fdwname, fdwhandler::regproc, fdwvalidator::regproc, fdwoptions FROM pg_foreign_data_wrapper ORDER BY 1, 2, 3;
SELECT srvname, srvoptions FROM pg_foreign_server;
RESET ROLE;
RESET ROLE;
DROP FOREIGN DATA WRAPPER IF EXISTS nonexistent;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
DROP SERVER IF EXISTS nonexistent;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
DROP USER MAPPING IF EXISTS FOR regress_test_missing_role SERVER s4;
DROP USER MAPPING IF EXISTS FOR user SERVER ss4;
DROP USER MAPPING IF EXISTS FOR public SERVER s7;
RESET ROLE;
CREATE SCHEMA foreign_schema;
CREATE TABLE ref_table (id integer PRIMARY KEY);
DROP TABLE ref_table;
CREATE TABLE lt1 (a INT) PARTITION BY RANGE (a);
CREATE INDEX ON lt1 (a);
CREATE UNIQUE INDEX ON lt1 (a);
ALTER TABLE lt1 ADD PRIMARY KEY (a);
DROP TABLE lt1;
CREATE TABLE lt1 (a INT) PARTITION BY RANGE (a);
CREATE INDEX ON lt1 (a);
CREATE UNIQUE INDEX ON lt1 (a);
ALTER TABLE lt1 ADD PRIMARY KEY (a);
DROP TABLE lt1;
CREATE TABLE lt1 (a INT) PARTITION BY RANGE (a);
CREATE INDEX ON lt1 (a);
CREATE TABLE lt1_part1
  PARTITION OF lt1 FOR VALUES FROM (0) TO (1000)
  PARTITION BY RANGE (a);
CREATE UNIQUE INDEX ON lt1 (a);
ALTER TABLE lt1 ADD PRIMARY KEY (a);
CREATE UNIQUE INDEX ON lt1 (a);
DROP TABLE lt1;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c4 integer;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c6 integer;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c7 integer NOT NULL;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c8 integer;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c9 integer;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ADD COLUMN c10 integer OPTIONS (p1 'v1');
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c6 SET NOT NULL;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c7 DROP NOT NULL;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c8 TYPE char(10);
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c8 SET DATA TYPE text;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c7 OPTIONS (ADD p1 'v1', ADD p2 'v2'),
                        ALTER COLUMN c8 OPTIONS (ADD p1 'v1', ADD p2 'v2');
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 ALTER COLUMN c8 OPTIONS (SET p2 'V2', DROP p1);
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 DROP CONSTRAINT IF EXISTS no_const;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 DROP CONSTRAINT ft1_c1_check;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 OWNER TO regress_test_role;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 OPTIONS (DROP delimiter, SET quote '~', ADD escape '@');
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 DROP COLUMN IF EXISTS no_column;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 DROP COLUMN c9;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 SET SCHEMA foreign_schema;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 RENAME c1 TO foreign_column_1;
ALTER FOREIGN TABLE IF EXISTS doesnt_exist_ft1 RENAME TO foreign_table_1;
SELECT * FROM information_schema.foreign_data_wrappers ORDER BY 1, 2;
SELECT * FROM information_schema.foreign_data_wrapper_options ORDER BY 1, 2, 3;
SELECT * FROM information_schema.foreign_servers ORDER BY 1, 2;
SELECT * FROM information_schema.foreign_server_options ORDER BY 1, 2, 3;
SELECT * FROM information_schema.user_mappings ORDER BY lower(authorization_identifier), 2, 3;
SELECT * FROM information_schema.usage_privileges WHERE object_type LIKE 'FOREIGN%' AND object_name IN ('s6', 'foo') ORDER BY 1, 2, 3, 4, 5;
SELECT * FROM information_schema.role_usage_grants WHERE object_type LIKE 'FOREIGN%' AND object_name IN ('s6', 'foo') ORDER BY 1, 2, 3, 4, 5;
SELECT * FROM information_schema.foreign_tables ORDER BY 1, 2, 3;
SELECT * FROM information_schema.foreign_table_options ORDER BY 1, 2, 3, 4;
SELECT * FROM information_schema.user_mapping_options ORDER BY 1, 2, 3, 4;
SELECT * FROM information_schema.usage_privileges WHERE object_type LIKE 'FOREIGN%' AND object_name IN ('s6', 'foo') ORDER BY 1, 2, 3, 4, 5;
SELECT * FROM information_schema.role_usage_grants WHERE object_type LIKE 'FOREIGN%' AND object_name IN ('s6', 'foo') ORDER BY 1, 2, 3, 4, 5;
SELECT * FROM information_schema.user_mapping_options ORDER BY 1, 2, 3, 4;
RESET ROLE;
SELECT has_foreign_data_wrapper_privilege('regress_test_role',
    (SELECT oid FROM pg_foreign_data_wrapper WHERE fdwname='foo'), 'USAGE');
SELECT has_server_privilege('regress_test_role',
    (SELECT oid FROM pg_foreign_server WHERE srvname='s8'), 'USAGE');
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
RESET ROLE;
CREATE FUNCTION dummy_trigger() RETURNS TRIGGER AS $$
  BEGIN
    RETURN NULL;
  END
$$ language plpgsql;
DROP FUNCTION dummy_trigger();
CREATE TABLE fd_pt1 (
	c1 integer NOT NULL,
	c2 text,
	c3 date
);
ALTER TABLE fd_pt1 ADD COLUMN c4 integer;
ALTER TABLE fd_pt1 ADD COLUMN c5 integer DEFAULT 0;
ALTER TABLE fd_pt1 ADD COLUMN c6 integer;
ALTER TABLE fd_pt1 ADD COLUMN c7 integer NOT NULL;
ALTER TABLE fd_pt1 ADD COLUMN c8 integer;
ALTER TABLE fd_pt1 ALTER COLUMN c4 SET DEFAULT 0;
ALTER TABLE fd_pt1 ALTER COLUMN c5 DROP DEFAULT;
ALTER TABLE fd_pt1 ALTER COLUMN c6 SET NOT NULL;
ALTER TABLE fd_pt1 ALTER COLUMN c7 DROP NOT NULL;
ALTER TABLE fd_pt1 ALTER COLUMN c8 TYPE char(10) USING '0';
ALTER TABLE fd_pt1 ALTER COLUMN c8 TYPE char(10);
ALTER TABLE fd_pt1 ALTER COLUMN c8 SET DATA TYPE text;
ALTER TABLE fd_pt1 ALTER COLUMN c1 SET STATISTICS 10000;
ALTER TABLE fd_pt1 ALTER COLUMN c1 SET (n_distinct = 100);
ALTER TABLE fd_pt1 ALTER COLUMN c8 SET STATISTICS -1;
ALTER TABLE fd_pt1 ALTER COLUMN c8 SET STORAGE EXTERNAL;
ALTER TABLE fd_pt1 DROP COLUMN c4;
ALTER TABLE fd_pt1 DROP COLUMN c5;
ALTER TABLE fd_pt1 DROP COLUMN c6;
ALTER TABLE fd_pt1 DROP COLUMN c7;
ALTER TABLE fd_pt1 DROP COLUMN c8;
ALTER TABLE fd_pt1 ADD CONSTRAINT fd_pt1chk1 CHECK (c1 > 0) NO INHERIT;
ALTER TABLE fd_pt1 ADD CONSTRAINT fd_pt1chk2 CHECK (c2 <> '');
SELECT relname, conname, contype, conislocal, coninhcount, connoinherit
  FROM pg_class AS pc JOIN pg_constraint AS pgc ON (conrelid = pc.oid)
  WHERE pc.relname = 'fd_pt1'
  ORDER BY 1,2;
ALTER TABLE fd_pt1 DROP CONSTRAINT fd_pt1chk1 CASCADE;
ALTER TABLE fd_pt1 DROP CONSTRAINT fd_pt1chk2 CASCADE;
INSERT INTO fd_pt1 VALUES (1, 'fd_pt1'::text, '1994-01-01'::date);
ALTER TABLE fd_pt1 ADD CONSTRAINT fd_pt1chk3 CHECK (c2 <> '') NOT VALID;
ALTER TABLE fd_pt1 VALIDATE CONSTRAINT fd_pt1chk3;
ALTER TABLE fd_pt1 RENAME COLUMN c1 TO f1;
ALTER TABLE fd_pt1 RENAME COLUMN c2 TO f2;
ALTER TABLE fd_pt1 RENAME COLUMN c3 TO f3;
ALTER TABLE fd_pt1 RENAME CONSTRAINT fd_pt1chk3 TO f2_check;
DROP TABLE fd_pt1 CASCADE;
DROP FOREIGN TABLE IF EXISTS no_table;
CREATE TABLE fd_pt2 (
	c1 integer NOT NULL,
	c2 text,
	c3 date
) PARTITION BY LIST (c1);
ALTER TABLE fd_pt2 ALTER c2 SET NOT NULL;
ALTER TABLE fd_pt2 ADD CONSTRAINT fd_pt2chk1 CHECK (c1 > 0);
DROP TABLE fd_pt2;
CREATE TEMP TABLE temp_parted (a int) PARTITION BY LIST (a);
DROP TABLE temp_parted;
DROP SCHEMA foreign_schema CASCADE;
SELECT fdwname, fdwhandler, fdwvalidator, fdwoptions FROM pg_foreign_data_wrapper;
SELECT srvname, srvoptions FROM pg_foreign_server;
