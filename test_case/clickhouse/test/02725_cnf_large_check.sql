SELECT count()
FROM 02725_cnf
WHERE (c5 AND (NOT c0)) OR ((NOT c3) AND (NOT c6) AND (NOT c1) AND (NOT c6)) OR (c7 AND (NOT c3) AND (NOT c5) AND (NOT c7)) OR ((NOT c8) AND c5) OR ((NOT c0)) OR ((NOT c8) AND (NOT c5) AND c1 AND c6 AND c3) OR (c7 AND (NOT c0) AND c6 AND c1 AND (NOT c2)) OR (c3 AND (NOT c9) AND c1)
SETTINGS convert_query_to_cnf = 1, allow_experimental_analyzer = 1;
DROP TABLE 02725_cnf;
