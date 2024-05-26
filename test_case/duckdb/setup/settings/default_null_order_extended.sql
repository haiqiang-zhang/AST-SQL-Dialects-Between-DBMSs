PRAGMA enable_verification;
CREATE TABLE integers(i integer);
INSERT INTO integers VALUES (1), (2), (3), (NULL);
SET default_null_order='nulls_first';
SET default_null_order='sqlite';
SET default_null_order='postgres';
