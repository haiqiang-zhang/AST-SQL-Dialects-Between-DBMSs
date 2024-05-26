SELECT t.x, l.s, r.s, toTypeName(l.s), toTypeName(r.s) FROM t AS l LEFT JOIN nr AS r USING (x) ORDER BY t.x;
SELECT '-';
SELECT '-';
SET allow_experimental_analyzer = 0;
SELECT '-';
DROP TABLE t;
DROP TABLE nr;
