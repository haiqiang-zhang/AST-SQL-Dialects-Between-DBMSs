CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (1), (2), (3);
BEGIN TRANSACTION;
DELETE FROM integers WHERE i=1;
CREATE INDEX i_index ON integers using art(i);
COMMIT;
