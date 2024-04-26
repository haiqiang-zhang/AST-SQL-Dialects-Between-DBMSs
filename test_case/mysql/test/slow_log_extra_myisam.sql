
-- We'll be looking at the contents of the slow log later, and PS protocol
-- would give us extra lines for the prepare and drop phases.
--source include/no_ps_protocol.inc

--
-- Confirm that per-query stats work.
--

SET @save_sqlf=@@global.slow_query_log_file;

let SLOW_LOG2= `SELECT @@global.slow_query_log_file`;

SET GLOBAL long_query_time=0;
DROP TABLE IF EXISTS islow;
DROP TABLE IF EXISTS mslow;

CREATE TABLE islow(i INT) ENGINE=innodb;
INSERT INTO islow VALUES (1), (2), (3), (4), (5), (6), (7), (8);

CREATE TABLE mslow(i INT) ENGINE=myisam;
INSERT INTO mslow VALUES (1), (2), (3), (4), (5), (6), (7), (8);

SELECT * FROM islow;
SELECT * FROM islow;

SELECT * FROM mslow;
SELECT * FROM mslow;

-- make sure we don't log disconnect even when running in valgrind
SET GLOBAL slow_query_log=0;

SET GLOBAL long_query_time=1;

DROP TABLE islow;
DROP TABLE mslow;
  if ($line =~ m/^-- Query_time/) {
    $line =~ s/Thread_id: \d* Errno:/Thread_id: 0 Errno:/;
    $line =~ m/(Rows_sent.*) Start.*/;
    print "$1\n";
  }
}
EOF

SET @@global.slow_query_log_file=@save_sqlf;
SET GLOBAL slow_query_log=1;
