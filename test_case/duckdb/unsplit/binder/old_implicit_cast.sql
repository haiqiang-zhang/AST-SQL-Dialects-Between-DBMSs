CREATE TABLE integers AS SELECT 42 AS i, '5' AS v;
SET old_implicit_casting=true;
SELECT i[1] FROM integers;
SELECT i >= v FROM integers;
SELECT [i, v] FROM integers;