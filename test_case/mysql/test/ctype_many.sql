
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
DROP TABLE IF EXISTS t1;

SET CHARACTER SET koi8r;

CREATE TABLE t1 (
  comment CHAR(32) ASCII NOT NULL,
  koi8_ru_f CHAR(32) CHARACTER SET koi8r NOT NULL default ''
) CHARSET=latin5;
ALTER TABLE t1 CHANGE comment comment CHAR(32) CHARACTER SET latin2 NOT NULL;
ALTER TABLE t1 ADD latin5_f CHAR(32) NOT NULL;
ALTER TABLE t1 DEFAULT CHARSET=latin2;
ALTER TABLE t1 ADD latin2_f CHAR(32) NOT NULL;
ALTER TABLE t1 DROP latin2_f, DROP latin5_f;

INSERT INTO t1 (koi8_ru_f,comment) VALUES ('a','LAT SMALL A');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('b','LAT SMALL B');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('c','LAT SMALL C');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('d','LAT SMALL D');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('e','LAT SMALL E');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('f','LAT SMALL F');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('g','LAT SMALL G');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('h','LAT SMALL H');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('i','LAT SMALL I');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('j','LAT SMALL J');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('k','LAT SMALL K');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('l','LAT SMALL L');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('m','LAT SMALL M');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('n','LAT SMALL N');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('o','LAT SMALL O');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('p','LAT SMALL P');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('q','LAT SMALL Q');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('r','LAT SMALL R');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('s','LAT SMALL S');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('t','LAT SMALL T');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('u','LAT SMALL U');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('v','LAT SMALL V');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('w','LAT SMALL W');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('x','LAT SMALL X');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('y','LAT SMALL Y');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('z','LAT SMALL Z');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('A','LAT CAPIT A');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('B','LAT CAPIT B');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('C','LAT CAPIT C');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('D','LAT CAPIT D');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('E','LAT CAPIT E');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('F','LAT CAPIT F');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('G','LAT CAPIT G');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('H','LAT CAPIT H');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('I','LAT CAPIT I');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('J','LAT CAPIT J');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('K','LAT CAPIT K');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('L','LAT CAPIT L');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('M','LAT CAPIT M');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('N','LAT CAPIT N');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('O','LAT CAPIT O');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('P','LAT CAPIT P');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('Q','LAT CAPIT Q');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('R','LAT CAPIT R');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('S','LAT CAPIT S');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('T','LAT CAPIT T');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('U','LAT CAPIT U');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('V','LAT CAPIT V');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('W','LAT CAPIT W');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('X','LAT CAPIT X');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('Y','LAT CAPIT Y');
INSERT INTO t1 (koi8_ru_f,comment) VALUES ('Z','LAT CAPIT Z');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL A');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL BE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL VE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL GE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL DE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL IE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL IO');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL ZHE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL ZE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL I');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL KA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL EL');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL EM');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL EN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL O');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL PE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL ER');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL ES');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL TE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL U');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL EF');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL HA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL TSE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL CHE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL SHA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL SCHA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL HARD SIGN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL YERU');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL SOFT SIGN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL E');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL YU');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR SMALL YA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT A');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT BE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT VE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT GE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT DE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT IE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT IO');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT ZHE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT ZE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT I');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT KA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT EL');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT EM');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT EN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT O');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT PE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT ER');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT ES');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT TE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT U');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT EF');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT HA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT TSE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT CHE');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT SHA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT SCHA');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT HARD SIGN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT YERU');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT SOFT SIGN');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT E');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT YU');
INSERT INTO t1 (koi8_ru_f,comment) VALUES (_koi8r'�','CYR CAPIT YA');

SET CHARACTER SET utf8mb3;
SELECT koi8_ru_f,MIN(comment),COUNT(*) FROM t1 GROUP BY 1;

ALTER TABLE t1 ADD utf8_f CHAR(32) CHARACTER SET utf8mb3 NOT NULL default '';
UPDATE t1 SET utf8_f=CONVERT(koi8_ru_f USING utf8mb3);
SET CHARACTER SET koi8r;
SELECT * FROM t1;


ALTER TABLE t1 ADD bin_f CHAR(1) BYTE NOT NULL default '';
UPDATE t1 SET bin_f=koi8_ru_f;
SELECT COUNT(DISTINCT bin_f),COUNT(DISTINCT koi8_ru_f),COUNT(DISTINCT utf8_f) FROM t1;

SELECT koi8_ru_f,MIN(comment) FROM t1 GROUP BY 1;
SELECT utf8_f,MIN(comment) FROM t1 GROUP BY 1;
SELECT DISTINCT koi8_ru_f FROM t1;
SELECT DISTINCT utf8_f FROM t1;
SELECT lower(koi8_ru_f) FROM t1 ORDER BY 1 DESC;
SELECT lower(utf8_f) FROM t1 ORDER BY 1 DESC;

SELECT t11.comment,t12.comment 
FROM t1 t11,t1 t12 WHERE CONVERT(t11.koi8_ru_f USING utf8mb3)=t12.utf8_f
ORDER BY t11.koi8_ru_f,t11.comment,t12.comment;

SELECT t11.comment,t12.comment 
FROM t1 t11,t1 t12 
WHERE t11.koi8_ru_f=CONVERT(t12.utf8_f USING koi8r)
ORDER BY t12.utf8_f,t11.comment,t12.comment;

SET CHARACTER SET utf8mb3;
ALTER TABLE t1 ADD ucs2_f CHAR(32) CHARACTER SET ucs2;
ALTER TABLE t1 CHANGE ucs2_f ucs2_f CHAR(32) UNICODE NOT NULL;

