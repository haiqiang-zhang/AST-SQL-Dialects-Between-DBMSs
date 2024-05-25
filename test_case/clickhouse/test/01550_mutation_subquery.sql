SELECT * FROM t;
SET mutations_sync = 1;
ALTER TABLE t DELETE WHERE id in (select id from t as tmp);
SELECT '---';
SELECT * FROM t;
DROP TABLE t;
