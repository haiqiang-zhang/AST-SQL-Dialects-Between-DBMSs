PRAGMA enable_verification;
CREATE TABLE vals AS SELECT * FROM (
	VALUES (1, 'hello'), (NULL, '2'), (3, NULL)
) tbl(a, b);
SELECT COALESCE(1, 'hello'::INT);
SELECT COALESCE(a, b::INT) FROM vals;
