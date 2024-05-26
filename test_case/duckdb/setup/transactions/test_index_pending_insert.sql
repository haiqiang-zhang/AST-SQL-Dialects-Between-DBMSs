CREATE TABLE integers(i INTEGER);
BEGIN TRANSACTION;
INSERT INTO integers VALUES (1), (2), (3);
CREATE INDEX i_index ON integers using art(i);
COMMIT;
