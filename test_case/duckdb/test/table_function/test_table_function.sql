SELECT * FROM pragma_table_info('integers');
SELECT name FROM pragma_table_info('integers');
SELECT a.name, cid, value FROM pragma_table_info('integers') AS a INNER JOIN join_table ON a.name=join_table.name ORDER BY a.name;
SELECT cid, name FROM (SELECT * FROM pragma_table_info('integers')) AS a;
