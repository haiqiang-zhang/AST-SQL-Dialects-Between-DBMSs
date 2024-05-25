SELECT * FROM table_for_rename ORDER BY key;
ALTER TABLE table_for_rename RENAME COLUMN value1 TO value4;
ALTER TABLE table_for_rename RENAME COLUMN value2 TO value5;
SHOW CREATE TABLE table_for_rename;
SELECT * FROM table_for_rename ORDER BY key;
SELECT '-- insert after rename --';
INSERT INTO table_for_rename SELECT toDate('2019-10-01') + number % 3, number, toString(number), toString(number + 1), toString(number + 2) from numbers(10, 10);
SELECT * FROM table_for_rename ORDER BY key;
SELECT '-- rename columns back --';
ALTER TABLE table_for_rename RENAME COLUMN value4 TO value1;
ALTER TABLE table_for_rename RENAME COLUMN value5 TO value2;
SHOW CREATE TABLE table_for_rename;
SELECT * FROM table_for_rename ORDER BY key;
SELECT '-- insert after rename column --';
INSERT INTO table_for_rename SELECT toDate('2019-10-01') + number % 3, number, toString(number), toString(number + 1), toString(number + 2) from numbers(20,10);
SELECT * FROM table_for_rename ORDER BY key;
DROP TABLE IF EXISTS table_for_rename;