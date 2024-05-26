SELECT col_varchar_key FROM t1
WHERE ( col_varchar_key, col_varchar_key ) NOT IN (
  SELECT alias1.col_varchar_key, alias1.col_varchar_key
  FROM (
    t1 AS alias1
    JOIN ( t1 AS alias2 JOIN t2 ON t2.col_varchar_key = alias2.col_varchar_key )
      ON ( t2.col_int_key = alias2.col_int_key AND alias2.col_varchar_key IN ( SELECT f1 FROM v1 ) ) )
  WHERE alias1.col_varchar >= 'Z' );
DROP VIEW v1;
DROP TABLE t1, t2, a;
