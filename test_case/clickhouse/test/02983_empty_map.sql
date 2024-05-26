SELECT f1, f2['2'], count() FROM t1 GROUP BY 1,2 order by 1,2;
