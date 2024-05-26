SELECT replaceRegexpAll(explain, '__table1\.|_UInt8', '') FROM (EXPLAIN actions=1 SELECT count() FROM t_02156_merge1 WHERE k = 3 AND notEmpty(v)) WHERE explain LIKE '%Prewhere%' OR explain LIKE '%Filter column%';
SELECT count() FROM t_02156_merge1 WHERE k = 3 AND notEmpty(v);
DROP TABLE IF EXISTS t_02156_mt1;
DROP TABLE IF EXISTS t_02156_mt2;
DROP TABLE IF EXISTS t_02156_log;
DROP TABLE IF EXISTS t_02156_dist;
DROP TABLE IF EXISTS t_02156_merge1;
DROP TABLE IF EXISTS t_02156_merge2;
DROP TABLE IF EXISTS t_02156_merge3;
