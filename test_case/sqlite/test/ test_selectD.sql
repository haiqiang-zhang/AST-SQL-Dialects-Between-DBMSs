EXPLAIN QUERY PLAN
  SELECT * 
   FROM t41
   LEFT JOIN (SELECT count(*) AS cnt, x1.d
                FROM (t42 INNER JOIN t43 ON d=g) AS x1
               WHERE x1.d>5
               GROUP BY x1.d) AS x2
                  ON t41.b=x2.d;
