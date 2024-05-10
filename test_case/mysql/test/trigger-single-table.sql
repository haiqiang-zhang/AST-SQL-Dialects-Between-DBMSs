SELECT @@GLOBAL.table_open_cache_instances;
CREATE TABLE t1
(
  id  BIGINT NOT NULL PRIMARY KEY,
  tr1 BIGINT NOT NULL,
  tr2 BIGINT NOT NULL
);
SELECT id,
       tr1 = connection_id() AS "tr1 valid",
       tr2 = connection_id() AS "tr2 valid"
FROM t1
WHERE id=1;
SELECT id,
       tr1 = connection_id() AS "tr1 valid", 
       tr2 = connection_id() AS "tr2 valid"
FROM t1
WHERE id=2;
SELECT COUNT(DISTINCT tr1), COUNT(DISTINCT tr2) FROM t1;
DROP TABLE t1;
