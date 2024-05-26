SET join_use_nulls = 1;
SELECT *, d.* FROM ( SELECT 1 AS id, 2 AS value ) a SEMI LEFT JOIN ( SELECT 1 AS id, 3 AS values ) AS d USING id;
SELECT id, toTypeName(id), value, toTypeName(value), d.values, toTypeName(d.values) FROM ( SELECT 1 AS id, 2 AS value ) a SEMI LEFT JOIN ( SELECT 1 AS id, 3 AS values ) AS d USING id;
