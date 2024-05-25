PRAGMA enable_verification;
CREATE TABLE types(i INTEGER, j VARCHAR, k HUGEINT, d DOUBLE, e BLOB);;
INSERT INTO types VALUES 
	(1, 'hello', 12, 0.5, BLOB 'a\x00b\x00c'), 
	(2, 'world', -12, -0.5, BLOB ''), 
	(3, NULL, NULL, NULL, NULL);;
SUMMARIZE VALUES (1.0),(6754950520);;
SUMMARIZE SELECT 9223372036854775296;;
summarize select bigint from test_all_types();;
summarize select 9223372036854775295;;
SELECT UNNEST(['i', 'j', 'k', 'd', 'e']) column_names,
       UNNEST(['INTEGER', 'VARCHAR', 'HUGEINT', 'DOUBLE', 'BLOB']) column_types,
       UNNEST([MIN(i)::VARCHAR, MIN(j)::VARCHAR, MIN(k)::VARCHAR, MIN(d)::VARCHAR, MIN(e)::VARCHAR]) min,
	   UNNEST([MAX(i)::VARCHAR, MAX(j)::VARCHAR, MAX(k)::VARCHAR, MAX(d)::VARCHAR, MAX(e)::VARCHAR]) max
FROM (SELECT * FROM types) tbl;
SUMMARIZE types;;
SUMMARIZE SELECT * FROM types;;
