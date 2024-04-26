
SET @my_slow_query_log_file = @@GLOBAL.slow_query_log_file;
SET @my_slow_query_log = @@GLOBAL.slow_query_log;
SET GLOBAL slow_query_log_file = "mysqldump_long_query_time-slow.log";
SET GLOBAL slow_query_log = ON;

CREATE DATABASE mysqldump_long_query_time;
USE mysqldump_long_query_time;

let MYSQLD_DATADIR = `SELECT @@datadir`;
  if ($line =~ /^select/) {
    print $line;
  }
}
close FILE
EOF

--echo
--echo --# TEST 2: mysqldump with custom flag omitted, global set to 0

-- Set to 0 globally, to test with omitted flag.
SET @my_long_query_time = @@GLOBAL.long_query_time;
SET GLOBAL long_query_time = 0;

CREATE TABLE t1 (i int, c char(255));

INSERT INTO t1 VALUES (0, lpad('a', 250, 'b'));
INSERT INTO t1 SELECT i+1,c FROM t1;
INSERT INTO t1 SELECT i+2,c FROM t1;
INSERT INTO t1 SELECT i+4,c FROM t1;
INSERT INTO t1 SELECT i+8,c FROM t1;
INSERT INTO t1 SELECT i+16,c FROM t1;

-- omitting long_query_time flag means using the server value.
--exec $MYSQL_DUMP mysqldump_long_query_time > /dev/null

--echo -- Check the slow log result. One "select" query should be found.
--perl
open FILE, "$ENV{'MYSQLD_DATADIR'}/mysqldump_long_query_time-slow.log" or die;
  if ($line =~ /^select/) {
    print $line;
  }
}
close FILE
EOF

--echo
--echo --# TEST 3: mysqldump with custom flag set to 0, global set to default

-- Restore default global value before testing flag = 0
SET @@GLOBAL.long_query_time = @my_long_query_time;
  if ($line =~ /^select/) {
    print $line;
  }
}
close FILE
EOF

--echo
--echo -- Cleanup
remove_file $MYSQLD_DATADIR/mysqldump_long_query_time-slow.log;

DROP DATABASE mysqldump_long_query_time;

SET @@GLOBAL.slow_query_log_file = @my_slow_query_log_file;
SET @@GLOBAL.slow_query_log = @my_slow_query_log;
SET @@GLOBAL.long_query_time = @my_long_query_time;
