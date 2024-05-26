SELECT 42,;
SELECT 42,
       84,;
SELECT DISTINCT 42,
       84,;
VALUES (42,);
VALUES (42,),;
SELECT * FROM (VALUES (42,));
SELECT * FROM integers,;
SELECT i, SUM(j) FROM integers GROUP BY i,;
SELECT i FROM integers;
SELECT [1,];
SELECT ARRAY[1,];
SELECT {'a': 42, 'b': 84,};
