SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE integers(a INTEGER, b INTEGER);
INSERT INTO integers VALUES (1, 10), (2, 12), (3, 14), (4, 16), (5, NULL), (NULL, NULL);
CREATE TABLE strings(s VARCHAR);
INSERT INTO strings VALUES ('hello'), ('world'), (NULL);
