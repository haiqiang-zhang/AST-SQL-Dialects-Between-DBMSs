
CREATE TABLE t1 (
  str_col VARCHAR(255),
  dbl_col DOUBLE,
  decimal_col DECIMAL(5, 2),
  date_col DATE,
  time_col TIME,
  time_with_fractions_col TIME(6),
  datetime_col DATETIME,
  datetime_with_fractions_col DATETIME(6),
  json_col JSON,
  dbl_with_length DOUBLE(4, 2),
  unsigned_int INT UNSIGNED,
  geometry_col POINT,
  INDEX idx1 ((CONVERT(SUBSTRING(str_col, 2, 1) USING latin1))),
  INDEX idx2 ((ABS(dbl_col))),
  INDEX idx3 ((TRUNCATE(decimal_col, 0))),
  INDEX idx4 ((YEAR(date_col))),
  INDEX idx5 ((ADDTIME('01:00:00', time_col))),
  INDEX idx6 ((ADDTIME('01:00:00', time_with_fractions_col))),
  INDEX idx7 ((DATE_SUB(datetime_col, INTERVAL 30 DAY))),
  INDEX idx8 ((DATE_SUB(datetime_with_fractions_col, INTERVAL 30 DAY))),
  INDEX idx9 ((JSON_VALID(json_col))),
  INDEX idx10 ((ROUND(dbl_col, 2))),
  INDEX idx11 ((dbl_with_length * 2.0)),
  INDEX idx12 ((ABS(unsigned_int))),
  INDEX idx13 ((ST_X(geometry_col)))
);

SET SESSION debug="+d,show_hidden_columns";
SET SESSION debug="-d,show_hidden_columns";
DROP TABLE t1;
CREATE TABLE t1 (col1 INT, INDEX my_index((FLOOR(col1))));
SET SESSION debug="+d,show_hidden_columns";
ALTER TABLE t1 RENAME INDEX my_index TO foobar;
SET SESSION debug="-d,show_hidden_columns";
DROP TABLE t1;
SET SESSION debug="+d,show_hidden_columns";
CREATE TABLE t1 (
  col1 INT
, col2 INT
, INDEX idx1 ((ABS(col1)))
, INDEX idx2 ((col1 + 1), (col2 + 2)));
ALTER TABLE t1 DROP INDEX idx2;
DROP TABLE t1;
SET SESSION debug="-d,show_hidden_columns";

-- Ensure that multi-valued index isn''t covering and index scan isn''t used
SET SESSION debug="+d,show_hidden_columns";
CREATE TABLE t1(j json, INDEX mv_idx((CAST(j AS UNSIGNED ARRAY))));
SELECT `!hidden!mv_idx!0!0` FROM t1;
SET SESSION debug="-d,show_hidden_columns";
DROP TABLE t1;

