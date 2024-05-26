SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE integers(g integer, i integer);
INSERT INTO integers values (0, 1), (0, 2), (1, 3), (1, NULL);
