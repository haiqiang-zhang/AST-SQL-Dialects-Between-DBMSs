EXPLAIN SELECT * FROM integers;
EXPLAIN select sum(i), j, sum(i), j from integers group by j having j < 10;
EXPLAIN update integers set i=i+1;
EXPLAIN delete from integers where i=1;
