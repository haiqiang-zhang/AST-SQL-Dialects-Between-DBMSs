CREATE TABLE integers(i INTEGER NOT NULL);
INSERT INTO integers VALUES (3);
UPDATE integers SET i=4;
CREATE TABLE integers_with_null(i INTEGER);
INSERT INTO integers_with_null VALUES (3), (4), (5), (NULL);
INSERT INTO integers (i) SELECT * FROM integers_with_null WHERE i IS NOT NULL;
UPDATE integers SET i=4 WHERE i>4;
