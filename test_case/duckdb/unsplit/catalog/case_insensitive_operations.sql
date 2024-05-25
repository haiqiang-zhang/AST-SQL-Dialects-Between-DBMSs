SET default_null_order='nulls_first';;
PRAGMA enable_verification;
CREATE TABLE INTEGERS(I INTEGER);;
INSERT INTO integers (i) VALUES (1), (2), (3), (NULL);;
WITH "CTE"("ZZZ") AS (
	SELECT integers.i AS "ZZZ" FROM integers GROUP BY "zzz"
),
	"cte" AS (SELECT 42);
ALTER TABLE integers ADD COLUMN J INTEGER;;
ALTER TABLE integers DROP COLUMN i;;
DROP TABLE integers;;
CREATE TABLE STRUCTS(S ROW(I ROW(K INTEGER)));;
INSERT INTO structs VALUES ({'i': {'k': 42}});;
DROP TABLE structs;;
PRAGMA preserve_identifier_case=false;;
SELECT integers.i FROM integers ORDER BY i;;
SELECT integers.i AS i FROM integers GROUP BY I ORDER BY "integers"."I";;
SELECT integers.i AS "ZZZ" FROM integers GROUP BY "zzz" ORDER BY "INTEGERS"."i";;
WITH "CTE"("ZZZ") AS (
	SELECT integers.i AS "ZZZ" FROM integers GROUP BY "zzz"
)
SELECT * FROM cte ORDER BY zZz;;
UPDATE integers SET i=integers.i+1;
SELECT i FROM integers ORDER BY integers.i;;
DELETE FROM integers WHERE i IS NULL;;
SELECT i FROM integers ORDER BY integers.i;;
SELECT i, j FROM integers ORDER BY integers.i;;
UPDATE integers SET j=integers.i;;
SELECT j FROM integers ORDER BY integers.j;;
SELECT tbl.k FROM (SELECT j FROM integers) TBL(K) ORDER BY K;;
SELECT structs.S.i.K, "STRUCTS"."S"."I"."K", "structs"."s"."i"."k" FROM structs;
SELECT "STRUCTS"."S"."I"."K" FROM structs GROUP BY "STRUCTS"."S"."I"."K";
SELECT structs.S.i.K FROM structs GROUP BY structs.S.i.K;
