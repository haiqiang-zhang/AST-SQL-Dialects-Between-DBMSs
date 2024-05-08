CREATE TABLE t1(filename, tablename, istart, iend);
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<99)
  INSERT INTO t1 SELECT printf('test%03d.db',x),'t2',x*1000,x*1000+999 FROM c;
