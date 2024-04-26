
-- Some of the changes implemented by WL#14793 are demonstrated elsewhere,
-- either explicitly by new test coverage, or implicitly by the updates to
-- existing tests that aligns them with the new behavior:
--
-- FR-1.1: see log_options_cmdline, "WL#14793 FR-1" (section 4.2)
-- This test sets log_error_services on the command-line at server start-up
-- without first adding them to the server using INSTALL COMPONENT. This used
-- to fail (because of the requested components not being present);


-- In debug mode, we can echo statements to the error log.
--source include/have_debug.inc
-- Without logging components, this is a pointless exercise.
-- --source include/have_log_component.inc
-- Make sure nobody else logs to performance_schema.error_log.
--source include/not_parallel.inc

SET @@session.time_zone=@@global.log_timestamps;
SELECT FROM_UNIXTIME(VARIABLE_VALUE/1000000)
  INTO @pfs_errlog_latest
  FROM performance_schema.global_status
 WHERE VARIABLE_NAME LIKE "Error_log_latest_write";
SELECT component_urn FROM mysql.component;
SET @@global.log_error_services="log_sink_json";
SET @@session.debug="+d,parser_stmt_to_error_log_with_system_prio";
SET @@session.debug="-d,parser_stmt_to_error_log_with_system_prio";
SELECT prio,error_code,subsystem,
       JSON_EXTRACT(data,'$.err_symbol'),JSON_EXTRACT(data,'$.msg')
  FROM performance_schema.error_log
 WHERE logged>@pfs_errlog_latest
   AND LEFT(data,1)='{'
   AND JSON_EXTRACT(data,'$.err_symbol')="ER_PARSER_TRACE"
 ORDER BY logged;
SELECT @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN drop.';
SELECT component_urn FROM mysql.component;
SELECT component_urn FROM mysql.component;
SELECT @@global.log_error_services;
SELECT @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN drop.';
SELECT component_urn FROM mysql.component;
SELECT @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN drop.';
SET @@global.log_error_services="log_filter_dragnet;
SELECT @@global.dragnet.log_error_filter_rules;
SET @@global.dragnet.log_error_filter_rules='IF err_symbol=="ER_STARTUP" THEN drop.';
SET @@global.log_error_services=DEFAULT;
SELECT @@global.log_error_services;
SELECT @@global.dragnet.log_error_filter_rules;
