SELECT GET_LOCK('mysqltest_lock', 100);
select count(*) = 1 from information_schema.processlist
  where state = "User lock" and
        info = "UPDATE t1 SET c1=GET_LOCK('mysqltest_lock', 100)";
SELECT RELEASE_LOCK('mysqltest_lock');
SELECT RELEASE_LOCK('mysqltest_lock');
DROP TABLE t1;
