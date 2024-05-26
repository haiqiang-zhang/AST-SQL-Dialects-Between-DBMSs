SELECT id, regexp_replace(date, 'Sales [(]([0-9]+)/([0-9]+)/([0-9]+)[)]', '\3-\1-\2')::DATE AS date, sales
FROM t1
    UNPIVOT (sales FOR date IN ("Sales (05/19/2020)", "Sales (06/03/2020)", "Sales (10/23/2020)"))
 ORDER BY ALL;
SELECT id, regexp_replace(date, 'Sales [(]([0-9]+)/([0-9]+)/([0-9]+)[)]', '\3-\1-\2')::DATE AS date, sales
FROM
    (UNPIVOT t1 ON "Sales (05/19/2020)", "Sales (06/03/2020)", "Sales (10/23/2020)" INTO NAME date VALUE sales)
 ORDER BY ALL;
SELECT *
FROM
	(UNPIVOT t1 ON "Sales (05/19/2020)" AS "2020-05-19", "Sales (06/03/2020)" AS "2020-06-03", "Sales (10/23/2020)" AS "2020-10-23" INTO NAME date VALUE sales)
ORDER BY ALL;
SELECT id, regexp_replace(date, 'Sales [(]([0-9]+)/([0-9]+)/([0-9]+)[)]', '\3-\1-\2')::DATE AS date, sales FROM t1
    UNPIVOT (Sales FOR Date IN (COLUMNS('Sales.*')))
 ORDER BY ALL;
SELECT id, regexp_replace(date, 'Sales [(]([0-9]+)/([0-9]+)/([0-9]+)[)]', '\3-\1-\2')::DATE AS date, sales
FROM
	(UNPIVOT t1 ON COLUMNS('Sales.*') INTO NAME date VALUE sales)
ORDER BY ALL;
SELECT id, regexp_replace(date, 'Sales [(]([0-9]+)/([0-9]+)/([0-9]+)[)]', '\3-\1-\2')::DATE AS date, sales
FROM
	(UNPIVOT t1 ON * EXCLUDE (id) INTO NAME date VALUE sales)
ORDER BY ALL;
