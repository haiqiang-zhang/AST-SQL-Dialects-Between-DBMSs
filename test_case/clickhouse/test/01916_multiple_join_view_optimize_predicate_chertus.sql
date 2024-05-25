SELECT * FROM a ANY LEFT OUTER JOIN j USING id ORDER BY a.id, a.val SETTINGS enable_optimize_predicate_expression = 1;
SELECT * FROM a ANY LEFT OUTER JOIN j USING id ORDER BY a.id, a.val SETTINGS enable_optimize_predicate_expression = 0;
DROP TABLE a;
DROP TABLE j;
CREATE TABLE j (id UInt8, val UInt8) Engine = Join(ALL, INNER, id);
SELECT * FROM (SELECT 0 id, 1 val) _ JOIN j USING id;
DROP TABLE j;
