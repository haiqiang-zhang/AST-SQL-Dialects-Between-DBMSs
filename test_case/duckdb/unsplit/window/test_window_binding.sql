PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
SELECT MIN(i) OVER (PARTITION BY i ORDER BY i) FROM integers;
