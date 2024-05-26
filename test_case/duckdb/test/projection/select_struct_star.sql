SELECT a.* FROM test;
SELECT a.* EXCLUDE(j) FROM test;
SELECT a.* EXCLUDE(i) FROM test;
SELECT a.* REPLACE(a.i + 3 AS i) FROM test;
