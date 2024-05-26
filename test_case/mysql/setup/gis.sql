DROP TABLE IF EXISTS t1, gis_point, gis_line, gis_polygon, gis_multi_point, gis_multi_line, gis_multi_polygon, gis_geometrycollection, gis_geometry;
CREATE TABLE gis_point (fid INTEGER NOT NULL PRIMARY KEY, g POINT);
CREATE TABLE gis_line  (fid INTEGER NOT NULL PRIMARY KEY, g LINESTRING);
CREATE TABLE gis_polygon   (fid INTEGER NOT NULL PRIMARY KEY, g POLYGON);
CREATE TABLE gis_multi_point (fid INTEGER NOT NULL PRIMARY KEY, g MULTIPOINT);
CREATE TABLE gis_multi_line (fid INTEGER NOT NULL PRIMARY KEY, g MULTILINESTRING);
CREATE TABLE gis_multi_polygon  (fid INTEGER NOT NULL PRIMARY KEY, g MULTIPOLYGON);
CREATE TABLE gis_geometrycollection  (fid INTEGER NOT NULL PRIMARY KEY, g GEOMETRYCOLLECTION);
CREATE TABLE gis_geometry (fid INTEGER NOT NULL PRIMARY KEY, g GEOMETRY);
INSERT INTO gis_point VALUES 
(101, ST_PointFromText('POINT(10 10)')),
(102, ST_PointFromText('POINT(20 10)')),
(103, ST_PointFromText('POINT(20 20)')),
(104, ST_PointFromWKB(ST_AsWKB(ST_PointFromText('POINT(10 20)'))));
INSERT INTO gis_line VALUES
(105, ST_LineFromText('LINESTRING(0 0,0 10,10 0)')),
(106, ST_LineStringFromText('LINESTRING(10 10,20 10,20 20,10 20,10 10)')),
(107, ST_LineStringFromWKB(ST_AsWKB(LineString(Point(10, 10), Point(40, 10)))));
INSERT INTO gis_polygon VALUES
(108, ST_PolygonFromText('POLYGON((10 10,20 10,20 20,10 20,10 10))')),
(109, ST_PolyFromText('POLYGON((0 0,50 0,50 50,0 50,0 0), (10 10,20 10,20 20,10 20,10 10))')),
(110, ST_PolyFromWKB(ST_AsWKB(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(0, 0))))));
INSERT INTO gis_multi_point VALUES
(111, ST_MultiPointFromText('MULTIPOINT(0 0,10 10,10 20,20 20)')),
(112, ST_MPointFromText('MULTIPOINT(1 1,11 11,11 21,21 21)')),
(113, ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point(3, 6), Point(4, 10)))));
INSERT INTO gis_multi_line VALUES
(114, ST_MultiLineStringFromText('MULTILINESTRING((10 48,10 21,10 0),(16 0,16 23,16 48))')),
(115, ST_MLineFromText('MULTILINESTRING((10 48,10 21,10 0))')),
(116, ST_MLineFromWKB(ST_AsWKB(MultiLineString(LineString(Point(1, 2), Point(3, 5)), LineString(Point(2, 5), Point(5, 8), Point(21, 7))))));
INSERT INTO gis_multi_polygon VALUES
(117, ST_MultiPolygonFromText('MULTIPOLYGON(((28 26,28 0,84 0,84 42,28 26),(52 18,66 23,73 9,48 6,52 18)),((59 18,67 18,67 13,59 13,59 18)))')),
(118, ST_MPolyFromText('MULTIPOLYGON(((28 26,28 0,84 0,84 42,28 26),(52 18,66 23,73 9,48 6,52 18)),((59 18,67 18,67 13,59 13,59 18)))')),
(119, ST_MPolyFromWKB(ST_AsWKB(MultiPolygon(Polygon(LineString(Point(0, 3), Point(3, 3), Point(3, 0), Point(0, 3)))))));
INSERT INTO gis_geometrycollection VALUES
(120, ST_GeomCollFromText('GEOMETRYCOLLECTION(POINT(0 0), LINESTRING(0 0,10 10))')),
(121, ST_GeometryFromWKB(ST_AsWKB(GeometryCollection(Point(44, 6), LineString(Point(3, 6), Point(7, 9))))));
INSERT into gis_geometry SELECT * FROM gis_point;
INSERT into gis_geometry SELECT * FROM gis_line;
INSERT into gis_geometry SELECT * FROM gis_polygon;
INSERT into gis_geometry SELECT * FROM gis_multi_point;
INSERT into gis_geometry SELECT * FROM gis_multi_line;
INSERT into gis_geometry SELECT * FROM gis_multi_polygon;
INSERT into gis_geometry SELECT * FROM gis_geometrycollection;
