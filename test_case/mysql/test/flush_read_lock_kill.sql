SELECT ((@id := kill_id) - kill_id) FROM t1 LIMIT 1;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for commit lock"
  and info = "flush tables with read lock";
DROP TABLE t1;
