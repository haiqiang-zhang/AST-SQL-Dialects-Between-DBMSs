CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3);
BEGIN TRANSACTION;
UPDATE integers SET i=4 WHERE i=1;
CREATE INDEX i_index ON integers using art(i);
COMMIT;
CREATE INDEX i_index ON integers using art(i);
SELECT COUNT(*) FROM integers WHERE i=4;
SELECT COUNT(*) FROM integers WHERE i=4;
