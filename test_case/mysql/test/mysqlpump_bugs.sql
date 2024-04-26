EOF

CREATE DATABASE db1;
CREATE DATABASE db2;

DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db2;

CREATE DATABASE B32067013;
CREATE TABLE B32067013.t1(v1 INT, v2 INT);
CREATE TABLE B32067013.t2(v1 INT, v2 INT);
CREATE VIEW B32067013.t123 AS SELECT * FROM B32067013.t1;
DROP TABLE B32067013.t1;
DROP DATABASE B32067013;

-- TODO: Remove if the below CREATE TABLE doesn't garble the FRM file
--disable_query_log
CALL mtr.add_suppression("Incorrect information in file");


SET sql_mode ='';
CREATE DATABASE B32340208;
CREATE TABLE B32340208.test (
  `pk` int NOT NULL AUTO_INCREMENT,
  `a1` smallint GENERATED ALWAYS AS (((0 <> `c1`) and (_utf8mb4'0000-00-00
00:00:00' <> `d1`))) VIRTUAL NOT SECONDARY,
  `b1` char(8) DEFAULT NULL,
  `c1` longblob NOT NULL NOT SECONDARY,
  `d1` timestamp NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `functional_index` ((radians(`c1`))) USING BTREE COMMENT 'you''re'
) ENGINE=InnoDB DEFAULT CHARSET=euckr;
DROP DATABASE B32340208;
SET sql_mode = DEFAULT;

-- echo --
-- echo -- Bug #33688141 mysqlpump exits in regards to 'std::logic_error'
-- echo --

-- Write configuration with password not specified
--write_file $MYSQLTEST_VARDIR/tmp/bug33688141.cnf
[mysqlpump]
exclude_databases=db1,mysql,mtr
EOF

-- No $ sign before the name to make it visible in Perl code below
--let MYSQLPUMP_ARGS = --defaults-file=$MYSQLTEST_VARDIR/tmp/bug33688141.cnf -uroot -p
--let MYSQLPUMP_LOG = $MYSQL_TMP_DIR/bug33688141.txt

-- Start a mysqlpump and interactively fill up the dummy password.
-- Mysqlpump should exit cleanly with "Dump process encountered error and will not continue."
--perl
use strict;

-- Start the mysqlpump client
-- The client should enter password prompt, we'll type a password 'a'.
-- Use "log_stdout(0)" to avoid leaking output to record file because it may contain timestamps and custom paths.
my $texp = new Expect();
    $texp->send("a\n");
