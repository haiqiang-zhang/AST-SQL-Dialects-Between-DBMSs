PRAGMA enable_verification;
CREATE TABLE a (b int);;
BEGIN;;
INSERT INTO a VALUES (1);;
UPDATE a SET b = b + 10;;
COMMIT;;
UPDATE a SET b = b + 10;;
SELECT * FROM a;
