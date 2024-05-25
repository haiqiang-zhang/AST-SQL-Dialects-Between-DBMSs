SELECT a2.col_int AS f1,a1.pk AS f2,a1.col_int_key AS f3
FROM
( 
   t2 AS a2
   RIGHT JOIN
   (  
      t3 AS a3
      LEFT JOIN
      (
         t4 AS a4
         LEFT OUTER JOIN
         t2 AS a5
         ON a4.pk = a5.col_int_key
      )
      ON a3.pk = a4.pk
   )
   ON a2.pk = a3.pk
)
LEFT JOIN
t1 AS a1
ON a1.col_varchar_1024_utf8_key = a2.col_varchar_1024_utf8_key
WHERE (a3.col_int > 7 AND a1.col_int = 8)
ORDER BY f1,f2,f3 DESC;
DROP TABLE t1,t2,t3,t4;
