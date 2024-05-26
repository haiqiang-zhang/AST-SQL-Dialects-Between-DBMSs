PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);
CREATE TABLE integers2 (i INTEGER, j INTEGER, st VARCHAR, d DATE);
INSERT INTO integers VALUES (1, 1), (2, 2), (3, 3), (NULL, NULL);
INSERT INTO integers2 VALUES (1, 30, 'a', '1992-01-01'), (8, 12, 'b', '1992-01-01'), (3, 24, 'c', '1992-01-01'), (9, 16, 'd', '1992-01-01'), (10, NULL, 'e', '1992-01-01');
