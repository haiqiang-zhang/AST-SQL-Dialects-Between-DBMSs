--                                                                             #
--  Debug Test cases to verify storing view column information in DD.COLUMNS   #
--  table and update view column information and other values on DDL           #
--  operations.                                                                #
--                                                                             #
--##############################################################################

--source include/have_debug.inc
--source include/have_debug_sync.inc

--source include/count_sessions.inc

--enable_connect_log

--echo --
--echo -- Bug#26322203 - SHOW FIELDS FROM A VALID VIEW FAILS WITH AN INVALID VIEW ERROR
--echo --

CREATE TABLE t1 (f1 int);
CREATE VIEW v1 AS SELECT * FROM t1;
SET DEBUG_SYNC="after_preparing_view_tables_list SIGNAL alter_view WAIT_FOR go";
SET DEBUG_SYNC='now WAIT_FOR alter_view';
ALTER VIEW v1 AS select 13;
SET DEBUG_SYNC='now SIGNAL go';
SET DEBUG_SYNC='RESET';
DROP VIEW v1;
