
create schema s;
create table s.t1(i int);
create table s.t2(i int) tablespace innodb_system;
drop schema s;

let $object_alloc= 2;
let $object_free= 2;
let $object_count= 0;
let $operation= CREATE SCHEMA s;

let $object_alloc= 9;
let $object_free= 6;
let $object_count= 3;
let $operation= CREATE TABLE s.t_myisam(i int) engine myisam;

let $object_alloc= 52;
let $object_free= 52;
let $object_count= 0;
let $operation= CREATE TABLE s.t_innodb_1(i int) TABLESPACE innodb_system;

let $object_alloc= 52;
let $object_free= 52;
let $object_count= 0;
let $operation= CREATE TABLE s.t_innodb_2(i int) TABLESPACE innodb_system;

let $object_alloc= 0;
let $object_free= 0;
let $object_count= 0;
let $operation= SELECT * FROM s.t_myisam;

let $object_alloc= 12;
let $object_free= 2;
let $object_count= 10;
let $operation= SELECT * FROM s.t_innodb_1;

let $object_alloc= 12;
let $object_free= 2;
let $object_count= 10;
let $operation= SELECT * FROM s.t_innodb_2;

let $object_alloc= 0;
let $object_free= 0;
let $object_count= 0;
let $operation= SELECT * FROM s.t_innodb_1;

let $object_alloc= 7;
let $object_free= 17;
let $object_count= -10;
let $operation= DROP TABLE s.t_innodb_1;

let $object_alloc= 7;
let $object_free= 17;
let $object_count= -10;
let $operation= DROP TABLE s.t_innodb_2;

