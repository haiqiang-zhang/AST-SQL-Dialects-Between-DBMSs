DROP TABLE IF EXISTS source_data;
CREATE TABLE source_data (
    pk Int32, sk Int32, val UInt32, partition_key UInt32 DEFAULT 1,
    PRIMARY KEY (pk)
) ENGINE=MergeTree
ORDER BY (pk, sk);
INSERT INTO source_data (pk, sk, val) VALUES (0, 0, 0), (0, 0, 0), (1, 1, 2), (1, 1, 3);
SELECT 'TOTAL rows', count() FROM source_data;
DROP TABLE IF EXISTS full_duplicates;
CREATE TABLE full_duplicates  (
    pk Int32, sk Int32, val UInt32, partition_key UInt32, mat UInt32 MATERIALIZED 12345, alias UInt32 ALIAS 2,
    PRIMARY KEY (pk)
) ENGINE=MergeTree
PARTITION BY (partition_key + 1) -- ensure that column in expression is properly handled when deduplicating. See [1] below.
ORDER BY (pk, toString(sk * 10));
SELECT 'OLD DEDUPLICATE';
INSERT INTO full_duplicates SELECT * FROM source_data;
OPTIMIZE TABLE full_duplicates FINAL DEDUPLICATE;
SELECT * FROM full_duplicates;
TRUNCATE full_duplicates;
SELECT 'DEDUPLICATE BY *';
INSERT INTO full_duplicates SELECT * FROM source_data;
OPTIMIZE TABLE full_duplicates FINAL DEDUPLICATE BY *;
SELECT * FROM full_duplicates;
TRUNCATE full_duplicates;
SELECT 'DEDUPLICATE BY * EXCEPT mat';
INSERT INTO full_duplicates SELECT * FROM source_data;
OPTIMIZE TABLE full_duplicates FINAL DEDUPLICATE BY * EXCEPT mat;
SELECT * FROM full_duplicates;
TRUNCATE full_duplicates;
SELECT 'DEDUPLICATE BY pk,sk,val,mat,partition_key';
INSERT INTO full_duplicates SELECT * FROM source_data;
OPTIMIZE TABLE full_duplicates FINAL DEDUPLICATE BY pk,sk,val,mat,partition_key;
SELECT * FROM full_duplicates;
TRUNCATE full_duplicates;
DROP TABLE IF EXISTS partial_duplicates;
SELECT 'Can not remove full duplicates';
SELECT 'OLD DEDUPLICATE';
SELECT 'DEDUPLICATE BY pk,sk,val,mat';
SELECT 'Remove partial duplicates';
SELECT 'DEDUPLICATE BY *';
SELECT 'DEDUPLICATE BY * EXCEPT mat';
SELECT 'DEDUPLICATE BY COLUMNS("*") EXCEPT mat';
SELECT 'DEDUPLICATE BY pk,sk';
SELECT 'DEDUPLICATE BY COLUMNS(".*k")';
DROP TABLE full_duplicates;
DROP TABLE source_data;
