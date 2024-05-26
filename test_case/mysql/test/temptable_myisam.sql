SELECT col1
FROM t1
WHERE ( NOT EXISTS (
  SELECT col2
  FROM t1
  WHERE ( 7 ) IN (
    SELECT v1.col1
    FROM ( v1 JOIN ( SELECT * FROM t1 ) AS d1
      ON ( d1.col2 = v1.col2 )
    )
  )
));
DROP VIEW v1;
DROP TABLE t1;
DROP DATABASE temptable_test;
