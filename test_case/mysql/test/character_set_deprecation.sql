SELECT _utf8mb3'abc';
SELECT n'abc';
SELECT CONVERT ( 'abc' USING utf8mb3 );
SELECT CAST( 'abc' AS NATIONAL CHAR );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET utf8mb3;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "utf8mb3";
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'utf8mb3';
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `utf8mb3`;
CREATE TABLE t5 ( a NATIONAL CHAR(1) );
CREATE TABLE t6 ( a NCHAR(1) );
CREATE TABLE t7 ( a NCHAR );
CREATE TABLE t8 ( a NVARCHAR(1) );
DROP TABLE t1, t2, t3, t4, t5, t6, t7, t8;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET utf8mb3 PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET "utf8mb3" PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET 'utf8mb3' PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET `utf8mb3` PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p NATIONAL CHAR(1) PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NCHAR(1) PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NCHAR PATH '$.a')) AS t;
SELECT * FROM json_table('[]', '$[*]' COLUMNS (p NVARCHAR(1) PATH '$.a')) AS t;
SELECT HEX(_ucs2'abc');
SELECT CONVERT ( 'abc' USING ucs2 );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET ucs2 COLLATE ucs2_persian_ci;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "ucs2" COLLATE ucs2_persian_ci;
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'ucs2' COLLATE ucs2_persian_ci;
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `ucs2`COLLATE ucs2_persian_ci;
DROP TABLE t1, t2, t3, t4;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET ucs2 COLLATE ucs2_persian_ci PATH '$.a')) AS t;
SELECT CONVERT ( 'abc' USING macroman );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET macroman COLLATE macroman_general_ci;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "macroman" COLLATE macroman_general_ci;
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'macroman' COLLATE macroman_general_ci;
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `macroman`COLLATE macroman_general_ci;
DROP TABLE t1, t2, t3, t4;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET macroman COLLATE macroman_general_ci PATH '$.a')) AS t;
SELECT CONVERT ( 'abc' USING macce );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET macce COLLATE macce_general_ci;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "macce" COLLATE macce_general_ci;
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'macce' COLLATE macce_general_ci;
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `macce`COLLATE macce_general_ci;
DROP TABLE t1, t2, t3, t4;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET macce COLLATE macce_general_ci PATH '$.a')) AS t;
SELECT @@character_set_results;
SELECT @@character_set_results;
SELECT @@character_set_results;
SELECT CONVERT ( 'abc' USING dec8 );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET  dec8  COLLATE dec8_swedish_ci;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "dec8" COLLATE dec8_swedish_ci;
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'dec8' COLLATE dec8_swedish_ci;
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `dec8` COLLATE dec8_swedish_ci;
DROP TABLE t1, t2, t3, t4;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET dec8 COLLATE dec8_swedish_ci PATH '$.a')) AS t;
SELECT CONVERT ( 'abc' USING hp8 );
CREATE TABLE t1 ( a CHAR(1) ) CHARACTER SET  hp8  COLLATE hp8_english_ci;
CREATE TABLE t2 ( a CHAR(1) ) CHARACTER SET "hp8" COLLATE hp8_english_ci;
CREATE TABLE t3 ( a CHAR(1) ) CHARACTER SET 'hp8' COLLATE hp8_english_ci;
CREATE TABLE t4 ( a CHAR(1) ) CHARACTER SET `hp8` COLLATE hp8_english_ci;
DROP TABLE t1, t2, t3, t4;
SELECT * FROM json_table('[]', '$[*]'
  COLUMNS (p CHAR(1) CHARACTER SET hp8 COLLATE hp8_english_ci PATH '$.a')) AS t;
