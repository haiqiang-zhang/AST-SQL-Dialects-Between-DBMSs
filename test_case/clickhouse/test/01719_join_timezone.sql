DROP TABLE IF EXISTS test;
CREATE TABLE test (timestamp DateTime('UTC'), i UInt8) Engine=MergeTree() PARTITION BY toYYYYMM(timestamp) ORDER BY (i);
INSERT INTO test values ('2020-05-13 16:38:45', 1);
SELECT
    toTimeZone(timestamp, 'America/Sao_Paulo') AS converted,
    timestamp AS original
FROM test
LEFT JOIN (SELECT 2 AS x) AS anything ON x = i
WHERE timestamp >= toDateTime('2020-05-13T00:00:00', 'America/Sao_Paulo');
/* This was incorrect result in previous ClickHouse versions:
ââconvertedââââââââââââ¬âoriginalâââââââââââââ
â 2020-05-13 16:38:45 â 2020-05-13 16:38:45 â <-- toTimeZone is ignored.
âââââââââââââââââââââââ´ââââââââââââââââââââââ
*/

SELECT
    toTimeZone(timestamp, 'America/Sao_Paulo') AS converted,
    timestamp AS original
FROM test
-- LEFT JOIN (SELECT 2 AS x) AS anything ON x = i -- Removing the join fixes the issue.
WHERE timestamp >= toDateTime('2020-05-13T00:00:00', 'America/Sao_Paulo');
/*
ââconvertedââââââââââââ¬âoriginalâââââââââââââ
â 2020-05-13 13:38:45 â 2020-05-13 16:38:45 â <-- toTimeZone works.
âââââââââââââââââââââââ´ââââââââââââââââââââââ
*/

SELECT
    toTimeZone(timestamp, 'America/Sao_Paulo') AS converted,
    timestamp AS original
FROM test
LEFT JOIN (SELECT 2 AS x) AS anything ON x = i
WHERE timestamp >= '2020-05-13T00:00:00';
/*
ââconvertedââââââââââââ¬âoriginalâââââââââââââ
â 2020-05-13 13:38:45 â 2020-05-13 16:38:45 â <-- toTimeZone works.
âââââââââââââââââââââââ´ââââââââââââââââââââââ
*/

DROP TABLE test;