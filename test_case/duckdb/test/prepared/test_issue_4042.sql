PRAGMA enable_verification;
CREATE TABLE stringliterals AS SELECT 1 AS ID, 1::BIGINT AS a1,'value-1' AS a2,'value-1' AS a3,10::BIGINT AS a4;
PREPARE v1 AS
SELECT ((SUM(CASE
             WHEN ((stringliterals.a2 = ($1)::text) AND (stringliterals.a3 = ($1)::text))
	     THEN stringliterals.a4
	     ELSE (0)::int
	     END) +
	 SUM(CASE
	     WHEN ((stringliterals.a2 = ($2)::text) AND (stringliterals.a3 = ($2)::text))
	     THEN stringliterals.a4
	     ELSE (0)::int
	     END)) / ((SUM(CASE
	                   WHEN ((stringliterals.a2 = ($1)::text) AND (stringliterals.a3 = ($1)::text))
			   THEN stringliterals.a4
			   ELSE (0)::int
			   END) +
                       SUM(CASE
		           WHEN ((stringliterals.a2 = ($2)::text) AND (stringliterals.a3 = ($2)::text))
			   THEN stringliterals.a4
			   ELSE (0)::int
			   END)))::float8) AS A00000185
FROM stringliterals;
EXECUTE v1('value-1', 'value-2');
