SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FILTER (WHERE j = 10) FROM integers;
select j from integers limit 5;
select j from integers limit 5;
select j from integers limit 5 offset 4995;
select COUNT(j) filter (where j != 0) from integers;
