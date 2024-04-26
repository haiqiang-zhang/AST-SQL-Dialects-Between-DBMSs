
-- Disable concurrent inserts to avoid test failures when reading
-- data from concurrent connections (insert might return before
-- the data is actually in the table).
set @old_concurrent_insert= @@global.concurrent_insert;
set @@global.concurrent_insert= 0;
drop table if exists t1;

-- Test of the xml output of the 'mysql' and 'mysqldump' clients -- makes
-- sure that basic encoding issues are handled properly
create table t1 (
  `a&b` int,
  `a<b` int,
  `a>b` text
);
insert into t1 values (1, 2, 'a&b a<b a>b');

-- Determine the number of open sessions
--source include/count_sessions.inc

--exec $MYSQL --xml test -e "select * from t1"
--exec $MYSQL_DUMP --xml --skip-create-options test

--exec $MYSQL --xml test -e "select count(*) from t1"
--exec $MYSQL --xml test -e "select 1 < 2 from dual"
--exec $MYSQL --xml test -e "select 1 > 2 from dual"
--exec $MYSQL --xml test -e "select 1 & 3 from dual"
--exec $MYSQL --xml test -e "select null from dual"
--exec $MYSQL --xml test -e "select 1 limit 0"
--exec $MYSQL --xml test -vv -e "select 1 limit 0"

drop table t1;

-- Restore global concurrent_insert value
set @@global.concurrent_insert= @old_concurrent_insert;