INSERT INTO t1 (ucs2_f,comment) VALUES (0x0391,'GREEK CAPIT ALPHA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0392,'GREEK CAPIT BETA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0393,'GREEK CAPIT GAMMA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0394,'GREEK CAPIT DELTA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0395,'GREEK CAPIT EPSILON');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x03B1,'GREEK SMALL ALPHA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x03B2,'GREEK SMALL BETA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x03B3,'GREEK SMALL GAMMA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x03B4,'GREEK SMALL DELTA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x03B5,'GREEK SMALL EPSILON');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0531,'ARMENIAN CAPIT AYB');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0532,'ARMENIAN CAPIT BEN');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0533,'ARMENIAN CAPIT GIM');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0534,'ARMENIAN CAPIT DA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0535,'ARMENIAN CAPIT ECH');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0536,'ARMENIAN CAPIT ZA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0561,'ARMENIAN SMALL YAB');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0562,'ARMENIAN SMALL BEN');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0563,'ARMENIAN SMALL GIM');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0564,'ARMENIAN SMALL DA');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0565,'ARMENIAN SMALL ECH');
INSERT INTO t1 (ucs2_f,comment) VALUES (0x0566,'ARMENIAN SMALL ZA');

ALTER TABLE t1 ADD armscii8_f CHAR(32) CHARACTER SET armscii8 NOT NULL;
ALTER TABLE t1 ADD greek_f CHAR(32) CHARACTER SET greek NOT NULL;
UPDATE t1 SET greek_f=CONVERT(ucs2_f USING greek) WHERE comment LIKE _latin2'GRE%';
UPDATE t1 SET armscii8_f=CONVERT(ucs2_f USING armscii8) WHERE comment LIKE _latin2'ARM%';
UPDATE t1 SET utf8_f=CONVERT(ucs2_f USING utf8mb3) WHERE utf8_f=_utf8mb3'';
UPDATE t1 SET ucs2_f=CONVERT(utf8_f USING ucs2) WHERE ucs2_f=_ucs2'';
SELECT comment, koi8_ru_f, utf8_f, hex(bin_f), ucs2_f, armscii8_f, greek_f FROM t1;
SET CHARACTER SET 'binary';
SELECT * FROM t1;
SELECT min(comment),count(*) FROM t1 GROUP BY ucs2_f;
DROP TABLE t1;

-- End of 4.1 tests


--echo --
--echo -- Start of 5.1 tests
--echo --

--echo --
--echo -- Bug#58371 Assertion failed: !s.uses_buffer_owned_by(this) with format string function
--echo --

SET NAMES latin1;
                AS BINARY(0)) USING utf8mb3);

CREATE TABLE t1 (
  utf8mb3 CHAR CHARACTER SET utf8mb3,
  utf8mb4 CHAR CHARACTER SET utf8mb4,
  ucs2 CHAR CHARACTER SET ucs2,
  utf16 CHAR CHARACTER SET utf16,
  utf32 CHAR CHARACTER SET utf32
);
INSERT INTO t1 VALUES ('','','','','');

-- utf8mb4 and utf32 are the only supersets for utf8mb3
SELECT CHARSET(CONCAT(utf8mb3, utf8mb4)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb3, ucs2)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb3, utf16)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb3, utf32)) FROM t1;


-- utf8mb4 is superset for everything
SELECT CHARSET(CONCAT(utf8mb4, utf8mb3)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb4, ucs2)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb4, utf16)) FROM t1;
SELECT CHARSET(CONCAT(utf8mb4, utf32)) FROM t1;


-- ucs2 is not a superset for the other Unicode character sets
--error ER_CANT_AGGREGATE_2COLLATIONS
SELECT CHARSET(CONCAT(ucs2, utf8mb3)) FROM t1;
SELECT CHARSET(CONCAT(ucs2, utf8mb4)) FROM t1;
SELECT CHARSET(CONCAT(ucs2, utf16)) FROM t1;
SELECT CHARSET(CONCAT(ucs2, utf32)) FROM t1;


-- utf16 is not a superset for the other Unicode character sets
--error ER_CANT_AGGREGATE_2COLLATIONS
SELECT CHARSET(CONCAT(utf16, utf8mb3)) FROM t1;
SELECT CHARSET(CONCAT(utf16, ucs2)) FROM t1;
SELECT CHARSET(CONCAT(utf16, utf8mb4)) FROM t1;
SELECT CHARSET(CONCAT(utf16, utf32)) FROM t1;


-- utf32 is a superset for the other Unicode character sets
SELECT CHARSET(CONCAT(utf32, utf8mb3)) FROM t1;
SELECT CHARSET(CONCAT(utf32, ucs2)) FROM t1;
SELECT CHARSET(CONCAT(utf32, utf8mb4)) FROM t1;
SELECT CHARSET(CONCAT(utf32, utf16)) FROM t1;

DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET utf32);
CREATE TABLE t2 (a VARCHAR(10) CHARACTER SET ucs2);
INSERT INTO t1 VALUES (0x10082), (0x12345);
INSERT INTO t2 SELECT * FROM t1;
SELECT HEX(a) FROM t2;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (a CHAR(1) CHARSET utf8mb3);
INSERT INTO t1 VALUES ('a'), ('b');
CREATE TABLE t2 (a BINARY(1));
INSERT INTO t2 VALUES ('x'),('z');
SELECT * FROM t2 WHERE a=(SELECT a FROM t1) AND a=_LATIN1'x';
DROP TABLE t2;
DROP TABLE t1;
SET sql_mode = default;
