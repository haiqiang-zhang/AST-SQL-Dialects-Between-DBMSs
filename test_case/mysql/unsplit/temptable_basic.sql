CREATE TABLE t_int (c INT);
CREATE TABLE t_char (c CHAR(20));
CREATE TABLE t_varchar (c VARCHAR(20));
CREATE TABLE t_text (c TEXT);
CREATE TABLE t_blob (c BLOB);
CREATE TABLE t_json (c JSON);
CREATE TABLE t_point (c POINT);
CREATE TABLE t_geom (c GEOMETRY);
INSERT INTO t_int VALUES
	(1),
	(2),
	(2),
	(3),
	(4),
	(NULL);
INSERT INTO t_char VALUES
	('abcde'),
	('fghij'),
	('fghij'),
	('klmno  '),
	('stxyz'),
	(''),
	(NULL);
INSERT INTO t_varchar VALUES
	('abcde'),
	('fghij'),
	('fghij'),
	('klmno  '),
	('stxyz'),
	(''),
	(NULL);
INSERT INTO t_text VALUES
	('abcde'),
	('fghij'),
	('fghij'),
	('klmno  '),
	('stxyz'),
	(''),
	(NULL);
INSERT INTO t_blob VALUES
	('abcde'),
	('fghij'),
	('fghij'),
	('klmno  '),
	('stxyz'),
	(''),
	(NULL);
INSERT INTO t_json VALUES
	('{"k1": "value", "k2": [10, 20]}'),
	('["hot", "cold"]'),
	('["hot", "cold"]'),
	('["a", "b", 1]'),
	('{"key": "value"}'),
	(NULL);
INSERT INTO t_point VALUES
	(ST_PointFromText('POINT(10 10)')),
	(ST_PointFromText('POINT(50 10)')),
	(ST_PointFromText('POINT(50 10)')),
	(ST_PointFromText('POINT(-1 -2)')),
	(ST_PointFromText('POINT(10 50)')),
	(NULL);
INSERT INTO t_geom VALUES
	(ST_PointFromText('POINT(10 10)')),
	(ST_MultiPointFromText('MULTIPOINT(0 0,10 10,10 20,20 20)')),
	(ST_MultiPointFromText('MULTIPOINT(0 0,10 10,10 20,20 20)')),
	(ST_PolygonFromText('POLYGON((10 10,20 10,20 20,10 20,10 10))')),
	(ST_LineFromText('LINESTRING(0 0,0 10,10 0)')),
	(NULL);
SELECT DISTINCT * FROM
    t_int AS t1,
    t_int AS t2;
SELECT DISTINCT * FROM
    t_char AS t1,
    t_char AS t2;
SELECT DISTINCT * FROM
    t_varchar AS t1,
    t_varchar AS t2;
SELECT DISTINCT * FROM
    t_text AS t1,
    t_text AS t2;
SELECT DISTINCT * FROM
    t_blob AS t1,
    t_blob AS t2;
SELECT DISTINCT * FROM
    t_json AS t1,
    t_json AS t2;
SELECT DISTINCT ST_AsText(t1.c),ST_AsText(t2.c) FROM
    t_point AS t1,
    t_point AS t2;
SELECT c,COUNT(*) FROM t_int GROUP BY c;
SELECT ST_AsText(c),COUNT(*) FROM t_point GROUP BY c;
DROP TABLE t_int;
DROP TABLE t_char;
DROP TABLE t_varchar;
DROP TABLE t_text;
DROP TABLE t_blob;
DROP TABLE t_json;
DROP TABLE t_point;
DROP TABLE t_geom;
CREATE TABLE t_pk (
  pk INT NOT NULL,
  PRIMARY KEY (pk)
);
INSERT INTO t_pk VALUES
        (1),
	(2),
	(3);
DROP TABLE t_pk;
CREATE TABLE t_json(json_col JSON);
INSERT INTO t_json VALUES (
    '[
        { "name":"John Johnson", "nickname": {"stringValue": "Johnny"}},
        { "name":"John Smith"}
     ]'),
     ('[
        { "name":"John Smith"},
        { "name":"John Johnson", "nickname": {"stringValue": "Johnny"}}
     ]');
SELECT attrs.* FROM t_json, JSON_TABLE(json_col, '$[*]' COLUMNS (nickname JSON PATH '$.nickname')) as attrs;
DROP TABLE t_json;
CREATE TABLE t1 (
  pk INTEGER NOT NULL,
  f1 varchar(255)
);
INSERT INTO t1 VALUES (5,'N');
CREATE TABLE t2 (
  pk int,
  f2 varchar(10)
);
INSERT INTO t2 VALUES (5,'he');
INSERT INTO t2 VALUES (5,'l');
CREATE TABLE t3 (
  f2 varchar(10),
  f3 varchar(255)
);
INSERT INTO t3 VALUES ('L','2.0');
SELECT SUM(t3.f3)
FROM t1
  LEFT JOIN t2 ON t1.pk = t2.pk
  LEFT JOIN t3 ON t2.f2 = t3.f2
GROUP BY t1.f1;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (
  f1 CHAR(0) NOT NULL,
  f2 INT NOT NULL
);
INSERT INTO t1(f1, f2) VALUES('', 1);
SELECT AVG(f1) from t1 GROUP BY f2, f1;
DROP TABLE t1;
