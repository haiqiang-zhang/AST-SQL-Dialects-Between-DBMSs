SELECT group_concat(num) FROM (SELECT num FROM t1 ORDER BY num DESC);
