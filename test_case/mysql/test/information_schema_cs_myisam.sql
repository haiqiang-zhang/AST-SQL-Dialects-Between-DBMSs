
-- Result differences depending on FS case sensitivity.
if (!$require_case_insensitive_file_system)
{
  --source include/have_case_sensitive_file_system.inc
}

--source include/no_valgrind_without_big.inc

--Don't run this test when thread_pool active
--source include/not_threadpool.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

set @orig_sql_mode= @@sql_mode;
CREATE TABLE mysql.procs_priv_copy ENGINE=MyISAM AS SELECT * FROM mysql.procs_priv;

let $query=
select * from
information_schema . innodb_cmp as table1
left outer join mysql . procs_priv_copy as table2
on ( table2 . routine_name = table1 . compress_time )
where not table1 . compress_time <> '2006-09-03 10:11:37.046313'
having  table2 . grantor <> '2008-02-28 22:17:05.025739' limit 9;
DROP TABLE mysql.procs_priv_copy;
