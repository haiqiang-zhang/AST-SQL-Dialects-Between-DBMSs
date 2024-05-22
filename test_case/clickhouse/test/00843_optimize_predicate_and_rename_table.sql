SET enable_optimize_predicate_expression = 1;
DROP TABLE IF EXISTS test1_00843;
DROP TABLE IF EXISTS test2_00843;
DROP TABLE IF EXISTS view_00843;
CREATE TABLE test1_00843 (a UInt8) ENGINE = Memory;
INSERT INTO test1_00843 VALUES (1);
CREATE VIEW view_00843 AS SELECT * FROM test1_00843;
SELECT * FROM view_00843;
RENAME TABLE test1_00843 TO test2_00843;
RENAME TABLE test2_00843 TO test1_00843;
SELECT * FROM view_00843;
DROP TABLE test1_00843;
DROP TABLE view_00843;
