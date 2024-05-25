SET max_threads = 1;
SET max_bytes_before_external_sort = 0;
SELECT attr, _id, arrayFilter(x -> (x IN (select '1')), attr_list) z
FROM TESTTABLE ARRAY JOIN z AS attr ORDER BY _id LIMIT 3 BY attr;
DROP TABLE TESTTABLE;
