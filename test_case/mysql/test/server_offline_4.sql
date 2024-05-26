LOCK TABLE t2 read;
select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t2 add column j int";
SELECT COUNT(USER) FROM INFORMATION_SCHEMA.PROCESSLIST;
UNLOCK TABLES;
SELECT * FROM t2 ORDER BY c1;
DROP TABLE t2;
