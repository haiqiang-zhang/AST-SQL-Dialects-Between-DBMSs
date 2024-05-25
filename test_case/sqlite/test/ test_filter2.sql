SELECT sum(b) FROM t1;
SELECT sum(b) FILTER (WHERE a<10) FROM t1;
SELECT count(DISTINCT b) FROM t1;
SELECT count(DISTINCT b) FILTER (WHERE a!=19) FROM t1;
SELECT min(b) FILTER (WHERE a>19),
         min(b) FILTER (WHERE a>0),
         max(a+b) FILTER (WHERE a>19),
         max(b+a) FILTER (WHERE a BETWEEN 10 AND 40)
  FROM t1;
SELECT min(b),
         min(b),
         max(a+b),
         max(b+a)
  FROM t1
  GROUP BY (a%10)
  ORDER BY 1, 2, 3, 4;
SELECT min(b) FILTER (WHERE a>19),
         min(b) FILTER (WHERE a>0),
         max(a+b) FILTER (WHERE a>19),
         max(b+a) FILTER (WHERE a BETWEEN 10 AND 40)
  FROM t1
  GROUP BY (a%10)
  ORDER BY 1, 2, 3, 4;
SELECT sum(a+b) FILTER (WHERE a=NULL) FROM t1;
SELECT (a%5) FROM t1 GROUP BY (a%5) 
  HAVING sum(b) FILTER (WHERE b<20) > 34
  ORDER BY 1;
SELECT (a%5), sum(b) FILTER (WHERE b<20) AS bbb
  FROM t1
  GROUP BY (a%5) HAVING sum(b) FILTER (WHERE b<20) >34
  ORDER BY 1;
SELECT (a%5), sum(b) FILTER (WHERE b<20) AS bbb
  FROM t1
  GROUP BY (a%5) HAVING sum(b) FILTER (WHERE b<20) >34
  ORDER BY 2;
SELECT (a%5), 
    sum(b) FILTER (WHERE b<20) AS bbb,
    count(distinct b) FILTER (WHERE b<20 OR a=13) AS ccc
  FROM t1 GROUP BY (a%5)
  ORDER BY 2;
SELECT 
    string_agg(CAST(b AS TEXT), '_') FILTER (WHERE b%2!=0),
    group_concat(CAST(b AS TEXT), '_') FILTER (WHERE b%2!=1),
    count(*) FILTER (WHERE b%2!=0),
    count(*) FILTER (WHERE b%2!=1)
  FROM t1;
SELECT 
    a/5,
    sum(b) FILTER (WHERE a%5=0),
    sum(b) FILTER (WHERE a%5=1),
    sum(b) FILTER (WHERE a%5=2),
    sum(b) FILTER (WHERE a%5=3),
    sum(b) FILTER (WHERE a%5=4)
  FROM t1 GROUP BY (a/5) ORDER BY 1;
