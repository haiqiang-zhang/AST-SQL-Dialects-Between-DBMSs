
--
-- this test uses the debug mode where we pipe all error logging
-- to stderr, so log_sink_test (square brackets) and log_sink_json
-- (curly braces) are interleaved below.  log_components_split
-- tests the "production setup" where different formats go to
-- different files.
--

--source include/have_debug.inc
--source include/have_log_component.inc
--source include/xplugin_wait_for_interfaces.inc

let GREP_START=`SELECT DATE_FORMAT(CONVERT_TZ(SYSDATE(6),'SYSTEM','UTC'),'%Y%m%d%H%i%s%f');

SET @orig_log_error_verbosity= @@GLOBAL.log_error_verbosity;
SET @@global.log_error_verbosity=3;

let $log_error_= `SELECT @@GLOBAL.log_error`;
{
  let $log_error_ = $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Send parse-trace to error log;
SET @@session.debug="+d,parser_stmt_to_error_log";
SET @@session.debug="+d,log_error_normalize";

SELECT @@global.log_error_services;

--# WL#9651
-- SET @@global.log_error_filter_rules='+source_line? delete_field. +thread? delete_field. +user? delete_field. +host? delete_field. +query_id? delete_field. +time? delete_field. +_pid? delete_field. +_platform? delete_field. +_client_version? delete_field. +_os? delete_field. +err_code? delete_field.';

SELECT "*** SWITCHING ERROR LOG TO JSON ***";
SET @@global.log_error_services="log_filter_internal;
SET @@global.log_error_services=";
SET @@global.log_error_services="log_sink_internal;
SET @@global.log_error_services="log_filter_internal;
SET @@global.log_error_services="log_filter_internal log_sink_internal";
SET @@global.log_error_services="azundris";
SET @@global.log_error_services="log_sink_buffer";

SELECT "logging as JSON";
SET @@global.log_error_services="log_filter_internal, log_sink_internal,";

SELECT "*** SWITCHING ERROR LOG TO TRAD AND JSON ***";
SET @@global.log_error_services="log_filter_internal, log_sink_internal, log_sink_json";
SELECT "logging as traditional MySQL error log and as JSON";
SET @@global.log_error_services="log_filter_internal;



SELECT "*** TRYING TO LOG THINGS FROM EXTERNAL SERVICE ***";
SET @@global.log_error_services="log_filter_internal;
SELECT "logging as traditional MySQL error log and as JSON";
SET @@global.log_error_filter_rules= DEFAULT;
SET @@global.log_error_services="log_filter_internal;
SET @@session.debug="-d,parser_stmt_to_error_log";
SET @@session.debug="-d,log_error_normalize";
SET @@global.log_error_verbosity= @orig_log_error_verbosity;
--# WL#9651
-- SET @@global.log_error_filter_rules=@save_filters;

let GREP_FILE=$log_error_;
   use strict;
   use File::stat;
   my $file= $ENV{'GREP_FILE'} or die("grep file not set");
   my $pattern="^20";
   my $stime= $ENV{'GREP_START'};

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     my $ts = 0;

     if ($stime == 0) {
       print "$line";
     }
     elsif (($line =~ /$pattern/) and not ($line =~ /redo log/)) {
       $line =~ /([0-9][0-9][0-9][0-9])-([0-9][0-9])-([0-9][0-9])T([0-9][0-9]):([0-9][0-9]):([0-9][0-9])\.([0-9][0-9][0-9][0-9][0-9][0-9])[-+Z][0-9:]* *[0-9]* *?(\[.*)/;
       $ts=$1.$2.$3.$4.$5.$6.$7;
       if ($ts >= $stime) {
         $stime= 0;
       }
     }
   }
   close(FILE);
