PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3), (NULL);
SELECT i % 2 AS k FROM integers WHERE k<>0;
SELECT i % 2 AS i FROM integers WHERE i<>0;
SELECT i % 2 AS k FROM integers WHERE integers.i<>0;
SELECT i % 2 AS k FROM integers WHERE k=k;
