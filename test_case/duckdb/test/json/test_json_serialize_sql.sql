SELECT json_serialize_sql('SELECT 1 + 2 FROM tbl1');
SELECT json_serialize_sql('SELECT *, 1 + 2 FROM tbl1', skip_null := true, skip_empty := true);
SELECT json_serialize_sql('SELECT * FROM (SELECT 1 + 2)', skip_null := true, skip_empty := true);
CREATE TABLE tbl2 (a INT, b INT, c INT);
INSERT INTO tbl2 VALUES (1, 2, 3), (4, 5, 6), (7, 8, 9);
SELECT json_serialize_sql('SELECT AND LAUNCH ROCKETS WHERE 1 = 1');
SELECT json_deserialize_sql(json_serialize_sql('SELECT 1 + 2 FROM tbl1'));
SELECT json_deserialize_sql(json_serialize_sql('SELECT *, 1 + 2 FROM tbl1'));
SELECT json_deserialize_sql(json_serialize_sql('SELECT * FROM (SELECT 1 + 2)'));
SELECT * FROM json_execute_serialized_sql(json_serialize_sql('SELECT 1 + 2'));
SELECT * FROM json_execute_serialized_sql(json_serialize_sql('SELECT * FROM tbl2'));
SELECT * FROM json_execute_serialized_sql(json_serialize_sql('SELECT a + b + c FROM tbl2'));
PRAGMA json_execute_serialized_sql(
	'{"error":false,"statements":[{"node":{"type":"SELECT_NODE","modifiers":[],"cte_map":{"map":[]},"select_list":[{"class":"FUNCTION","type":"FUNCTION","alias":"","function_name":"+","schema":"","children":[{"class":"FUNCTION","type":"FUNCTION","alias":"","function_name":"+","schema":"","children":[{"class":"COLUMN_REF","type":"COLUMN_REF","alias":"","column_names":["a"]},{"class":"COLUMN_REF","type":"COLUMN_REF","alias":"","column_names":["b"]}],"filter":null,"order_bys":{"type":"ORDER_MODIFIER","orders":[]},"distinct":false,"is_operator":true,"export_state":false,"catalog":""},{"class":"COLUMN_REF","type":"COLUMN_REF","alias":"","column_names":["c"]}],"filter":null,"order_bys":{"type":"ORDER_MODIFIER","orders":[]},"distinct":false,"is_operator":true,"export_state":false,"catalog":""}],"from_table":{"type":"BASE_TABLE","alias":"","sample":null,"schema_name":"","table_name":"tbl2","column_name_alias":[],"catalog_name":""},"where_clause":null,"group_expressions":[],"group_sets":[],"aggregate_handling":"STANDARD_HANDLING","having":null,"sample":null,"qualify":null}}]}'
);
SELECT * FROM json_execute_serialized_sql(json_serialize_sql('WITH a(i) as (SELECT 1) SELECT a1.i as i1, a2.i as i2 FROM a as a1, a as a2'));
