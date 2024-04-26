
-- We'll be looking at the contents of the slow log later, and PS protocol
-- would give us extra lines for the prepare and drop phases.
--source include/no_ps_protocol.inc
--source include/not_valgrind.inc

SET @save_sqlf=@@global.slow_query_log_file;

SET timestamp=10;
SELECT unix_timestamp(), sleep(2);

let SLOW_LOG1= `SELECT @@global.slow_query_log_file`;
   use strict;

   my $file= $ENV{'SLOW_LOG1'} or die("slow log not set");
   my $result=0;

   open(FILE, "$file") or die("Unable to open $file: $!");
     my $line = $_;
     $result++ if ($line =~ /SET timestamp=10;
     $result++ if ($line =~ /Start: 1970-01-01T00:00:10.000000Z /);
   }
   close(FILE);

   if($result != 2) {
     print "[ FAIL ] timestamp not found\n";
   }
   else {
     print "[ PASS ] timestamp found\n";
   }

EOF

SET @@global.slow_query_log_file=@save_sqlf;

--
-- Confirm that per-query stats work.
--

SET @save_sqlf=@@global.slow_query_log_file;

let SLOW_LOG2= `SELECT @@global.slow_query_log_file`;

SET GLOBAL long_query_time=0;
DROP TABLE IF EXISTS islow;

CREATE TABLE islow(i INT) ENGINE=innodb;
INSERT INTO islow VALUES (1), (2), (3), (4), (5), (6), (7), (8);

SELECT * FROM islow;
SELECT * FROM islow;

-- make sure we don't log disconnect even when running in valgrind
SET GLOBAL slow_query_log=0;

SET GLOBAL long_query_time=1;

DROP TABLE islow;
  if ($line =~ m/^-- Query_time/) {
    $line =~ s/Thread_id: \d* Errno:/Thread_id: 0 Errno:/;
    $line =~ m/(Rows_sent.*) Start.*/;
    print "$1\n";
  }
}
EOF

SET @@global.slow_query_log_file=@save_sqlf;
SET GLOBAL slow_query_log=1;

SET @save_sqlf=@@global.slow_query_log_file;

let SLOW_LOG3= `SELECT @@global.slow_query_log_file`;

-- Can also use SET SESSION, but NOT SET GLOBAL, as the check is not done
-- against the global variable.
SET long_query_time=0;
CREATE TABLE b(id INT NOT NULL AUTO_INCREMENT);
  if (/Errno: (\d+)/)  { print "-- Found Errno: $1 in slow log\n";
EOF

SET @@global.slow_query_log_file=@save_sqlf;
SET GLOBAL slow_query_log=1;
