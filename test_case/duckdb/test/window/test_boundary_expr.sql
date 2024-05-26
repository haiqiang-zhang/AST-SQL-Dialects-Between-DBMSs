select avg(a) over (
    order by b asc
    rows between mod(b * 1023, 11) preceding and 23 - mod(b * 1023, 11) following)
from issue1697;
SELECT sum(unique1) over (order by unique1 rows between 2 preceding and 2 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 2 preceding and 1 preceding) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 1 following and 3 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between unbounded preceding and 1 following) su FROM tenk1 order by unique1;
SELECT sum(unique1) over (order by unique1 rows between 5 following and 10 following) su FROM tenk1 order by unique1;
select permno,
    sum(log(ret+1)) over (PARTITION BY permno ORDER BY date rows between 12 preceding and 2 preceding),
    ret
from issue1472
ORDER BY permno, date;
