
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

-- Component is not present, INSTALL should succeed
SELECT "*** SWITCHING ERROR LOG TO SYSEVENTLOG ***";
SELECT @@global.syseventlog.tag;
SET @@global.syseventlog.tag="wl9343";
SELECT @@global.syseventlog.tag;
SET @@global.log_error_services="log_sink_syseventlog";
SELECT "log_sink_syseventlog-mark";
SELECT error_code, data
  FROM performance_schema.error_log
 WHERE DATA LIKE "%log_sink_syseventlog-mark%" LIMIT 1;

SET @@global.log_error_services="log_filter_internal;
SELECT "logging to syslog";
SET @@global.syseventlog.tag="wl9343_2";
SELECT @@global.syseventlog.tag;

SET @@global.log_error_services="log_filter_internal;
SET @@global.syseventlog.tag=DEFAULT;
SELECT @@global.syseventlog.tag;


-- Check that SET PERSIST retains variable values
-- ---------------------------------------------------------
SET PERSIST syseventlog.include_pid = OFF;
SET PERSIST syseventlog.facility = "local1";
SET PERSIST syseventlog.tag = "wl11828";

-- We uninstall the component we explicitly installed above so we can use
-- implicitly loading from the command-line below without the server
-- complaining that we're mixing both.
UNINSTALL COMPONENT "file://component_log_sink_syseventlog";

-- Verify value of the persisted variable
SELECT @@syseventlog.include_pid;
SELECT @@syseventlog.facility;
SELECT @@syseventlog.tag;


-- Verify that we accept arguments passed at start-up

--let $log_services="log_filter_internal;

-- Verify value of the persisted variable
SELECT @@syseventlog.include_pid;
SELECT @@syseventlog.facility;
SELECT @@syseventlog.tag;

-- Verify that we use default settings if invalid arguments are passed
-- at start-up

--let LOG_FILE= $MYSQLTEST_VARDIR/tmp/wl11828.err
--let $log_services="log_filter_internal;

-- Verify value of the persisted variable
SELECT @@syseventlog.include_pid;
SELECT @@syseventlog.facility;
SELECT @@syseventlog.tag;

-- Cleanup
SET GLOBAL log_error_services= default;

-- Implicitly load the component.
SET GLOBAL log_error_services= "log_filter_internal;
SET GLOBAL log_error_services= default;

SET @@session.debug="-d,parser_stmt_to_error_log_with_system_prio";
SET @@session.debug="-d,parser_stmt_to_error_log";
SET @@session.debug="-d,log_error_normalize";
--# WL#9651
-- SET @@global.log_error_filter_rules=@save_filters;
   use strict;
   use JSON;

   my $file= $ENV{'LOG_FILE'} or die("logfile not set");
   my $result=0;

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;

     if ($line =~ /syseventlog\./) {
       $line =~ s/.*\]//;
       print $line;
     }
   }
   close(FILE);
