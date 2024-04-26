--    server already running.
--##########################################################################

--let $BUGDIR=           $MYSQL_TMP_DIR/help_verbose_tc1
--let $LOG_FILE =        $BUGDIR/mysqld.log
--let $TEST_DATADIR=     `select @@datadir`

--mkdir $BUGDIR

--exec $MYSQLD --no-defaults --help --verbose --datadir=$TEST_DATADIR --lc-messages-dir=$MESSAGES_DIR --secure-file-priv="" $KEYRING_PLUGIN_OPT > $LOG_FILE 2>&1

--echo -- There should be no errors
--let SEARCH_FILE=    $LOG_FILE
--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

-- Cleanup
--remove_files_wildcard $BUGDIR *
--rmdir $BUGDIR

--##########################################################################
-- 2. Run --help --verbose and skip-log-bin on an existing but
--    empty datadir.
--##########################################################################

--let $BUGDIR=           $MYSQL_TMP_DIR/help_verbose_tc2
--let $LOG_FILE =        $BUGDIR/mysqld.log
--let $TEST_DATADIR=     $BUGDIR/data

--mkdir $BUGDIR
--mkdir $TEST_DATADIR

--exec $MYSQLD --no-defaults --help --verbose --datadir=$TEST_DATADIR --lc-messages-dir=$MESSAGES_DIR  --secure-file-priv="" $KEYRING_PLUGIN_OPT --loose-skip-log-bin > $LOG_FILE 2>&1

--echo -- There should be no errors
--let SEARCH_FILE=    $LOG_FILE
--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

--echo -- There should be no leftovers in the datadir.
--list_files $TEST_DATADIR

-- Cleanup
--remove_files_wildcard $BUGDIR *
--rmdir $TEST_DATADIR
--rmdir $BUGDIR

--##########################################################################
-- 3. Run --help --verbose on a non-existing datadir.
--##########################################################################

--let $BUGDIR=           $MYSQL_TMP_DIR/help_verbose_tc3
--let $LOG_FILE =        $BUGDIR/mysqld.log
--let $TEST_DATADIR=     $BUGDIR/data

--mkdir $BUGDIR

--exec $MYSQLD --no-defaults --help --verbose --datadir=$TEST_DATADIR --lc-messages-dir=$MESSAGES_DIR  --secure-file-priv="" $KEYRING_PLUGIN_OPT > $LOG_FILE 2>&1

--echo -- There should be no errors
--let SEARCH_FILE=    $LOG_FILE
--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

-- Cleanup
--remove_files_wildcard $BUGDIR *
--rmdir $BUGDIR

--##########################################################################
-- 4. Run --help --verbose and --log-bin on an existing but empty datadir.
--##########################################################################

--let $BUGDIR=           $MYSQL_TMP_DIR/help_verbose_tc4
--let $LOG_FILE =        $BUGDIR/mysqld.log
--let $TEST_DATADIR=     $BUGDIR/data

--mkdir $BUGDIR
--mkdir $TEST_DATADIR

--exec $MYSQLD --no-defaults --help --verbose --log-bin --server-id=1 --datadir=$TEST_DATADIR --lc-messages-dir=$MESSAGES_DIR  --secure-file-priv="" $KEYRING_PLUGIN_OPT > $LOG_FILE 2>&1

--echo -- There should be no errors
--let SEARCH_FILE=    $LOG_FILE
--let SEARCH_PATTERN= \[ERROR\]
--source include/search_pattern.inc

--echo -- There should be no leftovers in the datadir.
--list_files $TEST_DATADIR


--exec $MYSQLD --no-defaults --help --verbose --secure-file-priv="./some_dir" > $LOG_FILE 2>&1

--##########################################################################
-- 5. Run --help --verbose and check some plugin options.
--##########################################################################

SELECT PLUGIN_NAME, PLUGIN_STATUS, LOAD_OPTION FROM INFORMATION_SCHEMA.PLUGINS
  WHERE PLUGIN_NAME IN ('ARCHIVE', 'BLACKHOLE', 'FEDERATED')
  ORDER BY PLUGIN_NAME;