-- Ensure that we are allowed to create a functional index with a name
-- as long as the maximum column name length (64). The index name will
-- be truncated in the hidden column names in that case.
CREATE TABLE t(
  x INT,
  KEY this_is_a_very_long_index_name_in_fact_it_is_64_characters_long_
  ((x+1), (x+2), (x+3))
);
SET SESSION debug='+d,show_hidden_columns';
SET SESSION debug='-d,show_hidden_columns';
DROP TABLE t;
CREATE TABLE t2 (c1 INT);
CREATE INDEX name_collision ON t2((ABS(cq)));
DROP TABLE t2;
CREATE TABLE t1 (
  col1 INT,
  INDEX idx ((PI()))
);
DROP TABLE t1;
CREATE TABLE t1 (
  col1 VARCHAR(255),
  INDEX idx1 ((col1 * col1))
);
DROP TABLE t1;
CREATE TABLE table10_innodb_int_autoinc (
  col_int_key int(11) DEFAULT NULL,
  col_char_32_key char(32) DEFAULT NULL,
  col_char_32_not_null_key char(32) NOT NULL,
  pk int(11) NOT NULL AUTO_INCREMENT,
  col_int_not_null_key int(11) NOT NULL,
  PRIMARY KEY (pk),
  KEY col_int_key (col_int_key),
  KEY col_char_32_key (col_char_32_key),
  KEY col_char_32_not_null_key (col_char_32_not_null_key),
  KEY col_int_not_null_key (col_int_not_null_key),
  KEY i1 (((col_int_key + col_int_key))),
  KEY i2 (((col_int_key < 5))),
  KEY i3 (((col_int_key < 9))),
  KEY i5 (((col_int_not_null_key > 1)))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO table10_innodb_int_autoinc VALUES
  (43,'if','that',1,99)
, (1,'we','she',2,1203568640)
, (7,'f','kxc',3,40)
, (-1846411264,'xce','mean',4,5)
, (9,'r','c',5,0)
, (5,'ek','the',6,138)
, (77,'l','i',7,-1414922240)
, (1,'k','q',8,1)
, (-1284505600,'sa','w',9,8)
, (NULL,'ate','t',10,4);
DROP TABLE table10_innodb_int_autoinc;
CREATE TABLE t1 (
  col1 INT
, INDEX myKey ((ABS(col1))));

SET SESSION debug="+d,show_hidden_columns";
ALTER TABLE t1 DROP COLUMN `!HIdDEN!MYkEY!0!0`;
ALTER TABLE t1 RENAME INDEX myKEY TO renaMEDkey;
ALTER TABLE t1 DROP INDEX renamedkey;
DROP TABLE t1;
SET SESSION debug="-d,show_hidden_columns";
CREATE TABLE table1130 ( pk INTEGER AUTO_INCREMENT, a1 INTEGER NOT NULL, b1
INTEGER NULL, c1 BLOB NULL, d1 VARCHAR(2) NULL, PRIMARY KEY (pk), KEY
((COALESCE(a1))));
DROP TABLE table1130;
CREATE TABLE table29 (
  pk INTEGER AUTO_INCREMENT
, a1 VARCHAR(5) NOT NULL
, PRIMARY KEY (pk)
, KEY ((a1)));
CREATE TABLE t1(a INT, b INT, c INT, UNIQUE INDEX i((a+b)));
ALTER TABLE t1 ADD INDEX p(a9e26254e651465c89ff715d5733e97c);
ALTER TABLE t1 ADD INDEX g((a + a9e26254e651465c89ff715d5733e97c));
DROP TABLE t1;
CREATE TABLE table1286 (a1 BIT(24) NULL, KEY ((a1)));
CREATE TABLE  table276 ( pk INTEGER AUTO_INCREMENT, a1
SET('Nebraska','gfjzdfpngmbhvftlmiwrgduhdsbnkswbacwjvotkav','fjzdf') NULL,
PRIMARY KEY (pk), KEY ((a1)) );

CREATE TABLE t1(
  e ENUM('a', 'bbb', 'cccccc')
, s SET('a', 'bbb', 'cccccc')
, b BIT(5)
, KEY ((NULLIF(e, null)))
, KEY ((NULLIF(s, null)))
, KEY ((NULLIF(b, null))));
SET SESSION debug="+d,show_hidden_columns";
SET SESSION debug="-d,show_hidden_columns";
DROP TABLE t1;
CREATE TABLE table121 (
  pk INTEGER AUTO_INCREMENT
, a1 SET('Michigan','w','d') NOT NULL
, PRIMARY KEY (pk)
, KEY ((ST_Centroid(a1))));
CREATE TABLE t1 (
  col1 INT
, INDEX idx1 ((SOUNDEX(col1))));
SET SESSION debug="+d,show_hidden_columns";
SET SESSION debug="-d,show_hidden_columns";
DROP TABLE t1;
SET SESSION debug="+d,show_hidden_columns";
CREATE TABLE t1 (col1 INT, INDEX functional_index_1 ((col1 + 1)));
CREATE INDEX functional_index_2 ON t1 ((col1 + 2));
CREATE INDEX functional_index_3 ON t1 ((col1 + 3));
CREATE INDEX functional_index_4 ON t1 ((col1 + 4));
ALTER TABLE t1 ADD COLUMN col2 INT;
CREATE INDEX functional_index_5 ON t1 ((col1 + col2));
DROP TABLE t1;

CREATE TABLE t1 (
  col1 BIT(5),
  col2 BIT(10),
  KEY functional_index_1 ((NULLIF(col1, NULL))),
  KEY functional_index_2 ((NULLIF(col2, NULL)))
);
DROP TABLE t1;

SET SESSION debug="-d,show_hidden_columns";
CREATE TABLE t (x INTEGER, KEY ((x+1)));

-- The results are not interesting, we only want to see that we do not hit an
-- assertion.
--disable_result_log
SELECT * FROM t
WHERE x + 1 = JSON_CONTAINS(JSON_ARRAY(CAST('12:32:69' AS TIME)), 'false');
DROP TABLE t;
