--   would be selected by GROUP BY and VARCHAR columns preserves
--   the spaces.
-- - SELECTs with GROUP test indexes with HASH algorithm.
-- - SELECTs with subqueries test indexes with BTREE algorithm.
--

--echo --
--echo -- Prepare
--echo --

SET @big_tables_saved = @@big_tables;
SET @optimizer_switch_saved = @@optimizer_switch;

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
SET @@optimizer_switch = "derived_merge=off";

SET SESSION big_tables = 0;
SET @@internal_tmp_mem_storage_engine = TempTable;
SELECT f1, COUNT(*) FROM table_varchar_no_pad GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_no_pad GROUP BY f1;
SELECT TRIM(f1), COUNT(*) FROM table_varchar_pad_space GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_pad_space GROUP BY f1;
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';

SET SESSION big_tables = 0;
SET @@internal_tmp_mem_storage_engine = MEMORY;
SELECT f1, COUNT(*) FROM table_varchar_no_pad GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_no_pad GROUP BY f1;
SELECT TRIM(f1), COUNT(*) FROM table_varchar_pad_space GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_pad_space GROUP BY f1;
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';

-- echo --
-- echo -- Restore default engine
-- echo --

SET @@internal_tmp_mem_storage_engine = default;

SET SESSION big_tables = 1;
SELECT f1, COUNT(*) FROM table_varchar_no_pad GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_no_pad GROUP BY f1;
SELECT TRIM(f1), COUNT(*) FROM table_varchar_pad_space GROUP BY f1;
SELECT f1, COUNT(*) FROM table_char_pad_space GROUP BY f1;
SELECT f1 FROM (SELECT * FROM table_varchar_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_no_pad) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_varchar_pad_space) AS dt WHERE f1 = 'ABC';
SELECT f1 FROM (SELECT * FROM table_char_pad_space) AS dt WHERE f1 = 'ABC';

SET SESSION big_tables = @big_tables_saved;
SET @@optimizer_switch = @optimizer_switch_saved;

DROP TABLE table_varchar_no_pad;
DROP TABLE table_char_no_pad;
DROP TABLE table_varchar_pad_space;
DROP TABLE table_char_pad_space;
