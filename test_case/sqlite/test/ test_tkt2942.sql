SELECT group_concat(num) FROM (SELECT num FROM t1 ORDER BY num DESC);
SELECT group_concat(num) FROM (SELECT num FROM t1 ORDER BY num);
SELECT group_concat(num) FROM (SELECT num FROM t1);
SELECT group_concat(num) FROM (SELECT num FROM t1 ORDER BY rowid DESC);
