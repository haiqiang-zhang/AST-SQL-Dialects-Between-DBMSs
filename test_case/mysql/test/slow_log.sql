
-- We'll be using a long_query_time of 0 below, logging everything.
-- This means that in normal mode, we'll get one log line for each
-- statement when we use COM_QUERY, but two when we use --ps-protocol
-- (and thus, COM_STMT_PREPARE/COM_STMT_EXECUTE pairs). This normally
-- skews test results. Therefore, we assign a divisor here
-- (1 for normal mode, 2 for ps protocol) by which we divide the
-- row-counts of our results. The trick is to take counts of both
-- the log-rows that have obfuscated passwords in them, and those
-- that have unobfuscated passwords in them. That way we can show
-- both that password-containing lines are logged at all, *and*
-- that they don't contain sensitive data.
--
-- We could of course modify the server to never slow-log when
-- thd->get_command() == COM_STMT_PREPRARE, but this wouldn't solve
-- the same issue for the general log, and since the general log is
-- expected to reflect all incoming requests, we shouldn't introduce
-- such server-side filtering there. That said, the general_log offers
-- us the command_type field, so the test itself could filter on
--   AND command_type!="Prepare"
-- allowing through "Query" and "Execute" type rows and resulting in
-- a correct row count either way.
--
-- The thing however is that since we have the opportunity to, we
-- should look at all the rows we can get (so we don't end up
-- filtering out lines that wrongfully have unobfuscated passwords
-- in them).
let IS_PS=`SELECT $PS_PROTOCOL=1`;

-- Additionally, KILL ... will fail with --cursor-protocol.
--source include/no_cursor_protocol.inc

SET @save_sqlf=@@global.slow_query_log_file;

SET timestamp=10;
SELECT unix_timestamp(), sleep(2);

let SLOW_LOG= `SELECT @@global.slow_query_log_file`;
   use strict;

   my $file= $ENV{'SLOW_LOG'} or die("slow log not set");
   my $result=0;

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     $result++ if ($line =~ /SET timestamp=10;
   }
   close(FILE);

   if($result != 1) {
     print "[ FAIL ] timestamp not found\n";
   }
   else {
     print "[ PASS ] timestamp found\n";
   }

EOF

SET @@global.slow_query_log_file=@save_sqlf;

SET @old_slow_query_log_file= @@global.slow_query_log_file;
SET @old_log_output         = @@global.log_output;

-- SET timestamp=10;
SET @main_thd_id=CONNECTION_ID();

-- Set slow log output to table
SET GLOBAL log_output=        'TABLE,FILE';
SET GLOBAL slow_query_log=    1;

SET SESSION long_query_time=  0;
SET SESSION long_query_time= 0;
SELECT @@log_output,@@slow_query_log,@@long_query_time;

-- Wait in 'before_do_command_net_read' until killed.
--send /* KILL CONNECTION: should not be logged */ SELECT SLEEP(1001)

--echo -- default connection (from whence we use KILL CONNECTION)
--connection default
let $wait_condition= SELECT COUNT(processlist_info) FROM performance_schema.threads WHERE processlist_state="User sleep";
SELECT "Connx" AS kill_type,
       IF(thread_id=@main_thd_id,"KILLER","killee") AS thread,
       sql_text AS query
  FROM mysql.slow_log
 WHERE INSTR(sql_text,"SLEEP(10")>0
 ORDER BY start_time;
SET SESSION long_query_time= 0;
SELECT @@log_output,@@slow_query_log,@@long_query_time;

-- Wait in 'before_do_command_net_read' until killed.
--send /* KILL QUERY: should be logged */ SELECT SLEEP(1002)

-- --echo # default connection (from whence we use KILL QUERY)
--connection default
let $wait_condition= SELECT COUNT(processlist_info) FROM performance_schema.threads WHERE processlist_state="User sleep" AND processlist_info LIKE "%KILL QUERY: should be logged%";

