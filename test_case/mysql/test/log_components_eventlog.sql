
let GREP_START=`SELECT DATE_FORMAT(CONVERT_TZ(SYSDATE(6),'SYSTEM','UTC'),'%Y%m%d%H%i%s%f');

SET @@global.log_error_verbosity=3;

let $log_error_= `SELECT @@GLOBAL.log_error`;
{
  let $log_error_ = $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Send parse-trace to error log;
SET @@session.debug="+d,parser_stmt_to_error_log";
SET @@session.debug="+d,log_error_normalize";

-- Log parser statement with System label too.
SET @@session.debug="+d,parser_stmt_to_error_log_with_system_prio";

SELECT @@global.log_error_services;

-- Component not loaded, variable not present
--error ER_UNKNOWN_SYSTEM_VARIABLE
SELECT @@syseventlog.tag;

SELECT "*** SWITCHING ERROR LOG TO SYSEVENTLOG ***";
SELECT @@global.syseventlog.tag;
SET @@global.syseventlog.tag="wl9343";
SELECT @@global.syseventlog.tag;

SET @@global.log_error_services="log_filter_internal;
SELECT "logging to syslog";
SET @@global.syseventlog.tag="wl9343_2";
SELECT @@global.syseventlog.tag;

SET @@global.log_error_services="log_filter_internal;
SET @@global.syseventlog.tag=DEFAULT;
SELECT @@global.syseventlog.tag;
SET GLOBAL syseventlog.include_pid = OFF;
SET GLOBAL syseventlog.facility = "local1";

-- Check that SET PERSIST retains variable values
-- ---------------------------------------------------------
SET PERSIST syseventlog.tag = "wl11828";

-- Now that we've shown explicit loading with INSTALL above, we'll UNINSTALL
-- use implicit loading from the command-line.
SET @@global.log_error_services=DEFAULT;

-- Verify value of the persisted variable
SELECT @@syseventlog.tag;


-- Verify that we accept arguments passed at start-up

--let $log_services="log_filter_internal;

-- Verify value of the persisted variable
SELECT @@syseventlog.tag;

-- Verify that we use default settings if invalid arguments are passed
-- at start-up

--let $log_services="log_filter_internal;

-- Verify value of the persisted variable
SELECT @@syseventlog.tag;

-- Cleanup
SET GLOBAL log_error_services= default;

SET @@session.debug="-d,parser_stmt_to_error_log_with_system_prio";
SET @@session.debug="-d,parser_stmt_to_error_log";
SET @@session.debug="-d,log_error_normalize";
--# WL#9651
-- SET @@global.log_error_filter_rules=@save_filters;

let $restart_parameters = restart:;
