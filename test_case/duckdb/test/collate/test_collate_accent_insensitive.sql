CREATE TABLE collate_test(s VARCHAR COLLATE NOACCENT);
INSERT INTO collate_test VALUES ('Mühleisen'), ('Hëllö');
SELECT * FROM collate_test WHERE s='mühleisen';
CREATE TABLE collate_join_table(s VARCHAR, i INTEGER);
INSERT INTO collate_join_table VALUES ('Hello', 1), ('Muhleisen', 3);
DROP TABLE collate_test;
CREATE TABLE collate_test(s VARCHAR COLLATE NOACCENT);
INSERT INTO collate_test VALUES ('Hällo'), ('Hallo'), ('Hello');
DROP TABLE collate_test;
CREATE TABLE collate_test(s VARCHAR COLLATE NOACCENT);
INSERT INTO collate_test VALUES ('Hällo'), ('Hallo');
SELECT * FROM collate_test WHERE s='Muhleisen';
SELECT * FROM collate_test WHERE s='Hello';
SELECT collate_test.s, collate_join_table.s, i FROM collate_test JOIN collate_join_table ON (collate_test.s=collate_join_table.s) ORDER BY 1;
SELECT * FROM collate_test ORDER BY s;
SELECT DISTINCT s FROM collate_test;