let $object_alloc= 2;
let $object_free= 5;
let $object_count= -3;
let $operation= DROP SCHEMA s;
SET foreign_key_checks= 0;
CREATE TABLE test.tables (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `schema_id` bigint unsigned NOT NULL,
  `name` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `type` enum('BASE TABLE','VIEW','SYSTEM VIEW') COLLATE utf8mb3_bin NOT NULL,
  `engine` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `mysql_version_id` int unsigned NOT NULL,
  `row_format` enum('Fixed','Dynamic','Compressed','Redundant','Compact','Paged') COLLATE utf8mb3_bin DEFAULT NULL,
  `collation_id` bigint unsigned DEFAULT NULL,
  `comment` varchar(2048) COLLATE utf8mb3_bin NOT NULL,
  `hidden` enum('Visible','System','SE','DDL') COLLATE utf8mb3_bin NOT NULL,
  `options` mediumtext COLLATE utf8mb3_bin,
  `se_private_data` mediumtext COLLATE utf8mb3_bin,
  `se_private_id` bigint unsigned DEFAULT NULL,
  `tablespace_id` bigint unsigned DEFAULT NULL,
  `partition_type` enum('HASH','KEY_51','KEY_55','LINEAR_HASH','LINEAR_KEY_51','LINEAR_KEY_55','RANGE','LIST','RANGE_COLUMNS','LIST_COLUMNS','AUTO','AUTO_LINEAR') COLLATE utf8mb3_bin DEFAULT NULL,
  `partition_expression` varchar(2048) COLLATE utf8mb3_bin DEFAULT NULL,
  `partition_expression_utf8` varchar(2048) COLLATE utf8mb3_bin DEFAULT NULL,
  `default_partitioning` enum('NO','YES','NUMBER') COLLATE utf8mb3_bin DEFAULT NULL,
  `subpartition_type` enum('HASH','KEY_51','KEY_55','LINEAR_HASH','LINEAR_KEY_51','LINEAR_KEY_55') COLLATE utf8mb3_bin DEFAULT NULL,
  `subpartition_expression` varchar(2048) COLLATE utf8mb3_bin DEFAULT NULL,
  `subpartition_expression_utf8` varchar(2048) COLLATE utf8mb3_bin DEFAULT NULL,
  `default_subpartitioning` enum('NO','YES','NUMBER') COLLATE utf8mb3_bin DEFAULT NULL,
  `created` timestamp NOT NULL,
  `last_altered` timestamp NOT NULL,
  `view_definition` longblob,
  `view_definition_utf8` longtext COLLATE utf8mb3_bin,
  `view_check_option` enum('NONE','LOCAL','CASCADED') COLLATE utf8mb3_bin DEFAULT NULL,
  `view_is_updatable` enum('NO','YES') COLLATE utf8mb3_bin DEFAULT NULL,
  `view_algorithm` enum('UNDEFINED','TEMPTABLE','MERGE') COLLATE utf8mb3_bin DEFAULT NULL,
  `view_security_type` enum('DEFAULT','INVOKER','DEFINER') COLLATE utf8mb3_bin DEFAULT NULL,
  `view_definer` varchar(192) COLLATE utf8mb3_bin DEFAULT NULL,
  `view_client_collation_id` bigint unsigned DEFAULT NULL,
  `view_connection_collation_id` bigint unsigned DEFAULT NULL,
  `view_column_names` longtext COLLATE utf8mb3_bin,
  `last_checked_for_upgrade_version_id` int unsigned NOT NULL,
  `engine_attribute` json DEFAULT NULL,
  `secondary_engine_attribute` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `schema_id` (`schema_id`,`name`),
  UNIQUE KEY `engine` (`engine`,`se_private_id`),
  KEY `engine_2` (`engine`),
  KEY `collation_id` (`collation_id`),
  KEY `tablespace_id` (`tablespace_id`),
  KEY `type` (`type`),
  KEY `view_client_collation_id` (`view_client_collation_id`),
  KEY `view_connection_collation_id` (`view_connection_collation_id`),
  KEY `type_2` (`type`,`view_definer`),
  CONSTRAINT `tables_ibfk_1` FOREIGN KEY (`schema_id`) REFERENCES test.dummy (`id`),
  CONSTRAINT `tables_ibfk_2` FOREIGN KEY (`collation_id`) REFERENCES test.dummy (`id`),
  CONSTRAINT `tables_ibfk_3` FOREIGN KEY (`tablespace_id`) REFERENCES test.dummy (`id`),
  CONSTRAINT `tables_ibfk_4` FOREIGN KEY (`view_client_collation_id`) REFERENCES test.dummy (`id`),
  CONSTRAINT `tables_ibfk_5` FOREIGN KEY (`view_connection_collation_id`) REFERENCES test.dummy (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin STATS_PERSISTENT=0 ROW_FORMAT=DYNAMIC;
SET foreign_key_checks= DEFAULT;

let $object_alloc= 168;
let $object_free= 0;
let $object_count= 168;
let $operation= SELECT * FROM test.tables;
DROP TABLE test.tables;

let $max_tab= `SELECT @@max_connections`;

-- First, we create the tables, bring them into the DD cache, and remove them
-- from the table definition cache.

--disable_query_log
--disable_result_log
let $i= $max_tab;
{
  dec $i;

-- Now, the DD cache should be filled with the user tables, and we should have
-- the shares for the DD tables available in the TDC, if needed. Selecting from
-- the user tables should be possible without DD cache misses.

--source include/dd_pfs_save_state.inc
--disable_query_log
--disable_result_log
let $i= $max_tab;
{
  dec $i;

-- Above, when opening the tables, the DD objects are cached, but we will
-- acquire the tablespace and tablespace file objects while preparing the
-- table share. These are also freed. This is done only once when the share
-- is filled, so on next query accessing the table, the existing table share
-- is used without any further DD object usage.

let $object_alloc= $max_tab + $max_tab;
let $object_free= $max_tab + $max_tab;
let $object_left= 0;

-- Remove the tables.

--disable_query_log
--disable_result_log
let $i= $max_tab;
{
  dec $i;
CREATE SCHEMA s;
let $i= 100;
{
  dec $i;
  -- Pull in DD objects for tables in cache.
  eval SELECT * FROM s.t_$i;

-- For each table:
--
--   We first get tablespace name referred by the index in order to acquire
--   MDL on it, allocating tablespace and file objects uncached (+2) and
--   then freeing them immediately (-2).
--
--   Then during call to drop table in SE, InnoDB will drop file-per-table
--   tablespace. To do this it will get get uncached tablespace and file
--   objects once again (+2). The placeholder for tablespace object will
--   be created and added to uncommited registry (+1), Original uncached
--   tablespace and file objects will be deleted (-2).
--
--   After that we will delete table from DD, and in the process we will
--   create placeholder for table object (+1) and keep it as uncommitted,
--   free cached table object and its subobjects (-16).
--
-- Then once for the statement, we will create placeholder for schema
-- object to keep as uncommited (+1) and free cached schema object (-1).
--
-- Finally, we will free uncommitted placeholders for each table, tablespace
-- (-2 per table) and for schema (-1).
--
-- So in total this results in (2 + 2 + 1 + 1) * 100 + 1 = 601 allocations,
-- (2 + 2 + 16) * 100 + 1 + 2 * 100 + 1 = 2202 frees, and a net change of -1601.
--source include/dd_pfs_save_state.inc
let $object_alloc= 601;
let $object_free= 2202;
let $object_count= -1601;
let $operation= DROP SCHEMA s;

--
-- Coverage for optimization of marking referencing views as invalid during
-- DROP DATABASE which was implemented as part of fixing bug#29634540 "DROP
-- DATABASE OF 1 MILLION TABLES RESULTED CRASH OF MYSQLD".
--

-- I) View in the database being dropped dependent on MyISAM table in it.
--    Optimization doesn't apply.
CREATE SCHEMA s1;
CREATE TABLE s1.t_myisam(i INT) ENGINE=MYISAM;
CREATE VIEW s1.v1 AS SELECT * FROM s1.t_myisam;
SELECT * FROM s1.v1;
--   a) We retrieve db and name of dependent view. To do this we create
--      uncached uncommitted view object (with subobjects +3) and
--      uncached uncommitted schema object (+1), which are immediately
--      released (-4).
--   b) Acquire MDL on db and name combo and retrieve them once again
--      in the same way to prevent possible races (+4, -4).
--   c) Create copy of cached view object with subobject to mark it
--      invalid (+3), store it in DD, delete new (-3) and cached object
--      (-3).
-- 3) We delete view, in the process we load view object into cache (+3),
--    create placeholder for it (+1), delete cached object (-3), remove
--    view from DD.
-- 4) We remove TABLE_SHARE entry for view from TDC. It has DD view
--    object bound to it which gets deleted (-3).
-- 5) Create placeholder object for schema (+1), delete cached schema
--    object (-1), delete schema from DD.
-- 6) Delete placeholder objects for view (-1) and schema (-1) during
--    commit.
-- So in total we do 17 allocations and 26 deletions of objects.
let $object_alloc= 17;
let $object_free= 26;
let $object_count= -9;
let $operation= DROP SCHEMA s1;

