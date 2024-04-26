
--
-- this test uses the debug mode where we pipe all error logging
-- to stderr, so log_sink_internal (traditional mysql log) and
-- log_sink_json (curly braces) are interleaved below.
-- log_components_split tests the "production setup" where different
-- formats go to different files.
--

--source include/have_debug.inc
--source include/have_log_component.inc

let GREP_START=`SELECT DATE_FORMAT(CONVERT_TZ(SYSDATE(6),'SYSTEM','UTC'),'%Y%m%d%H%i%s%f');

SET @old_log_error_verbosity = @@global.log_error_verbosity;
SET @@global.log_error_verbosity=3;

let $log_error_= `SELECT @@GLOBAL.log_error`;
{
  let $log_error_ = $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Send parse-trace to error log;
SET @@session.debug="+d,parser_stmt_to_error_log";
SET @@session.debug="+d,log_error_normalize";

SELECT @@global.log_error_services;


-- double filtering should not break traditional stream
-- (we're only using rules here that should be "neutral", i.e. no
-- add/delete item, no relative prio, etc.)
INSTALL COMPONENT "file://component_log_sink_json";
SET GLOBAL log_error_services= "log_filter_internal;
SET GLOBAL log_error_services= "log_filter_internal;
SELECT "Let's do the double dutch!";
SET GLOBAL log_error_services= "log_sink_internal;
SET GLOBAL log_error_services= "log_sink_json;
SELECT "Jacob Toot-Toot";
SET GLOBAL log_error_services= DEFAULT;


-- show only errors
SET GLOBAL log_error_verbosity= 1;
SELECT "I should NOT be visible in the error log!";
SET GLOBAL log_error_services= "log_sink_internal";
SELECT "I SHOULD be visible in the error log!";
SET GLOBAL log_error_services= DEFAULT;

-- Check system level error logs. System level logs should be logged even with
-- verbosity=1.
SET @@session.debug="+d,parser_stmt_to_error_log_with_system_prio";
SELECT "I should be visible with \"System\" label!";
SET @@session.debug="-d,parser_stmt_to_error_log_with_system_prio";

SET GLOBAL log_error_verbosity= DEFAULT;
SET @@session.debug="-d,parser_stmt_to_error_log";
SET @@session.debug="-d,log_error_normalize";
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
       $line =~ s/"source_line" : \d+, //;
       $line =~ s/"err_code" : \d+, //;
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
EOF

SET @@global.log_error_verbosity=@old_log_error_verbosity;
