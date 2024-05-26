SELECT * REPLACE i+100 AS i FROM integers;
SELECT * EXCLUDE (j, k) REPLACE (i+100 AS i), * EXCLUDE (j) REPLACE (i+100 AS i), * EXCLUDE (j, k) REPLACE (i+101 AS i) FROM integers;
SELECT * REPLACE (i+100 AS i, j+200 AS "J") FROM integers;
SELECT integers.* REPLACE (i+100 AS i) FROM integers;
