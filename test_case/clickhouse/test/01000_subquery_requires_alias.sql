SET allow_experimental_analyzer = 1;
SET joined_subquery_requires_alias = 1;
SELECT * FROM (SELECT 1 as A, 2 as B) X
ALL LEFT JOIN (SELECT 3 as A, 2 as B) Y
USING (B);
SELECT * FROM (SELECT 1 as A, 2 as B) X
ALL LEFT JOIN (SELECT 3 as A, 2 as B)
USING (B);
SELECT * FROM (SELECT 1 as A, 2 as B)
ALL LEFT JOIN (SELECT 3 as A, 2 as B) Y
USING (B);
set joined_subquery_requires_alias = 0;
SELECT * FROM (SELECT 1 as A, 2 as B)
ALL LEFT JOIN (SELECT 3 as A, 2 as B) Y
USING (B);