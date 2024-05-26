SELECT pad_attribute FROM information_schema.collations
    WHERE collation_name = 'utf8mb4_0900_ai_ci';
SELECT pad_attribute FROM information_schema.collations
    WHERE collation_name = 'utf8mb4_general_ci';
CREATE TABLE table_char_no_pad (
    f1 CHAR(20) COLLATE utf8mb4_0900_ai_ci
);
INSERT INTO table_char_no_pad VALUES ('ABC  ');
INSERT INTO table_char_no_pad VALUES ('XYZ');
INSERT INTO table_char_no_pad VALUES ('XYZ ');
INSERT INTO table_char_no_pad VALUES ('ABC ');
CREATE TABLE table_varchar_no_pad (
    f1 VARCHAR(20) COLLATE utf8mb4_0900_ai_ci
);
INSERT INTO table_varchar_no_pad VALUES ('ABC  ');
INSERT INTO table_varchar_no_pad VALUES ('XYZ');
INSERT INTO table_varchar_no_pad VALUES ('XYZ ');
INSERT INTO table_varchar_no_pad VALUES ('ABC ');
CREATE TABLE table_char_pad_space (
    f1 CHAR(20) COLLATE utf8mb4_general_ci
);
INSERT INTO table_char_pad_space VALUES ('ABC  ');
INSERT INTO table_char_pad_space VALUES ('XYZ');
INSERT INTO table_char_pad_space VALUES ('XYZ ');
INSERT INTO table_char_pad_space VALUES ('ABC ');
CREATE TABLE table_varchar_pad_space (
    f1 VARCHAR(20) COLLATE utf8mb4_general_ci
);
INSERT INTO table_varchar_pad_space VALUES ('ABC  ');
INSERT INTO table_varchar_pad_space VALUES ('XYZ');
INSERT INTO table_varchar_pad_space VALUES ('XYZ ');
INSERT INTO table_varchar_pad_space VALUES ('ABC ');
SELECT f1, COUNT(*) FROM table_varchar_no_pad GROUP BY f1;
SELECT TRIM(f1), COUNT(*) FROM table_varchar_pad_space GROUP BY f1;
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';
DROP TABLE table_varchar_no_pad;
DROP TABLE table_char_no_pad;
DROP TABLE table_varchar_pad_space;
DROP TABLE table_char_pad_space;
