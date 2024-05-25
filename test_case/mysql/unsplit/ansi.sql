drop table if exists t1;
select @@sql_mode;
SELECT 'A' || 'B';
CREATE TABLE t1 (id INT, id2 int);
SELECT id,NULL,1,1.1,'a' FROM t1 GROUP BY id;
drop table t1;
