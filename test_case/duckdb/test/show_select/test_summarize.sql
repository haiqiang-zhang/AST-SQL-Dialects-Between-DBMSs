SUMMARIZE VALUES (1.0),(6754950520);
SUMMARIZE SELECT 9223372036854775296;
summarize select bigint from test_all_types();
summarize select 9223372036854775295;
SELECT UNNEST(['i', 'j', 'k', 'd', 'e']) column_names,
       UNNEST(['INTEGER', 'VARCHAR', 'HUGEINT', 'DOUBLE', 'BLOB']) column_types,
       UNNEST([MIN(i)::VARCHAR, MIN(j)::VARCHAR, MIN(k)::VARCHAR, MIN(d)::VARCHAR, MIN(e)::VARCHAR]) min,
	   UNNEST([MAX(i)::VARCHAR, MAX(j)::VARCHAR, MAX(k)::VARCHAR, MAX(d)::VARCHAR, MAX(e)::VARCHAR]) max
FROM (SELECT * FROM types) tbl;
SUMMARIZE types;
SUMMARIZE SELECT * FROM types;
