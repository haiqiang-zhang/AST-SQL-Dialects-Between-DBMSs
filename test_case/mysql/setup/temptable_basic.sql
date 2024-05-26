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
