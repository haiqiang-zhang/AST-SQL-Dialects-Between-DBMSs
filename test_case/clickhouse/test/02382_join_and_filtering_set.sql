SELECT count() FROM t1 JOIN t2 ON t1.x = t2.x;
SELECT 'bug with constant columns in join keys';
SELECT * FROM ( SELECT 'a' AS key ) AS t1
INNER JOIN ( SELECT 'a' AS key ) AS t2
ON t1.key = t2.key;
SELECT count() > 1 FROM (EXPLAIN PIPELINE
    SELECT * FROM ( SELECT materialize('a') AS key ) AS t1
    INNER JOIN ( SELECT materialize('a') AS key ) AS t2
    ON t1.key = t2.key
) WHERE explain ilike '%FilterBySetOnTheFlyTransform%';
SELECT count() == 0 FROM (EXPLAIN PIPELINE
    SELECT * FROM ( SELECT 'a' AS key ) AS t1
    INNER JOIN ( SELECT 'a' AS key ) AS t2
    ON t1.key = t2.key
) WHERE explain ilike '%FilterBySetOnTheFlyTransform%';
