SELECT DISTINCT
  1
FROM
  t7
  JOIN t8 ON t7.pk = t8.pk
  JOIN t4 AS t6 ON t6.c = t7.pk
  JOIN (
    t4 AS t9
    JOIN t1 AS t10 ON t9.a = t10.a AND t9.b = t10.b
  ) ON t8.a = t10.a AND t6.b = t10.b
  JOIN t8 AS t11 ON t8.b = t11.c
  JOIN t12 ON t8.c = t12.c AND t10.a = t12.a AND t8.b = t12.b
  JOIN t5 ON t5.a = t10.c AND t5.b = t12.pk
  JOIN t13 ON t6.b = t13.pk
  JOIN t4 ON t4.a = t11.a
  JOIN t3 ON t3.a = t10.b
  JOIN t2 ON t2.pk = t7.a
  JOIN t1 ON t1.a = t12.b
WHERE
  t10.c < 8
  AND t6.pk = 6
  AND t2.b <> 3;
DROP TABLE t1,t2,t3,t4,t5,t7,t8,t12,t13;
