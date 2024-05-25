ALTER TABLE test ADD PROJECTION mtlog_proj_source_reference (SELECT * ORDER BY substring(ns, 1, 5));
SHOW CREATE test;
drop table test;
