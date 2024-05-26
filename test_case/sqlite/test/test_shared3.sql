select count(*) from sqlite_master;
BEGIN;
PRAGMA incremental_vacuum;