-- Wait for the query to hit the log (guard against race condition).
let $wait_condition= SELECT COUNT(sql_text)=1 FROM mysql.slow_log WHERE sql_text LIKE "% KILL QUERY: should be logged %";
SELECT "Query" AS kill_type,
       IF(thread_id=@main_thd_id,"KILLER","killee") AS thread,
       sql_text AS query
  FROM mysql.slow_log
 WHERE INSTR(sql_text,"SLEEP(10")>0
 ORDER BY start_time;

-- show that the connection's gone:
--connection con1
--reap
SELECT "con1 is still here.";

-- clean up
--disconnect con1

--connection default

-- show file log:
let SLOW_LOG= `SELECT @@global.slow_query_log_file`;
   use strict;

   my $file= $ENV{'SLOW_LOG'} or die("slow log not set");

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     if ($line =~ /SELECT SLEEP\(10/) {
       print "F>".$line;
   }
   close(FILE);
EOF

SET @@global.slow_query_log_file= @old_slow_query_log_file;
SET @@global.log_output         = @old_log_output;

SET @save_sqlf=@@global.slow_query_log_file;
SET @save_sql=@@global.slow_query_log;
SET @save_lo=@@global.log_output;
SET @save_lqt=@@session.long_query_time;
SET @@global.slow_query_log=1;
SET @@global.log_output='file,table';
SET @@session.long_query_time=0;

let SLOW_LOG= `SELECT @@global.slow_query_log_file`;

SET @my_start=CURRENT_TIMESTAMP(6);
CREATE USER 'duplicate_user'@'%' IDENTIFIED BY 'mypassword';
CREATE USER 'duplicate_user'@'%' IDENTIFIED BY 'mypassword';
CREATE USER ‘bad_characters’@’%’ IDENTIFIED BY 'mypassword';
SELECT COUNT(argument)/@protdiv
  FROM mysql.general_log
 WHERE INSTR(argument,"CREATE USER")=1
   AND INSTR(argument," IDENTIFIED BY <secret>")>0
   AND event_time>=@my_start
 ORDER BY event_time;

SELECT COUNT(argument)/@protdiv
  FROM mysql.general_log
 WHERE INSTR(argument,"CREATE USER")=1
   AND INSTR(argument," IDENTIFIED BY <secret>")=0
   AND event_time>=@my_start
 ORDER BY event_time;
SELECT COUNT(sql_text)/@protdiv
  FROM mysql.slow_log
 WHERE INSTR(sql_text,"CREATE USER")=1
   AND INSTR(sql_text," IDENTIFIED BY <secret>")>0
   AND start_time>=@my_start
 ORDER BY start_time;

SELECT COUNT(sql_text)/@protdiv
  FROM mysql.slow_log
 WHERE INSTR(sql_text,"CREATE USER")=1
   AND INSTR(sql_text," IDENTIFIED BY <secret>")=0
   AND start_time>=@my_start
 ORDER BY start_time;

SET @@global.slow_query_log_file=@save_sqlf;
SET @@global.slow_query_log=@save_sql;
SET @@global.log_output=@save_lo;
SET @@session.long_query_time=@save_lqt;

DROP USER 'duplicate_user'@'%';
   use strict;

   my $obfs = 0;
   my $nono = 0;
   my $file= $ENV{'SLOW_LOG'} or die("slow log not set");
   my $protdiv= $ENV{'IS_PS'}+1;

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     $obfs++ if(($line =~ /CREATE USER /)&& ($line =~ / IDENTIFIED BY <secret>/));
     $nono++ if(($line =~ /CREATE USER /)&&!($line =~ / IDENTIFIED BY <secret>/));
   }
   print "slow file     obfuscated statements>".($obfs/$protdiv)."\n";
EOF

--remove_file $MYSQL_TMP_DIR/slow33732907.log
TRUNCATE mysql.slow_log;
