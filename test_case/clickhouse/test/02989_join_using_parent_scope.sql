SELECT 1 AS a FROM tb JOIN tabc USING (a) ORDER BY ALL;
SELECT a + 2 AS b FROM ta JOIN tabc USING (b) ORDER BY ALL;
SELECT b + 2 AS a FROM tb JOIN tabc USING (a) ORDER BY ALL;
SELECT a + 2 AS c FROM ta JOIN tabc USING (c) ORDER BY ALL;
SELECT b AS a, a FROM tb JOIN tabc USING (a) ORDER BY ALL;
SELECT a + 2 AS b FROM tb JOIN tabc USING (b) ORDER BY ALL
SETTINGS analyzer_compatibility_join_using_top_level_identifier = 0, allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS users;
CREATE TABLE users (uid Int16, name String, spouse_name String) ENGINE=Memory;
INSERT INTO users VALUES (1231, 'John', 'Ksenia');
INSERT INTO users VALUES (6666, 'Ksenia', '');
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS tabc;
DROP TABLE IF EXISTS ta;
DROP TABLE IF EXISTS tb;
DROP TABLE IF EXISTS tc;
