let $MYSQLD_DATADIR=`SELECT @@datadir`;
EOF
let $EXPORT_DIR= $MYSQL_TMP_DIR/export;
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1), (3), (5);
SELECT * FROM t1;
DROP TABLE t1;
SET SESSION debug= '+d,sdi_import_commit_fail';
SET SESSION debug= '-d,sdi_import_commit_fail';
DROP TABLE t1;