-- II) View on InnoDB table in other database than one being dropped.
--     Optimization doesn't apply either.
CREATE SCHEMA s2;
CREATE TABLE s2.t_innodb(i INT) TABLESPACE=innodb_system;
CREATE VIEW v2 AS SELECT * FROM s2.t_innodb;
SELECT * FROM v2;
--    we get their names, allocating tablespace and file objects uncached
--    twice (+4). These are then freed (-4).
-- 2) When updating the SDI, the tablespace and file objects are allocated
--    uncached again (+2) and then freed eventually (-2).
-- 3) We allocate placeholder object for table being dropped (+1) and
--    remove table object and its sub-objects from cache (-10).
--    Table is removed from DD.
-- 4) Then we mark view as invalid:
--   a) We retrieve db and name of dependent view. To do this we create
--      uncached uncommitted view object (with subobjects +3) and
--      uncached uncommitted schema object (+1), which are immediately
--      released (-4).
--   b) Acquire MDL on db and name combo and retrieve them once again
--      in the same way to prevent possible races (+4, -4).
--   c) Create copy of cached view object with subobject to mark it
--      invalid (+3), store it in DD, delete cached object (-3).
-- 5) Create placeholder object for schema (+1), delete cached schema
--    object (-1), delete schema from DD.
-- 6) Delete placeholder objects for table (-1) and schema (-1) and new
--    version of view object (-3) during commit.
--
-- So in total we do 19 allocations and 33 deletions of objects.
let $object_alloc= 19;
let $object_free= 33;
let $object_count= -14;
let $operation= DROP SCHEMA s2;
DROP VIEW v2;

