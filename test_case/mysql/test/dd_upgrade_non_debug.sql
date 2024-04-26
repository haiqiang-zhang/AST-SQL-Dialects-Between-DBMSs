let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57;

let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;

ALTER TABLE aview.t1 comment='abcd';
ALTER TABLE aview.t2 comment='efgh';
