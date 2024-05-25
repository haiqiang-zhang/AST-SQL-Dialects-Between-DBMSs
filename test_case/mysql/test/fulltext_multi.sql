SELECT a, round(MATCH  b  AGAINST ('lala lkjh'),5) FROM t1;
SELECT a, round(MATCH  c  AGAINST ('lala lkjh'),5) FROM t1;
SELECT a, round(MATCH b,c AGAINST ('lala lkjh'),5) FROM t1;
drop table t1;
