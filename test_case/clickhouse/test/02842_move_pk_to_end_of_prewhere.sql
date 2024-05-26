SELECT replaceRegexpAll(explain, '__table1\.|_UInt8', '') FROM (EXPLAIN actions=1 SELECT count() FROM t_02848_mt1 WHERE k = 3 AND notEmpty(v)) WHERE explain LIKE '%Prewhere filter%' OR explain LIKE '%Filter%';
SELECT count() FROM t_02848_mt1 WHERE k = 3 AND notEmpty(v);
CREATE TABLE t_02848_mt2 (a UInt32, b String, c Int32, d String) ENGINE = MergeTree ORDER BY (a,b,c) SETTINGS min_bytes_for_wide_part=0;
INSERT INTO t_02848_mt2 SELECT number, toString(number), number, 'aaaabbbbccccddddtestxxxyyy' FROM numbers(100);
DROP TABLE t_02848_mt1;
DROP TABLE t_02848_mt2;
