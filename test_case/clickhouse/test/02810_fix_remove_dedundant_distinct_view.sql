create view tab_v as select distinct(x) from tab;
set query_plan_remove_redundant_distinct=1;
SELECT count()
FROM
(
    EXPLAIN SELECT DISTINCT x FROM tab_v
)
WHERE explain ILIKE '%distinct%';
SELECT DISTINCT x FROM tab_v ORDER BY x;
SELECT count()
FROM
(
    EXPLAIN SELECT DISTINCT x FROM (SELECT materialize(x) as x FROM (select DISTINCT x from tab))
)
WHERE explain ILIKE '%distinct%';
