SELECT count(*) FROM t1;
SELECT count(*) FROM t1, t1, t1, t1, t1, t1, empty;
SELECT count(*) FROM t1, t1 LEFT JOIN empty;
SELECT count(*) FROM t1, t1 LEFT JOIN t1, empty;
