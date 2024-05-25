SELECT max(a,b,c) FROM t1;
SELECT min(a,b,c) FROM t1;
SELECT coalesce(min(a,b,c),999) FROM t1;
SELECT coalesce(a,b,c) FROM t1;
