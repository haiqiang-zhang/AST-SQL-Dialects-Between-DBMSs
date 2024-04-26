
-- Creating DB's and populating different types of data init for MYSQLPUMP testing.
-- source include/mysqlpump_stmt.inc

-- concurrency testing
-- when single-transaction is used it is not recommended to use parallelism
--exec $MYSQL_PUMP --databases db1 --single-transaction > $MYSQLTEST_VARDIR/tmp/result_file_1.sql
--exec $MYSQL_PUMP --parallel-schemas=3:db2,db1_1gb --default-parallelism=2 --include-databases=db1_1gb,db1,db2 > $MYSQLTEST_VARDIR/tmp/result_file_2.sql

DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db1_1gb;

-- --add-lock : Wrap data inserts on table with write lock on that table in output. This doesn't work with parallelism.
-- Because for this restore will fail. eg.ERROR 1100 (HY000) at line 259: Table '<table_name>' was not locked with LOCK TABLES
----exec $MYSQL_PUMP --parallel-schemas=3:db1 --parallel-schemas=db_1gb,db3 --include-databases=db1,db1_1gb,db3 --add-locks > $MYSQLTEST_VARDIR/tmp/result_file_3.sql
--DROP DATABASE db1;

-- --add-locks will not  work with multi-threaded dump. restore falis with error.
----exec $MYSQL_PUMP --include-databases=db1,db1_1gb,db2 --add-locks > $MYSQLTEST_VARDIR/tmp/result_file_4.sql
--DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db3;
DROP DATABASE db1_1gb;
DROP DATABASE db1;
DROP DATABASE db2;
DROP DATABASE db3;
DROP DATABASE db1_1gb;
