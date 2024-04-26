let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data80011_upgrade_groupby_desc_cs;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;

-- The datadir is created by buildling the appropriate server version and
-- running the following SQL statements:
--
-- CREATE TABLESPACE s1 ADD DATAFILE 's1.ibd';
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1, PARTITION p2, PARTITION p3);
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1, PARTITION p2, PARTITION p3);
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1, PARTITION p2, PARTITION p3);
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1, PARTITION p2, PARTITION p3);
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1,
--    PARTITION p2 TABLESPACE innodb_system,
--    PARTITION p3 TABLESPACE s1);
--   TABLESPACE s1
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1,
--    PARTITION p2 TABLESPACE innodb_file_per_table,
--    PARTITION p3 TABLESPACE innodb_system);
--   TABLESPACE s1
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1 TABLESPACE innodb_file_per_table,
--    PARTITION p2 TABLESPACE innodb_file_per_table,
--    PARTITION p3 TABLESPACE innodb_system);
--   TABLESPACE s1
--   PARTITION BY KEY(i) PARTITIONS 3
--   (PARTITION p1 TABLESPACE s2,
--    PARTITION p2 TABLESPACE innodb_file_per_table,
--    PARTITION p3 TABLESPACE innodb_system);
--   TABLESPACE s1;
let $MYSQLD_DATADIR_80012_PART = $MYSQL_TMP_DIR/data_80012_part;
let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_800012_part.log;
let SEARCH_FILE= $MYSQLD_LOG;
let $restart_parameters =;
