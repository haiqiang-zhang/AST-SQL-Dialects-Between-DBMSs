PRAGMA enable_verification;
create table integers as select range i from range(0,16);;
select 
  x, y, 
  count(*) over (partition by y order by x), 
  count(*) over (w order by x)
from (values (1, 1), (2, 1), (3, 2), (4, 2)) as t (x, y)
window w as (partition by y order by x desc)
order by x;
select 
  x, y, 
  count(*) over (partition by y order by x), 
  count(*) over (w partition by y)
from (values (1, 1), (2, 1), (3, 2), (4, 2)) as t (x, y)
window w as (partition by x)
order by x;
select i, sum(i) over (w) as smoothed 
from integers 
window w AS (order by i rows between 1 preceding and 1 following) 
order by i;;
SELECT sum(1) over cumulativeSum 
FROM integers 
WINDOW cumulativeSum AS (), 
	cumulativesum AS (order by i rows between 1 preceding and 1 following);;
SELECT sum(i) over cumulativeSum 
FROM integers 
WINDOW cumulativeSum AS ();;
select max(base), max(referenced), sum(refined), sum(unrefined) from (
    select
    	row_number() over w AS base,
    	row_number() over (w) as referenced,
    	sum(i % 4) over (w rows between 1 preceding and 1 following) AS refined,
    	sum(i % 4) over (rows between 1 preceding and 1 following) AS unrefined
    from integers
    WINDOW w AS (partition by i // 4 order by i % 4)
) q;;
select 
  x, y, 
  count(*) over (partition by y order by x), 
  count(*) over (w order by x)
from (values (1, 1), (2, 1), (3, 2), (4, 2)) as t (x, y)
window w as (partition by y)
order by x;
