SELECT DISTINCT "number" FROM (SELECT "letter", "number" FROM "test" ORDER BY "letter", "number" LIMIT 1) AS "test";
