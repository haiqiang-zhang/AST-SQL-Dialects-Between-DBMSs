PRAGMA enable_verification;
CREATE TABLE integers(i INTEGER, j INTEGER);;
SELECT blablabla FROM pragma_table_info('integers');;
CREATE TABLE join_table(name VARCHAR, value INTEGER);;
INSERT INTO join_table VALUES ('i', 33), ('j', 44);
SELECT * FROM pragma_table_info('integers');;
SELECT name FROM pragma_table_info('integers');;
SELECT a.name, cid, value FROM pragma_table_info('integers') AS a INNER JOIN join_table ON a.name=join_table.name ORDER BY a.name;;
SELECT cid, name FROM (SELECT * FROM pragma_table_info('integers')) AS a;
