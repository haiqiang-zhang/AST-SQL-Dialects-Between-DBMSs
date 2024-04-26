
let BASEDIR= `select @@basedir`;
let DDIR=$MYSQL_TMP_DIR/installdb_test;
let MYSQLD_LOG=$MYSQL_TMP_DIR/server.log;
let extra_args=--no-defaults --innodb_dedicated_server=OFF --console --tls-version= --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
CREATE DATABASE test;
EOF

--echo -- Run the server with --initialize --autocommit=off
--exec $MYSQLD $extra_args --initialize-insecure $VALIDATE_PASSWORD_OPT --datadir=$DDIR --init-file=$MYSQL_TMP_DIR/bug35254025init.sql --autocommit=off > $MYSQLD_LOG 2>&1

remove_file $MYSQL_TMP_DIR/bug35254025init.sql;
