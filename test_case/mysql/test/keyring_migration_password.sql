
-- Checking if perl Expect module is installed on the system.
-- If not, the test will be skipped.
--source include/have_expect.inc
--source include/not_windows.inc

--echo --
--echo -- Bug#33619511: MySQL server exits in debug build when -p parameter used
--echo --

-- No $ sign before the name to make it visible in Perl code below
--let MYSQLD_ARGS = --datadir=$MYSQLD_DATADIR --secure-file-priv="" -p
--let MYSQLD_LOG = $MYSQL_TMP_DIR/bug33619511_log.txt

-- Start a custom mysqld instance and interactively fill up the dummy password.
-- Server should exit with "[Server] Aborting"
--perl

use strict;

-- 1. Start the server
-- The server should enter password prompt, we'll type a password 'a'.
-- Use "log_stdout(0)" to avoid leaking output to record file because it contains timestamps and custom paths.
my $texp = new Expect();
    $texp->send("a\n");
