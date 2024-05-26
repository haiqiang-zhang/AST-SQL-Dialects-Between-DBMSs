WITH t AS
         (
             SELECT number AS n
             FROM numbers(10000)
         )
SELECT count(*)
FROM t AS a
WHERE a.n < 5000;
SET enable_global_with_statement = 0;
