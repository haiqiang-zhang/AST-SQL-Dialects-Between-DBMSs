SELECT * FROM encryption_test;
DROP TABLE encryption_test;
CREATE TABLE encryption_test (i Int, s String Codec(AES_256_GCM_SIV)) ENGINE = MergeTree ORDER BY i;
SELECT * FROM encryption_test;
DROP TABLE encryption_test;
