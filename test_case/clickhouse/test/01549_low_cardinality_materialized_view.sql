CREATE MATERIALIZED VIEW HASH_MV (HASH_VAL UInt64, STR_VAL LowCardinality(String)) ENGINE = ReplacingMergeTree ORDER BY HASH_VAL AS SELECT xxHash64(STR_VAL) AS HASH_VAL, toLowCardinality(STR_VAL) AS STR_VAL FROM HASH_TEST_INSERT;
INSERT INTO HASH_TEST_INSERT VALUES ('test');
SELECT * FROM HASH_MV;
DESC (SELECT * FROM HASH_MV);
DROP TABLE HASH_MV;
DROP TABLE HASH_TEST_INSERT;