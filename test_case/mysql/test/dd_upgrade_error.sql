let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;

let SEARCH_FILE= $MYSQLD_LOG;
let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57_enum;

-- Copy .frm file with generated column containing removed function.
--copy_file $MYSQLTEST_VARDIR/std_data/t_gcol_dep.frm $MYSQL_TMP_DIR/data57_enum/test/t_gcol_dep.frm

--echo --
--echo -- BUG#26743291 : VIEW WITH EXPLICIT COLUMN NAME > 64 IS MARKED
--echo --                INVALID WHEN UPGRADED TO 8.0.

--write_file $MYSQL_TMP_DIR/data57_enum/test/v1.frm
TYPE=VIEW
query=select 1 AS `a123456789012345678901234567890123456789012345678901234567890123456789`
md5=fc83a6c1fde1c4183a3c24c91751f36f
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2017-10-20 06:39:41
create-version=1
source=select 1
client_cs_name=utf8mb3
connection_cl_name=utf8_general_ci
view_body_utf8=select 1 AS `a123456789012345678901234567890123456789012345678901234567890123456789`
EOF

--echo -- Starting the DB server will fail since the data dir contains
--echo -- a table and a stored program with a too long enum literals.
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let $MYSQLD_DATADIR1 = $MYSQL_TMP_DIR/data57_upgrade_groupby_desc;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
