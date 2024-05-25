SELECT DISTINCT id1 AS x, id1 AS y FROM t1, t2;
SELECT count(*) FROM t1, t2 GROUP BY id1, id1;
