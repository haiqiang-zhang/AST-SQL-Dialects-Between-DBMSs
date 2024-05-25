ALTER TABLE t1 RENAME INDEX my_index TO foobar;
DROP TABLE t1;
CREATE TABLE t1 (
  col1 INT
, col2 INT
, INDEX idx1 ((ABS(col1)))
, INDEX idx2 ((col1 + 1), (col2 + 2)));
ALTER TABLE t1 DROP INDEX idx2;
DROP TABLE t1;
CREATE TABLE t1(j json, INDEX mv_idx((CAST(j AS UNSIGNED ARRAY))));
DROP TABLE t1;
CREATE TABLE t(
  x INT,
  KEY this_is_a_very_long_index_name_in_fact_it_is_64_characters_long_
  ((x+1), (x+2), (x+3))
);
DROP TABLE t;
CREATE TABLE t2 (c1 INT);
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
ALTER TABLE t1 RENAME INDEX myKEY TO renaMEDkey;
ALTER TABLE t1 DROP INDEX renamedkey;
DROP TABLE t1;
CREATE TABLE table1130 ( pk INTEGER AUTO_INCREMENT, a1 INTEGER NOT NULL, b1
INTEGER NULL, c1 BLOB NULL, d1 VARCHAR(2) NULL, PRIMARY KEY (pk), KEY
((COALESCE(a1))));
DROP TABLE table1130;
CREATE TABLE t1(a INT, b INT, c INT, UNIQUE INDEX i((a+b)));
DROP TABLE t1;
CREATE TABLE t1(
  e ENUM('a', 'bbb', 'cccccc')
, s SET('a', 'bbb', 'cccccc')
, b BIT(5)
, KEY ((NULLIF(e, null)))
, KEY ((NULLIF(s, null)))
, KEY ((NULLIF(b, null))));
DROP TABLE t1;
CREATE TABLE t1 (
  col1 INT
, INDEX idx1 ((SOUNDEX(col1))));
DROP TABLE t1;
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
CREATE TABLE t (x INTEGER, KEY ((x+1)));
SELECT * FROM t
WHERE x + 1 = JSON_CONTAINS(JSON_ARRAY(CAST('12:32:69' AS TIME)), 'false');
DROP TABLE t;
