CREATE TABLE tbl1 (i int);
SELECT json_serialize_plan('SELECT 1 + 2 FROM tbl1');
SELECT json_serialize_plan('SELECT *, 1 + 2 FROM tbl1', skip_null := true, skip_empty := true);
SELECT json_serialize_plan('SELECT *, 1 + 2 FROM tbl1', skip_null := true, skip_empty := true, optimize := true);
SELECT json_serialize_plan('SELECT AND LAUNCH ROCKETS WHERE 1 = 1');
SELECT json_serialize_plan('SELECT * FROM nonexistent_table') LIKE '%Table with name nonexistent_table does not exist%';
