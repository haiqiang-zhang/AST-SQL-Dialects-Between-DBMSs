SELECT * FROM list_window ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 1)) FROM list_window GROUP BY g ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 2)) FROM list_window GROUP BY g ORDER BY g;
SELECT FIRST(LIST_EXTRACT(l, 3)) FROM list_window GROUP BY g ORDER BY g;
select j, s, list(s) over (partition by j order by s) 
from list_combine_test 
order by j, s;
