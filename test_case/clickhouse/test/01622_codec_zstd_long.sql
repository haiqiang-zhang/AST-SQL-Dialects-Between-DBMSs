SELECT COUNT(n) FROM zstd_1_00 LEFT JOIN words ON i == n WHERE b == word;
SELECT COUNT(n) FROM zstd_1_24 LEFT JOIN words ON i == n WHERE b == word;
SELECT COUNT(n) FROM zstd_9_00 LEFT JOIN words ON i == n WHERE b == word;
SELECT COUNT(n) FROM zstd_9_24 LEFT JOIN words ON i == n WHERE b == word;
DROP TABLE zstd_1_00;
DROP TABLE zstd_1_24;
DROP TABLE zstd_9_00;
DROP TABLE zstd_9_24;
DROP TABLE words;