-- III) View on InnoDB table in the same database as one being dropped.
--      Optimization should apply.
CREATE SCHEMA s3;
CREATE TABLE s3.t_innodb(i INT) TABLESPACE=innodb_system;
CREATE VIEW s3.v3 AS SELECT * FROM s3.t_innodb;
SELECT * FROM s3.v3;
--    we get their names, allocating tablespace and file objects uncached
--    twice (+4). These are then freed (-4).
-- 2) When updating the SDI, the tablespace and file objects are allocated
--    uncached again (+2) and then freed eventually (-2).
-- 3) We allocate placeholder object for table being dropped (+1) and
--    remove table object and its sub-objects from cache (-10).
--    Table is removed from DD.
-- 4) Then we consider whether we need to mark view as invalid:
--   a) We retrieve db and name of dependent view. To do this we create
--      uncached uncommitted view object (with subobjects +3) and
--      uncached uncommitted schema object (+1), which are immediately
--      released (-4).
--   b) Since view belongs to the database being dropped we ignore it.
-- 5) Create placeholder object for view (+1), delete cached objects
--    for it from the cache (-3), remove it from DD.
-- 6) We remove TABLE_SHARE entry for view from TDC. It has DD view
--    object bound to it which gets deleted (-3).
-- 7) Create placeholder object for schema (+1), delete cached schema
--    object (-1), delete schema from DD.
-- 8) Delete placeholder objects for table (-1), view (-1) and schema (-1)
--    during commit.
--
-- So in total we do 13 allocations and 27 deletions of objects.
let $object_alloc= 13;
let $object_free= 30;
let $object_count= -17;
let $operation= DROP SCHEMA s3;

-- IV) View on view in the same database as one being dropped.
--     Optimization should apply as well.
CREATE SCHEMA s4;
CREATE VIEW s4.v4 AS SELECT 1 AS i;
CREATE VIEW s4.v5 AS SELECT * FROM s4.v4;
SELECT * FROM s4.v5;
--    and remove view object and its sub-objects from cache (-2).
--    View is removed from DD.
-- 2) We remove TABLE_SHARE entry for view from TDC. Associated DD
--    object is deleted (-2).
-- 3) Then we consider whether we need to mark the dependent view
--    as invalid:
--   a) We retrieve db and name of dependent view. To do this we create
--      uncached uncommitted view object (with subobjects +3) and
--      uncached uncommitted schema object (+1), which are immediately
--      released (-4).
--   b) Since view belongs to the database being dropped we ignore it.
-- 4) Create placeholder object for second view (+1), delete cached
--    object for it from the cache (-3), remove it from DD.
-- 5) We remove TABLE_SHARE entry for view from TDC. It has DD view
--    object bound to it which gets deleted (-3).
-- 6) Create placeholder object for schema (+1), delete cached schema
--    object (-1), delete schema from DD.
-- 7) Delete placeholder objects for the first (-1) and the second (-1)
--    views and schema (-1) during commit.
--
-- So in total we do 7 allocations and 18 deletions of objects.
let $object_alloc= 7;
let $object_free= 18;
let $object_count= -11;
let $operation= DROP SCHEMA s4;
