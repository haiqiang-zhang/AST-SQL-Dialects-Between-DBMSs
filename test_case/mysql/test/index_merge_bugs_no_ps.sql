
CREATE TABLE t1 (f1 INT, f2 INT, f3 INT, key(f1), key(f2, f3), key(f2));

INSERT INTO t1 VALUES (0,1,2),(1,2,3),(2,3,4);
INSERT INTO t1 SELECT f1,f2+1,f3+2 FROM t1;
INSERT INTO t1 SELECT f1,f2+1,f3+2 FROM t1;
INSERT INTO t1 SELECT f1,f2+1,f3+2 FROM t1;
SELECT * FROM t1 WHERE f1 = 0 OR f2 = 2;
SELECT SUM_ROWS_EXAMINED, SUM_ROWS_SENT
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'test' AND NOT DIGEST_TEXT LIKE '%TRUNCATE%';
SELECT * FROM t1 WHERE f1 > 1 OR f2 < 0;
SELECT SUM_ROWS_EXAMINED, SUM_ROWS_SENT
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'test' AND NOT DIGEST_TEXT LIKE '%TRUNCATE%';
SELECT * FROM t1 WHERE f1 = 0 AND f2 = 2;
SELECT SUM_ROWS_EXAMINED, SUM_ROWS_SENT
FROM performance_schema.events_statements_summary_by_digest
WHERE schema_name = 'test' AND NOT DIGEST_TEXT LIKE '%TRUNCATE%';

DROP TABLE t1;
