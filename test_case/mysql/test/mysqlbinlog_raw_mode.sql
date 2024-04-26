
-- source include/mysqlbinlog_raw_mode.inc

-- Test --stop-never
-- If exit code is good or bad then entry in raw_mode_exit table will be created
-- Anything above exit code 1 is bad.  We wait for this
CREATE TABLE raw_mode_exit (exit_code INT);
EOF
--exec /bin/bash $MYSQL_TMP_DIR/mbl.sh
let $wait_condition= SELECT id from information_schema.processlist where processlist.command like '%Binlog%' and state like '%Source has sent%';

-- Wait until creating binlog files by mysqlbinlog 
--perl
$timeout= 30;
{
    if (-e $binlog)
    {
	$binlog_exists= 1;
    }
    sleep 1;
    $timeout--;
{
    print "Timeout reached but binlog file $binlog was not created";
EOF

--diff_files $MYSQL_TMP_DIR/binlog.000001 $MYSQLD_DATADIR/binlog.000001
--diff_files $MYSQL_TMP_DIR/binlog.000002 $MYSQLD_DATADIR/binlog.000002

SELECT ((@id := id) - id) from information_schema.processlist where processlist.command like '%Binlog%' and state like '%Source has sent%';

DROP TABLE raw_mode_exit;
