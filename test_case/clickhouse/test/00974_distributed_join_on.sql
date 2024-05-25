SET prefer_localhost_replica = 1;
SET prefer_localhost_replica = 0;
SELECT t1.a as t1_a, t2.a as t2_a FROM source_table1 AS t1 JOIN source_table1 AS t2 ON t1_a = t2_a LIMIT 1;
DROP TABLE source_table1;
DROP TABLE source_table2;
