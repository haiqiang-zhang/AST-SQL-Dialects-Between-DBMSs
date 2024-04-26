--  1) binlog_format=STATEMENT
--  2) binlog_row_image=FULL
--  3) the binlog is disabled
--
-- ==== Related Worklog ====
--
-- WL#2955 RBR replication of partial JSON updates
--

--source include/force_restart.inc

call mtr.add_suppression("When binlog_format=STATEMENT, the option binlog_row_value_options=PARTIAL_JSON");

SET @@GLOBAL.BINLOG_ROW_VALUE_OPTIONS= PARTIAL_JSON;

SET @@GLOBAL.BINLOG_ROW_VALUE_OPTIONS= PARTIAL_JSON;

SET @@GLOBAL.BINLOG_ROW_VALUE_OPTIONS= PARTIAL_JSON;
