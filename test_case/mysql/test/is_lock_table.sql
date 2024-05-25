CREATE VIEW v1 AS SELECT * FROM t3;
SELECT COUNT(*) FROM information_schema.columns
                WHERE table_name='db';
UNLOCK TABLES;
LOCK TABLE t1 READ, v1 READ;
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM v1;
SELECT COUNT(*) FROM information_schema.columns WHERE table_name='db';
SELECT COUNT(*) FROM information_schema.tables m
                     JOIN information_schema.columns n
                     ON m.table_name = n.table_name
                WHERE m.table_name='db';
SELECT COUNT(*) FROM information_schema.columns, t1
                WHERE table_name='db';
SELECT COUNT(*) FROM information_schema.columns, v1
                WHERE table_name='db';
UNLOCK TABLES;
SELECT * FROM t1;
LOCK TABLE t1 WRITE, t1 as X READ, t3 READ;
SELECT * FROM t1 as X;
UNLOCK TABLES;
INSERT INTO t1 VALUES(1);
SELECT * FROM t2;
LOCK TABLE t1 WRITE, t2 WRITE;
INSERT INTO t1 VALUES(1);
SELECT * FROM t2;
UNLOCK TABLES;
LOCK TABLES t1 READ;
SELECT COUNT(*) > 0 FROM information_schema.tables;
UNLOCK TABLES;
DROP TABLE t1, t3;
DROP VIEW v1;
