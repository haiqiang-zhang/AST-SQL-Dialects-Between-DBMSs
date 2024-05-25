CREATE TABLE integers(i INT);
INSERT INTO integers VALUES (1), (2), (3), (NULL);
BEGIN;
UPDATE integers SET i=i+1;
ROLLBACK;
SELECT * FROM integers;
