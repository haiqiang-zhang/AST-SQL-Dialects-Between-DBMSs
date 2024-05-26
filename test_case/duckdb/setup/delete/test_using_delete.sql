PRAGMA enable_verification;
CREATE TABLE a(i INTEGER);
INSERT INTO a VALUES (1), (2), (3);
INSERT INTO a VALUES (1), (2), (3);
DELETE FROM a USING (values (1)) tbl(i) WHERE a.i=tbl.i;
