SET default_null_order='nulls_first';
PRAGMA enable_verification;
CREATE TABLE list_extract_test(i INTEGER, g INTEGER);
INSERT INTO list_extract_test VALUES (1, 1), (2, 1), (3, 2), (NULL, 3), (42, 3);
CREATE VIEW list_window AS
SELECT g, LIST(i) OVER (PARTITION BY g ORDER BY i ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as l
FROM list_extract_test;
create table list_combine_test as 
	select range%3 j, 
		range::varchar AS s, 
		case when range%3=0 then '-' else '|' end sep 
	from range(1, 65);
SELECT * FROM list_window ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 1)) FROM list_window GROUP BY g ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 2)) FROM list_window GROUP BY g ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 3)) FROM list_window GROUP BY g ORDER BY g;
select j, s, list(s) over (partition by j order by s) 
from list_combine_test 
order by j, s;
