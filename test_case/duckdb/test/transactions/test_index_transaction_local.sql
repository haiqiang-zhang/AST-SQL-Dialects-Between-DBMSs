CREATE TABLE integers(i INTEGER PRIMARY KEY);
INSERT INTO integers VALUES (1), (2), (3);
INSERT INTO integers VALUES (1);
INSERT INTO integers VALUES (4);
UPDATE integers SET i=1 WHERE i=4;
UPDATE integers SET i=5 WHERE i=4;
DELETE FROM integers WHERE i=1;
INSERT INTO integers VALUES (1);
DELETE FROM integers WHERE i >= 4;
BEGIN TRANSACTION;
BEGIN TRANSACTION;
INSERT INTO integers VALUES (4);
INSERT INTO integers VALUES (4);
COMMIT;
COMMIT;
BEGIN TRANSACTION;;
CREATE TABLE issue2241 (id text primary key);;
INSERT INTO issue2241 VALUES ('Alice');;
INSERT INTO issue2241 VALUES ('Bob');;
DELETE FROM issue2241 WHERE id = 'Bob';;
INSERT INTO issue2241 VALUES ('Bob');;
COMMIT;;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FROM integers;
SELECT COUNT(*) FROM integers WHERE i=1;
SELECT COUNT(*) FROM integers WHERE i=1;
SELECT COUNT(*) FROM integers WHERE i=4;
SELECT COUNT(*) FROM integers WHERE i=4;