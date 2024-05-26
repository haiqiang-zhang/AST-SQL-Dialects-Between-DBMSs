SELECT NewColumn
FROM test_a
INNER JOIN
(SELECT OldColumn, NewColumn FROM test_b) s
Using OldColumn
PREWHERE NewColumn != '';
DROP TABLE test_a;
DROP TABLE test_b;
