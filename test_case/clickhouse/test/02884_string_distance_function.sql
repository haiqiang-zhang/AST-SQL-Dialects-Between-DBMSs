SELECT '-- const arguments';
SELECT 'clickhouse' AS s1, 'mouse' AS s2, byteHammingDistance(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, editDistance(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, damerauLevenshteinDistance(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, stringJaccardIndex(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, stringJaccardIndexUTF8(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, jaroSimilarity(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, jaroWinklerSimilarity(s1, s2);
SELECT '-- test aliases';
SELECT 'clickhouse' AS s1, 'mouse' AS s2, mismatches(s1, s2);
SELECT 'clickhouse' AS s1, 'mouse' AS s2, levenshteinDistance(s1, s2);
SELECT '-- Deny DoS using too large inputs';
DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    s1 String,
    s2 String
) ENGINE = MergeTree ORDER BY s1;
INSERT INTO t VALUES ('', '') ('abc', '') ('', 'abc') ('abc', 'abc') ('abc', 'ab') ('abc', 'bc') ('clickhouse', 'mouse');
SELECT '-- non-const arguments';
SELECT 'byteHammingDistance', s1, s2, byteHammingDistance(s1, s2) FROM t ORDER BY ALL;
SELECT 'editDistance', s1, s2, editDistance(s1, s2) FROM t ORDER BY ALL;
SELECT 'damerauLevenshteinDistance', s1, s2, damerauLevenshteinDistance(s1, s2) FROM t ORDER BY ALL;
SELECT 'stringJaccardIndex', s1, s2, stringJaccardIndex(s1, s2) FROM t ORDER BY ALL;
SELECT 'stringJaccardIndexUTF8', s1, s2, stringJaccardIndexUTF8(s1, s2) FROM t ORDER BY ALL;
SELECT 'jaroSimilarity', s1, s2, jaroSimilarity(s1, s2) FROM t ORDER BY ALL;
SELECT 'jaroWinklerSimilarity', s1, s2, jaroWinklerSimilarity(s1, s2) FROM t ORDER BY ALL;
SELECT '-- Special UTF-8 tests';
SELECT stringJaccardIndexUTF8(materialize('hello'), materialize('\x48\x65\x6C'));
SELECT stringJaccardIndexUTF8(materialize('hello'), materialize('\x41\xE2\x82\xAC'));
SELECT stringJaccardIndexUTF8(materialize('hello'), materialize('\xF0\x9F\x99\x82'));
SELECT stringJaccardIndexUTF8('Ã°ÂÂÂÃ°ÂÂÂ', 'Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ'), stringJaccardIndex('Ã°ÂÂÂÃ°ÂÂÂ', 'Ã°ÂÂÂÃ°ÂÂÂÃ°ÂÂÂ');
DROP TABLE t;
