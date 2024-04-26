--

--exec $MYSQLADMIN --no-defaults --default-character-set=latin1 -S $MASTER_MYSOCK -P $MASTER_MYPORT  -u root --password= ping 2>&1

--
-- Bug#10608 mysqladmin breaks on "database" variable in my.cnf
--

-- When mysqladmin finds database in .cnf file it shall fail
--write_file $MYSQLTEST_VARDIR/tmp/bug10608.cnf
[client]
database=db1
EOF

-- Error 7 is EXIT_UNKNOWN_VARIABLE.
--replace_regex /.*mysqladmin.*: unknown/mysqladmin: unknown/
--error 7
--exec $MYSQLADMIN --defaults-file=$MYSQLTEST_VARDIR/tmp/bug10608.cnf --default-character-set=latin1 -S $MASTER_MYSOCK -P $MASTER_MYPORT  -u root --password= ping 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug10608.cnf;

-- When mysqladmin finds "loose-database" in .cnf file it shall print
-- a warning and continue
--write_file $MYSQLTEST_VARDIR/tmp/bug10608.cnf
[client]
loose-database=db2
EOF

--replace_regex /Warning: .*mysqladmin.*: unknown/Warning: mysqladmin: unknown/
--exec $MYSQLADMIN --defaults-file=$MYSQLTEST_VARDIR/tmp/bug10608.cnf --default-character-set=latin1 -S $MASTER_MYSOCK -P $MASTER_MYPORT  -u root --password= ping 2>&1

remove_file $MYSQLTEST_VARDIR/tmp/bug10608.cnf;

--
-- WL#3126 TCP address binding for mysql client library;
EOF

--echo -- Using --defaults-extra-file option with 'cnf_file'.
--exec $MYSQLADMIN --defaults-extra-file=$MYSQLTEST_VARDIR/tmp/cnf_file -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT ping 2>&1

-- Testing with non-empty --defaults-extra-file with .cnf extension.
--write_file $MYSQLTEST_VARDIR/tmp/cnf_test.cnf
[client]
host = 127.0.0.1
EOF

--exec $MYSQLADMIN --defaults-extra-file=$MYSQLTEST_VARDIR/tmp/cnf_test.cnf -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT ping 2>&1

--remove_file $MYSQLTEST_VARDIR/tmp/cnf_test.cnf

-- Uncomment the following scenarios after Bug#27406735 is fixed
-- Testing with non-existing defaults-extra-file
----error 1
----exec $MYSQLADMIN --defaults-extra-file=$MYSQLTEST_VARDIR/tmp/nonexistent.cnf -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT ping < /dev/null > /dev/null 2>&1

-- Testing with non-existing defaults-file
----error 1
----exec $MYSQLADMIN --defaults-file=$MYSQLTEST_VARDIR/tmp/nonexistent.cnf -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --show-warnings ping < /dev/null > /dev/null  2>&1

-- Testing defaults-file with with no .cnf or .ini extension
--exec $MYSQLADMIN --defaults-file=$MYSQLTEST_VARDIR/tmp/cnf_file -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --show-warnings ping 2>&1
--remove_file $MYSQLTEST_VARDIR/tmp/cnf_file

-- Testing with non-empty --defaults-file with .cnf extension
--write_file $MYSQLTEST_VARDIR/tmp/cnf_test_df.cnf
[client]
host = 127.0.0.1
EOF

--exec $MYSQLADMIN --defaults-file=$MYSQLTEST_VARDIR/tmp/cnf_test_df.cnf -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT ping 2>&1
--remove_file $MYSQLTEST_VARDIR/tmp/cnf_test_df.cnf

-- Using option relative
--exec $MYSQLADMIN -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --sleep=1 --count=2 extended status < /dev/null > /dev/null  2>&1

-- Running mysqladmin with --compress
--exec $MYSQLADMIN -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --compress --skip-verbose ping 2>&1

-- Testing option --login-path
CREATE USER testadmin_user1;
DROP USER testadmin_user1;

-- Using --server-public-key-path and --get-server-public-key
CREATE USER tester@localhost IDENTIFIED WITH caching_sha2_password BY 'abcd';
DROP USER tester@localhost;
let $file = $MYSQLTEST_VARDIR/tmp/b32092739.out;
EOF
let $file2 = $MYSQLTEST_VARDIR/tmp/b32092739_file.out;
EOF
--replace_regex /OS errno.*/OS error/
--replace_result $file file
--error 1
exec $MYSQLADMIN --defaults-file=$file -uroot -h localhost --password="" -S $MASTER_MYSOCK -P $MASTER_MYPORT --show-warnings ping 2>&1 ;
