let $BUGDATA_80011_DATADIR = $MYSQL_TMP_DIR/bugdata_80011;
let $MYSQLD_LOG= $MYSQLTEST_VARDIR/log/save_dd_upgrade_80011_1.log;

SET DEBUG='+d,skip_dd_table_access_check';
SELECT mysql.schemata.name, mysql.tables.name, mysql.indexes.name,
       mysql.indexes.options
FROM mysql.tables, mysql.indexes, mysql.schemata
WHERE mysql.tables.name = 'users' AND
      mysql.schemata.name = 'test' AND
      mysql.indexes.table_id = mysql.tables.id AND
      mysql.schemata.id = mysql.tables.schema_id;
ALTER TABLE users ADD COLUMN active integer DEFAULT 1 NOT NULL, ALGORITHM =INSTANT;
SELECT mysql.schemata.name, mysql.tables.name, mysql.indexes.name,
       mysql.indexes.options
FROM mysql.tables, mysql.indexes, mysql.schemata
WHERE mysql.tables.name = 'users' AND
      mysql.schemata.name = 'test' AND
      mysql.indexes.table_id = mysql.tables.id AND
      mysql.schemata.id = mysql.tables.schema_id;
ALTER TABLE users ENGINE = INNODB;
SELECT mysql.schemata.name, mysql.tables.name, mysql.indexes.name,
       mysql.indexes.options
FROM mysql.tables, mysql.indexes, mysql.schemata
WHERE mysql.tables.name = 'users' AND
      mysql.schemata.name = 'test' AND
      mysql.indexes.table_id = mysql.tables.id AND
      mysql.schemata.id = mysql.tables.schema_id;
CREATE TABLE t2 (a VARCHAR(200), b TEXT, FULLTEXT (a,b)) charset utf8mb4;
SET debug='+d,skip_dd_table_access_check';
let $assert_cond = "[SELECT COUNT(name) FROM mysql.tables WHERE created = 0 OR last_altered = 0]" = 0;
let $restart_parameters =;
