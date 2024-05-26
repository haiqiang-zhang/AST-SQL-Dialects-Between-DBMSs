PRAGMA force_compression='dictionary';
CREATE TABLE test (a VARCHAR[]);
INSERT INTO test SELECT CASE WHEN i%2=0 THEN [] ELSE ['Hello', 'World'] END FROM range(10000) t(i);
CREATE TABLE test2 AS SELECT * FROM test ORDER BY a;
