SELECT count()
FROM
(
    EXPLAIN SELECT DISTINCT x FROM tab_v
)
WHERE explain ILIKE '%distinct%';
SELECT DISTINCT x FROM tab_v ORDER BY x;
