let $MYSQLD_DATADIR=`SELECT @@datadir`;
EOF
let $EXPORT_DIR= $MYSQL_TMP_DIR/export;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t1 ORDER BY i;
DROP TABLE s1.t1;
DROP SCHEMA s1;

CREATE SCHEMA s2;
DROP SCHEMA s2;
CREATE TABLE t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT i FROM t1 ORDER BY i;

DROP TABLE t1;
CREATE TABLE t1 (i int) ENGINE MYISAM;
DROP TABLE t1;

CREATE TABLE t1(i INT) ENGINE MYISAM;
DROP TABLE t1;
CREATE TABLE t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO t1 VALUES ('AAA'), ('BBB'), ('CCC');
DROP TABLE t1;
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE MYISAM;
SET @@session.lock_wait_timeout= 1;
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE=MYISAM;
{
  next unless (/(.+)_\d+\.sdi/);
  my $base= $1;
{
  s/("sdi_version": ?)\d+,/${1}42,/g;
EOF

--echo -- Copy SDI file back into data dir
--copy_files_wildcard $EXPORT_DIR $MYSQLD_DATADIR/test/ t1_.sdi

-- List error twice to avoid echoing error message, which will contain the
-- current server version number
--error ER_IMP_INCOMPATIBLE_SDI_VERSION,ER_IMP_INCOMPATIBLE_SDI_VERSION
IMPORT TABLE FROM 't1_.sdi';
DROP TABLE t1;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i INT) ENGINE MYISAM;
CREATE USER noimportforyou@localhost;

DROP USER noimportforyou@localhost;
DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE TABLE t1 (i INT) ENGINE=MYISAM;
INSERT INTO t1 VALUES (1), (3), (5);
SELECT * FROM t1;
CREATE TABLE t2 (i INT) ENGINE=MYISAM;
INSERT INTO t2 VALUES (2), (4), (6);
SELECT * FROM t2;
CREATE VIEW v2 AS SELECT * FROM t2;
SELECT * FROM v2;
DROP TABLE t1;
DROP TABLE t2;
SELECT * FROM t1;
SELECT * FROM t2;
SELECT * FROM v2;
DROP VIEW v2;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (i INT) ENGINE MYISAM;
INSERT INTO t1 VALUES (1), (3), (5);
SELECT * FROM t1 ORDER BY i;
DROP TABLE t1;
{
  next unless (/(.+)_\d+\.sdi/);
  my $base= $1;
EOF

--list_files $EXPORT_DIR
--copy_files_wildcard $EXPORT_DIR $MYSQLD_DATADIR/test/ t1*
IMPORT TABLE FROM 't1_.sdi';
SELECT * FROM t1 ORDER BY k;
DROP TABLE t1;

CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t1 ORDER BY i;

DROP TABLE s1.t1;
ALTER SCHEMA s1 DEFAULT COLLATE latin1_bin;
SELECT i FROM s1.t1 ORDER BY i;
CREATE TABLE s1.t2(i VARCHAR(32));
INSERT INTO s1.t2 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT I FROM s1.t2 ORDER BY i;

DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE SCHEMA s1;
CREATE TABLE s1.t1(i VARCHAR(32)) ENGINE MYISAM;
INSERT INTO s1.t1 VALUES ('abc'), ('DEF'), ('Ghi'), ('ghI');
SELECT i FROM s1.t1 ORDER BY i;
DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE SCHEMA s1;
SELECT i FROM s1.t1 ORDER BY i;

DROP TABLE s1.t1;
DROP SCHEMA s1;
CREATE TABLE T_CASE(i INT) ENGINE MYISAM;
INSERT INTO T_CASE VALUES (1), (3), (5);
SELECT * FROM T_CASE ORDER BY i;
DROP TABLE T_CASE;
{
  if (/(.+)_\d+\.sdi/)
  {
    my $b= lc($1);
    rename $_, "${b}.sdi";
    next;
  }
  if (/(.+)\.MYD/)
  {
    my $b= lc($1);
    rename $_, "${b}.MYD";
    next;
  }
  if (/(.+)\.MYI/)
  {
    my $b= lc($1);
    rename $_, "${b}.MYI";
  }

}
closedir(TMP);
{
  s/T_CASE/t_case/g;
EOF

--list_files $EXPORT_DIR
--copy_files_wildcard $EXPORT_DIR $MYSQLD_DATADIR/test/ t_case*
IMPORT TABLE FROM 't_case.sdi';
SELECT i FROM t_case ORDER BY i;
DROP TABLE t_case;

let BASEDIR=    `select @@basedir`;
let DDIR=       $MYSQL_TMP_DIR/lctn_test;
let MYSQLD_LOG= $MYSQL_TMP_DIR/server.log;
let extra_args= --no-defaults --innodb_dedicated_server=OFF --log-error=$MYSQLD_LOG --loose-skip-auto_generate_certs --loose-skip-sha256_password_auto_generate_rsa_keys --skip-ssl --lower_case_table_names=1 --basedir=$BASEDIR --lc-messages-dir=$MYSQL_SHAREDIR;
let BOOTSTRAP_SQL= $MYSQL_TMP_DIR/tiny_bootstrap.sql;
  CREATE SCHEMA test;
EOF

--echo -- 2. First start the server with --initialize
--exec $MYSQLD $extra_args --secure-file-priv="" --initialize-insecure --datadir=$DDIR --init-file=$BOOTSTRAP_SQL

--echo -- 3. Restart the server against DDIR - should succeed.
--exec echo "restart:" --datadir=$DDIR --lower_case_table_names=1 --secure-file-priv="" --no-console --log-error=$MYSQLD_LOG > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

--echo -- 4. Import file created on server without lctn
--echo -- Copying exported t_case files into \$DDIR/test
--copy_files_wildcard $EXPORT_DIR $DDIR/test/ t_case*
--echo -- Listing \$DDIR/test:
--list_files $DDIR/test

IMPORT TABLE FROM 't_case.sdi';
SELECT i FROM t_case ORDER BY i;
DROP TABLE t_case;
CREATE TABLE t1 (i INT DEFAULT 42, dt DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
                 de DECIMAL(10,2), j INT GENERATED ALWAYS AS (42+i)) ENGINE=MYISAM;
INSERT INTO t1(dt,de) VALUES ('2017-03-28 18:48:01', 1.1),
                             ('2017-03-28 18:48:02', 1.2),
                             ('2017-03-28 18:48:03', 1.5);
SELECT * FROM t1;
DROP TABLE t1;
SELECT * FROM t1;
DROP TABLE t1;

CREATE TABLE t1 (i INT) ENGINE=MYISAM;
DROP TABLE t1;

SET SESSION sql_require_primary_key= ON;

SET SESSION sql_require_primary_key= OFF;
CREATE TABLE t1 (f1 INT CHECK (f1 < 10)) ENGINE=MyISAM;
let $MYSQLD_DATADIR=`SELECT @@datadir`;
DROP TABLE t1;
DROP TABLE t1;
