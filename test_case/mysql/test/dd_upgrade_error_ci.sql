{
    --let ZIP_FILE= $MYSQLTEST_VARDIR/std_data/data80011_upgrade_groupby_desc_ci_mac.zip
}

--echo -- Stop DB server which was created by MTR default
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--source include/shutdown_mysqld.inc

--echo -- ------------------------------------------------------------------
--echo -- Check upgrade from 8.0 when events/triggers/views/routines contain GROUP BY DESC.
--echo -- ------------------------------------------------------------------

--echo -- Set different path for --datadir
let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data80011_upgrade_groupby_desc_ci;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
