select 1, ST_Intersects(ST_GeomFromText('POLYGON((0 0,20 0,20 20,0 20,0 0))'), ST_GeomFromText('POLYGON((10 10,30 10,30 30,10 30,10 10))'));
select 0, ST_Within(ST_GeomFromText('POLYGON((0 0,20 10,10 30, 0 0))'), ST_GeomFromText('POLYGON((10 10,30 20,20 40, 10 10))'));
create table t1 (g point);
insert into t1 values 
(ST_GeomFromText('POINT(2 2)')), (ST_GeomFromText('POINT(2 4)')), (ST_GeomFromText('POINT(2 6)')), (ST_GeomFromText('POINT(2 8)')),
(ST_GeomFromText('POINT(4 2)')), (ST_GeomFromText('POINT(4 4)')), (ST_GeomFromText('POINT(4 6)')), (ST_GeomFromText('POINT(4 8)')),
(ST_GeomFromText('POINT(6 2)')), (ST_GeomFromText('POINT(6 4)')), (ST_GeomFromText('POINT(6 6)')), (ST_GeomFromText('POINT(6 8)')),
(ST_GeomFromText('POINT(8 2)')), (ST_GeomFromText('POINT(8 4)')), (ST_GeomFromText('POINT(8 6)')), (ST_GeomFromText('POINT(8 8)'));
select ST_astext(g) from t1 where ST_Within(g, ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1))'));
select 'Contains';
select 'st_Intersects';
select 'Contains';
select 'Contains2';
DROP TABLE t1;
select ST_contains(ST_GeomFromText('MULTIPOLYGON(((0 0, 0 5, 5 5, 5 0, 0 0)), ((6 6, 6 11, 11 11, 11 6, 6 6)))'), ST_GeomFromText('POINT(5 10)'));
select ST_Disjoint(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((10 10, 10 15, 15 15, 15 10, 10 10))'));
select ST_Overlaps(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((10 10, 10 4, 4 4, 4 10, 10 10))'));
select ST_DISTANCE(ST_GeomFromText('polygon((0 0, 1 2, 2 1, 0 0))'), ST_GeomFromText('polygon((2 2, 3 4, 4 3, 2 2))'));
create table t1(geom geometrycollection);
select ST_astext(geom), ST_area(geom),ST_area(ST_buffer(geom,2)) from t1;
select ST_NUMPOINTS(ST_EXTERIORRING(ST_buffer(geom,2))) from t1;
DROP TABLE t1;
select st_touches(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'));
SELECT ST_Equals(ST_PolyFromText('POLYGON((67 13, 67 18, 67 18, 59 18, 59 13, 67 13) )'),ST_PolyFromText('POLYGON((67 13, 67 18, 59 19, 59 13, 59 13, 67 13) )')) as result;
SELECT ST_Equals(ST_PolyFromText('POLYGON((67 13, 67 18, 67 18, 59 18, 59 13, 67 13) )'),ST_PolyFromText('POLYGON((67 13, 67 18, 59 18, 59 13, 59 13, 67 13) )')) as result;
SELECT ST_Equals(ST_PointFromText('POINT (12 13)'),ST_PointFromText('POINT (12 13)')) as result;
select mbrcoveredby(ST_GeomFromText("point(2 4)"), ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"));
select mbrcontains(ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"), ST_GeomFromText("point(2 4)"));
select mbrcovers(ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"), ST_GeomFromText("point(2 4)"));
select mbrtouches(ST_GeomFromText("point (2 4)"), ST_GeomFromText("point (2 4)"));
select mbrwithin(ST_GeomFromText("point(2 4)"), ST_GeomFromText("point(2 4)"));
SELECT ST_ASTEXT(ST_TOUCHES(@a, ST_GEOMFROMTEXT('point(0 0)'))) t;
select ST_astext(ST_geomfromwkb(ST_AsWKB(st_intersection(linestring(point(-59,82),point(32,29)), point(2,-5))))) as result;
SELECT ST_AsText(ST_Symdifference(ST_GeomFromText('POLYGON((5 0,15 25,25 0,15 5,5 0))'),ST_GeomFromText('POLYGON((5 0,15 25,25 0,15 5,5 0))')));
SELECT st_equals(ST_GeomFromWKB(ST_AsWKB(Polygon(Linestring(Point(0, 0),Point(1, 0),Point(1, 1),Point(0, 1), Point(0, 0))))),
                                  ST_GeomFromText('POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'));
SELECT ST_equals(ST_GeomFromWKB(@plgnwkb), ST_GeomFromText('polygon((0 0, 1 0, 1 1, 0 1, 0 0))'));
select st_intersects(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                     st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_disjoint(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_contains(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_within(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_overlaps(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_crosses(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select ST_astext(st_difference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 0 1, 1 1, 1 0, 0 0))'))) as result;
select ST_astext(st_symdifference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 0 1, 1 1, 1 0, 0 0))'))) as result;
select ST_astext(ST_symdifference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 0, 0 0,0 1, 0 0))'))) as result;
SELECT ST_Equals(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 0, 0 0,0 1, 0 0))')) as result;
select ST_area(ST_PolygonFromText('POLYGON((10 10,20 10,20 20,10 20, 10 10))'));
select ST_AsText(ST_GeometryFromWKB(ST_AsWKB(GeometryCollection(POINT(0, 0),
                                                        MULTIPOINT(point(0, 0), point(1, 1)), LINESTRING(point(0, 0),point(10, 10)),
                                                        MULTILINESTRING(LINESTRING(point(1, 2), point(1, 3))),
                                                        POLYGON(LineString(Point(10, 20), Point(1, 1), Point(2, 2), Point(1, 1),
                                                                           Point(10, 20))), MULTIPOLYGON(Polygon(LineString(Point(0, 0), Point(1, 0),
                                                                                                                            Point(1, 1), Point(0, 0)))))))) as Result;
select ST_AsText(ST_GeometryFromWKB(ST_AsWKB(GeometryCollection(POINT(0, 0),
                                                      MULTIPOINT(point(0, 0), point(1, 1)), LINESTRING(point(0, 0),point(10, 10)),
                                                      MULTILINESTRING(LINESTRING(point(1, 2), point(1, 3))),
                                                      POLYGON(LineString(Point(10, 20), Point(1, 1), Point(2, 2), Point(10, 20))),
                                                      MULTIPOLYGON(Polygon(LineString(Point(0, 0), Point(1, 0), Point(1, 1),
                                                                                      Point(0, 0)))))))) as Result;
select st_astext(st_union(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))')));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION()'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
Select ST_Area(ST_PolygonFromText('POLYGON((0 0, 30 30, 30 0, 0 5, 0 0, 30 5, 30 0, 0 10, 0 0, 30 10, 30 0, 0 0))')) as Result;
Select ST_Area(ST_PolygonFromText('POLYGON((1 1, 10 1, 1 0, 10 0, 1 -1, 10 -1, 7 2, 7 -2, 4 2, 4 -2, 1 1))')) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (-1 -1, -10 -1, -10 -15, -1 -15, -1 -1))'))) as Result;
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 10 1, 10 20, 1 20, 1 1),(-1 -1, -10 -1, -10 -15, -1 -15, -1 -1)))'))) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (5 5, 6 5, 6 6, 5 6, 5 5))'))) as Result;
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 2 1, 2 3, 1 3, 1 1),(1 1, 2 1, 2 3, 1 3, 1 1)),((1 1, 2 1, 2 3, 1 3, 1 1)))'))) as Result;
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 2 1, 2 3, 1 3, 1 1),(1 1, 2 1, 2 3, 1 3, 1 1)),((20 20, 30 20, 30 40, 20 40, 20 20)))'))) as Result;
select ST_astext(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '0'),Point('-0', '0'), Point('0', '-0'))))) as result;
select ST_Astext(ST_Envelope(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '0'),Point('-0', '0'), Point('0', '-0')))))) as result;
select ST_astext(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '-0'),Point('-0', '0'), Point('0', '0'))))) as result;
select ST_Astext(ST_Envelope(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '-0'),Point('-0', '0'), Point('0', '0')))))) as result;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10,10 0),LINESTRING(0 0,10 0,10 -10,0 -10))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('MULTILINESTRING((0 0,0 10,10 10,10 0),(0 0,10 0,10 -10,0 -10))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 0,10 10,0 10),LINESTRING(0 0,10 0,10 -10,0 -10))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('MULTILINESTRING((0 0,10 0,10 10,0 10),(0 0,10 0,10 -10,0 -10))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)),POLYGON((0 0,10 0,10 -10,0 -10,0 0)))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('MULTIPOLYGON(((0 0,0 10,10 10,10 0,0 0)),((0 0,10 0,10 -10,0 -10,0 0)))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10,10 0,0 0),LINESTRING(0 0,10 0,10 -10,0 -10,0 0))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('MULTILINESTRING((0 0,0 10,10 10,10 0,0 0),(0 0,10 0,10 -10,0 -10,0 0))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(multipoint(0 0, 1 1, 2 2), LINESTRING(5 5, 10 10), point(-1 -1),POLYGON((0 0,0 10,10 10,10 0,0 0)),point(3 8), LINESTRING(0 1, 1 0, 2 2), MULTILINESTRING((3 3, 0 3, -3 0), (0 8, 0 0, 8 0)), point( 8 3), POLYGON((0 0,10 0,10 -10,0 -10,0 0)), MULTILINESTRING((4 4, 8 8, 8 4), (0 3, 3 0, 0 -3)), point(9 9), multipoint(10 10, 20 20))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 1, 1 0, 2 2), point(3 8), point( 8 3), MULTILINESTRING((3 3, 0 3, -3 0), (0 8, 0 0, 8 0)), LINESTRING(5 5, 10 10), multipoint(0 0, 1 1, 2 2), point(-1 -1), MULTILINESTRING((4 4, 8 8, 8 4), (0 3, 3 0, 0 -3)), point(9 9), multipoint(10 10, 20 20))'))) as ST_centroid;
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(point(3 8), point( 8 3), multipoint(0 0, 1 1, 2 2), point(-1 -1), point(9 9), multipoint(10 10, 20 20))'))) as ST_centroid;
SELECT ST_intersects(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_disjoint(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(0 -0)'))) =ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(-0 0)')));
select st_distance(ST_GeomFromText('geometrycollection(geometrycollection(),polygon((0 0,0 10,10 10,10 0,0 0)))'),ST_GeomFromText('linestring(0 0,10 10)'));
select st_distance_sphere(st_geomfromtext('point(-120 45)'), st_geomfromtext('point(30.24 68.37)'));
SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 10,5 15)'));
drop table if exists t1;
create table t1(a int)engine=innodb;
delete from t1 where
st_touches(
  linestring(point(4294967224,4294967212),
  point(-4398046511107,-4611686018427387904),
  point(4294967226,4294967293),
  point(4294967273,47)
),
multilinestring(linestring(point(1,2),point(1,2)),
  linestring(point(1,2),point(4294967270,4294967270))
)
);
drop table if exists t1;
select ST_GeomFromText("POLYGON((0 0, 0 10, 10 10, 10 0, 0 0))") into @a;
drop table if exists tbl_polygon;
create table tbl_polygon(id varchar(32), geom POLYGON);
insert into tbl_polygon (id, geom) values
('POLY1',ST_GeomFromText('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
insert into tbl_polygon (id, geom) values
('POLY2',ST_GeomFromText('POLYGON((0 0,0 -10,10 -10,10 0,0 0))'));
select 100, st_area(t.geom) from tbl_polygon t
where t.id like 'POLY%';
select 1, ST_touches(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';
drop table if exists tbl_polygon;
SELECT
ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((-7 -2,-9 3,-2 -8),(3 7,5 6,-7 -9,7 -1,-2 -8,2 9,4 6,-5 -5)),
                                               MULTILINESTRING((2 -2,2 -3,2 -1,-10 7,1 -2,-2 0,-9 -2,10 5,-7 -8,-9 -1,1 -1,-2 3,5 -9,-8 -9,-10 -9)),
                                               MULTIPOINT(-7 -5,6 9,7 4))'));
SELECT
ST_ASTEXT(ST_INTERSECTION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_DIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_SYMDIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_INTERSECTION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_DIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_DIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_DIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_SYMDIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_SYMDIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT
ST_ASTEXT(ST_SYMDIFFERENCE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(1 1), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))'))) as geom;
SELECT ST_AsText(ST_Union(ST_GeomFromText('MULTIPOINT(0 0,100 100)'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_AsText(ST_Difference(ST_GeomFromText('MULTIPOLYGON(((4 4,4 6,6 6,6 4, 4 4)),((0 0,0 10,10 10,10 0, 0 0)))'),
                            ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION()))'))) as result;
SELECT ST_AsText(ST_Difference(ST_GeomFromText('MULTILinestring((4 4,4 6,6 6,6 4),(0 0,0 10,10 10,10 0))'),
                            ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(GEOMETRYCOLLECTION()))'))) as result;
SELECT ST_AsText(ST_Union(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(MULTIPOINT(0 0,100 100), MULTIPOINT(1 1, 2 2)))'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_AsText(ST_Union(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(linestring(0 0,100 100), MULTIPOINT(1 1, 2 2)))'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_AsText(ST_Union(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(polygon((0 0,10 0, 10 10, 0 10, 0 0)), MULTIPOINT(1 1, 2 2)))'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_AsText(ST_Union(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(MULTIPOINT(0 0,100 100), linestring(1 1, 2 2)))'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_AsText(ST_Union(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(polygon((0 0,10 0, 10 10, 0 10, 0 0)), polygon((0 0, 1 0, 1 1, 0 1, 0 0))))'),
                       ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(),GEOMETRYCOLLECTION())'))) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POINT(0 0)'),
                  ST_GEOMFROMTEXT('POINT(0 0)'));
SELECT ST_WITHIN(ST_GEOMFROMTEXT('MULTIPOINT(0 0,5 5,10 10)'),ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
SELECT ST_CROSSES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 10)'),ST_GEOMFROMTEXT('POLYGON((0 0,5 0,5 5,0 5, 0 0))'));
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'), ST_GEOMFROMTEXT('MULTIPOINT(3 3,13 13)'));
SELECT ST_ASTEXT(ST_INTERSECTION(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'), 
                                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((4 4,4 6,6 6,6 4,4 4)),
                                                                     POLYGON((5 5,5 7,7 7,7 5,5 5)))'))) as result;
SELECT ST_ASTEXT(ST_UNION(ST_ENVELOPE(ST_GEOMFROMTEXT('LINESTRING(5 9,-1 10,-2 -6,2 9,2 0,3 6,-3 3,9 -2,-3 -10,-7 -4,1 4)')),
                       ST_UNION(ST_GEOMFROMTEXT('MULTILINESTRING((6 -8,10 -8,3 0,-6 1,0 8,-1 8,-3 -3,6 -6,0 6,1 -6,-1 7,8 3),(-9 -10,-4 0,0 1,-9 1,6 9,-8 7,-2 -6,2 10,-1 -5,3 -5,-1 -10))'), 
                                ST_GEOMFROMTEXT('MULTILINESTRING((8 7,2 6,-6 -8,-2 10,4 1,9 7,5 9,4 1,8 2,-2 10,8 -5))')))) as result;
SELECT ST_CONTAINS(ST_UNION(ST_INTERSECTION(ST_GEOMFROMTEXT('POINT(-3 3)'),
                                            ST_GEOMFROMTEXT('POLYGON((8 3,-2 9,-10 2,-10 -9,7 -1,4 1,7 6,5 -10,5 3,2 1,-10 0, 8 3))')), 
                            ST_CONVEXHULL(ST_GEOMFROMTEXT('MULTIPOINT(8 -8,-7 5)'))), 
                   ST_UNION(ST_GEOMFROMTEXT('POINT(4 1)'), 
                            ST_GEOMFROMTEXT('MULTIPOINT(-10 -10,5 -2,-6 -7,1 5,-3 0)'))) as result;
SELECT ST_CONTAINS(ST_UNION(ST_INTERSECTION(ST_GEOMFROMTEXT('POINT(-3 3)'),
                                            ST_GEOMFROMTEXT('POLYGON((8 3,-2 9,-10 2,-10 -9,7 -1,4 1,7 6,5 -10,5 3,2 1,-10 0, 8 3))')), 
                            ST_CONVEXHULL(ST_GEOMFROMTEXT('MULTIPOINT(8 -8,-7 5)'))), 
                   ST_UNION(ST_GEOMFROMTEXT('POINT(4 1)'), 
                            ST_GEOMFROMTEXT('MULTIPOINT(-10 -10,5 -2,-6 -7,1 5,-3 0)'))) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('POINT(0 0)'),
                          ST_GEOMFROMTEXT('POINT(180 0)')) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('POINT(0 0)'),
                          ST_GEOMFROMTEXT('MULTIPOINT(180 0)')) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('MULTIPOINT(0 0)'),
                          ST_GEOMFROMTEXT('MULTIPOINT(180 0)')) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('POINT(0 0)'),
                          ST_GEOMFROMTEXT('POINT(180 0)')) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('POINT(0 0)'),
                          ST_GEOMFROMTEXT('MULTIPOINT(180 0)')) as result;
SELECT ST_DISTANCE_SPHERE(ST_GEOMFROMTEXT('MULTIPOINT(0 0)'),
                          ST_GEOMFROMTEXT('MULTIPOINT(180 0)')) as result;
SELECT ST_VALIDATE(ST_GEOMFROMTEXT(@star_center,-1024));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('LINESTRING(0 0,5 0,10 0)'),
                  ST_GEOMFROMTEXT('MULTIPOINT(10 0)')) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('LINESTRING(0 0,5 0,10 0)'),
                  ST_GEOMFROMTEXT('MULTIPOINT(0 0,10 0)')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 5,5 5,5 0,0 0)),POLYGON((0 0,0 -5,-5 -5,-5 0,0 0)))'),ST_GEOMFROMTEXT('MULTIPOINT(4 2,-4 -2)')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((5 0,0 10,10 10, 5 0)),POLYGON((5 0,0 -10,10 -10, 5 0)))'),ST_GEOMFROMTEXT('MULTIPOINT(5 2,5 -2)')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0, 8 0, 8 8, 0 8,0 0)),POLYGON((0 0,-8 0,-8 -8, 0 -8, 0 0)))'),
                   ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTIPOlygon(((2 2,4 2, 4 4, 2 4, 2 2)), ((-2 -2, -4 -2, -4 -4, -2 -4, -2 -2))), MULTIPOINT(4 4, -4 -4))')) as result;
SELECT ST_EQUALS(ST_GEOMFROMTEXT('MULTIPOINT(2 2,3 3)'),ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(2 2),POINT(3 3))')) as result;
SELECT ST_EQUALS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTIPOlygon(((2 2,4 2, 4 4, 2 4, 2 2)), ((-2 -2, -4 -2, -4 -4, -2 -4, -2 -2))), MULTIPOINT(4 4, -4 -4))'),
                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POlygon((2 2,4 2, 4 4, 2 4, 2 2)), POLYGON((-2 -2, -4 -2, -4 -4, -2 -4, -2 -2)), POINT(4 4), POINT(-4 -4))')) as result;
select ST_Intersects(ST_GeomFromText('LINESTRING(15 10,10 0)'),ST_GeomFromText('POINT(15 10)')) as result;
select ST_Touches(ST_GeomFromText('LINESTRING(15 5,15 25)'),ST_GeomFromText('LINESTRING(15 5,15 25)')) as result;
select ST_Touches(ST_GeomFromText('POLYGON((0 0,5 0,5 5,0 5,0 0),(1 1,3 1,3 3,1 3,1 1))'),ST_GeomFromText('LINESTRING(3 3,10 10)')) as result;
select ST_Contains(ST_GeomFromText('POLYGON((0 0,5 0,5 5,0 5,0 0))'),ST_GeomFromText('LINESTRING(1 2,5 5)')) as result;
select ST_Crosses(ST_GeomFromText('MULTIPOINT(0 0,3 3)'),ST_GeomFromText('LINESTRING(1 1,10 10)')) as result;
select ST_Crosses(ST_GeomFromText('MULTIPOINT(1 0,15 0,10 10)'),ST_GeomFromText('MULTILINESTRING((15 0,20 0,20 20),(10 10,20 20,15 0))')) as result;
select ST_Crosses(ST_GeomFromText('MULTIPOINT(1 0,15 0,10 10)'),ST_GeomFromText('LINESTRING(15 0,20 0,10 10,20 20)')) as result;
select ST_Crosses(ST_GeomFromText('MULTIPOINT(1 0,15 0,10 10)'),ST_GeomFromText('MULTILINESTRING((15 0,20 0,20 20),(10 10,20 20,15 0))')) as result;
select ST_Crosses(ST_GeomFromText('MULTIPOINT(1 0,15 0,10 10)'),ST_GeomFromText('MULTILINESTRING((15 0,20 0,20 20,15 0))')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_DISJOINT(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_INTERSECTS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_EQUALS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_WITHIN(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_CROSSES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_OVERLAPS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_DISJOINT(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_INTERSECTS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_EQUALS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_WITHIN(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_CROSSES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_OVERLAPS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('POINT(0 0)')) as result;
SELECT ST_WITHIN(ST_GEOMFROMTEXT('MULTIPOINT(4 4,5 5)'),
                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0),(4 4,4 6,6 6,6 4,4 4)),POLYGON((4 4,4 6,6 6,6 4,4 4)))')) as result;
SELECT ST_WITHIN(ST_GEOMFROMTEXT('MULTIPOINT(4 4,3 3)'),
                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0),(4 4,4 6,6 6,6 4,4 4)),POLYGON((4 4,4 6,6 6,6 4,4 4)))')) as result;
SELECT ST_EQUALS(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'),
                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0),(4 4,4 6,6 6,6 4,4 4)),POLYGON((4 4,4 6,6 6,4 4)))')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 10,10 10,10 0,5 5,0 0)))'), ST_GEOMFROMTEXT('MULTIPOINT(2 9, 1 0)')) as result;
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('GeometryCollection(point(1 1), MULTIPOLYGON(((0 0,0 10,10 10,10 0,5 5,0 0))))'), ST_GEOMFROMTEXT('MULTIPOINT(2 9, 1 0)')) as result;
SELECT ST_ASTEXT(ST_SIMPLIFY(ST_GEOMFROMTEXT('MULTIPOINT(19 -4, -2 -6, -8 2)'), 1)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('POLYGON((0 0,10 0,10 10,0 10,0 0))'), -10));
SELECT
ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((12 -12,-15 19),(2 -9,-4 -8,18 3,-9 -8),(13 11,-15 9,-16 6,-17 5)),
                                                        LINESTRING(14 -16,-3 18,-13 -7,-10 1))'), 6561)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)), POLYGON((10 10,10 20,20 20,20 10,10 10)))'), -1)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 5,5 5,5 0,0 0)), POLYGON((10 10,10 20,20 20,20 10,10 10)))'), -1)) as result;
SELECT
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((5 0,0 10,10 10,5 0)),
                                                POLYGON((5 0,0 -10,10 -10,5 0)))'),
            ST_GEOMFROMTEXT('LINESTRING(5 -2,5 2)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((5 0,0 10,10 10,5 0)),
                                                POLYGON((5 0,0 -10,10 -10,5 0)))'),
            ST_GEOMFROMTEXT('MULTIPOINT(4 -3,4 2)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0, 2 0, 2 2, 0 2, 0 0)),
                                                POLYGON((2 0, 4 0, 4 2, 2 2, 2 0)))'),
ST_GEOMFROMTEXT('POLYGON((1 0, 3 0, 3 1, 1 1, 1 0))')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(0 0, 3 0), LINESTRING(3 0, 6 0))'),
ST_GEOMFROMTEXT('LINESTRING(2 0, 4 0)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(0 0, 3 0), LINESTRING(2 0, 2 8))'),
ST_GEOMFROMTEXT('LINESTRING(0 0, 2 0, 2 4)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(0 0, 3 0), LINESTRING(3 0, 6 0))'),
ST_GEOMFROMTEXT('MULTIPOINT(2 0, 4 0)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(0 0, 3 0), LINESTRING(2 0, 2 8))'),
ST_GEOMFROMTEXT('MULTIPOINT(0 0, 2 0, 2 4)')) as result;
SELECT 1,
ST_CONTAINS(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0, 3 0, 3 3, 0 3, 0 0)),
                                                LINESTRING(3 1, 5 1))'),
ST_GEOMFROMTEXT('LINESTRING(2 1, 4 1)')) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(POLYGON((5 0,0 10,10 10,5 0)),
                           POLYGON((5 0,0 -10,10 -10,5 0)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(POLYGON((0 0, 5 0, 5 5, 0 5,0 0)),
                           POLYGON((5 0,10 0, 10 3,5 3,5 0)))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(POLYGON((0 0, 3 0, 3 3, 0 3, 0 0)),
                           LINESTRING(0 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(POLYGON((0 0, 3 0, 3 3, 0 3, 0 0)),
                           LINESTRING(3 0, 3 1, 4 2))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(POLYGON((0 0, 3 0, 3 3, 0 3, 0 0)),
                           LINESTRING(3 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(LINESTRING(4 1, 6 1),
                           LINESTRING(0 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(LINESTRING(3 1, 6 1),
                           LINESTRING(0 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(LINESTRING(3 1, 3 3),
                           LINESTRING(0 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_AsText(ST_Union(ST_GEOMFROMTEXT(
       'GEOMETRYCOLLECTION(LINESTRING(3 0, 3 3),
                           LINESTRING(0 1, 4 1))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
select ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((0 -14,13 -8),(-5 -3,8 7),(-6 18,17 -11,-12 19,19 5),(16 11,9 -5),(17 -5,5 10),(-4 17,6 4),(-12 15,17 13,-18 11,15 10),(7 0,2 -16,-18 13,-6 4),(-17 -6,-6 -7,1 4,-18 0)),MULTILINESTRING((-11 -2,17 -14),(18 -12,18 -8),(-13 -16,9 16,9 -10,-7 20),(-14 -5,10 -9,4 1,17 -8),(-9 -4,-2 -12,9 -13,-5 4),(15 17,13 20)))'),
                         ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((-13 -18,-16 0),(17 11,-1 11,-18 -19,-4 -18),(-8 -8,-15 -13,3 -18,6 8)),LINESTRING(5 16,0 -9,-6 4,-15 17))'))) as result;
select ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((0 -14,13 -8),(-5 -3,8 7),(-6 18,17 -11,-12 19,19 5),(16 11,9 -5),(17 -5,5 10),(-4 17,6 4),(-12 15,17 13,-18 11,15 10),(7 0,2 -16,-18 13,-6 4),(-17 -6,-6 -7,1 4,-18 0)),MULTIPOINT(0 14,-9 -11),MULTILINESTRING((-11 -2,17 -14),(18 -12,18 -8),(-13 -16,9 16,9 -10,-7 20),(-14 -5,10 -9,4 1,17 -8),(-9 -4,-2 -12,9 -13,-5 4),(15 17,13 20)),MULTIPOINT(16 1,-9 -17,-16 6,-17 3),POINT(-18 13))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(7 0),MULTILINESTRING((-13 -18,-16 0),(17 11,-1 11,-18 -19,-4 -18),(-8 -8,-15 -13,3 -18,6 8)),LINESTRING(5 16,0 -9,-6 4,-15 17),MULTIPOINT(-9 -5,5 15,12 -11,12 11))'))) as result;
select ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((0 -14,13 -8),(-5 -3,8 7),(-6 18,17 -11,-12 19,19 5),(16 11,9 -5),(17 -5,5 10),(-4 17,6 4),(-12 15,17 13,-18 11,15 10),(7 0,2 -16,-18 13,-6 4),(-17 -6,-6 -7,1 4,-18 0)),GEOMETRYCOLLECTION(MULTIPOINT(0 14,-9 -11),MULTILINESTRING((-11 -2,17 -14),(18 -12,18 -8),(-13 -16,9 16,9 -10,-7 20),(-14 -5,10 -9,4 1,17 -8),(-9 -4,-2 -12,9 -13,-5 4),(15 17,13 20))),MULTIPOINT(16 1,-9 -17,-16 6,-17 3),POINT(-18 13))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(7 0),MULTILINESTRING((-13 -18,-16 0),(17 11,-1 11,-18 -19,-4 -18),(-8 -8,-15 -13,3 -18,6 8)),LINESTRING(5 16,0 -9,-6 4,-15 17),MULTIPOINT(-9 -5,5 15,12 -11,12 11))'))) as result;
select st_astext(geometrycollection()) as result;
select 1, @empty_geom = st_geomfromtext('geometrycollection()') as equal;
SELECT ST_ASTEXT(ST_ConvexHull(ST_GEOMFROMTEXT(
'MULTILINESTRING((0 10,10 0),(10 0,0 0),(0 0,10 10))'))) as result;
SELECT ST_ASTEXT(ST_ConvexHull(ST_GEOMFROMTEXT('MULTIPOINT(1 2, 1 2)')))
AS result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 1 0, 1 1, 0 1, 0 0))'),
st_geomfromtext('polygon((2 0, 3 0, 3 1, 2 1, 2 0))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 2 0, 2 1, 0 1, 0 0))'),
st_geomfromtext('polygon((1 0, 3 0, 3 1, 1 1, 1 0))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 1 0, 1 1, 0 1, 0 0))'),
st_geomfromtext('polygon((1 0, 2 0, 2 1, 1 1, 1 0))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 2 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 2 5, 3 3, 4 3, 4 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 2 5, 3 2, 6 2, 6 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 4 3, 4 2, 6 2, 6 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 4 3, 4 0, 6 0, 6 3, 5 3, 5 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 2 5, 3 3, 4 3, 4 2, 6 2, 6 5, 0 5))')))
as result;
select st_astext(st_intersection(
st_geomfromtext('polygon((0 0, 10 0, 10 3, 0 3, 0 0))'),
st_geomfromtext('polygon((0 5, 1 3, 2 5, 3 3, 4 3, 4 0,
                          10 0, 10 3, 6 3, 6 5, 0 5))')))
as result;
SELECT HEX(ST_AsWKB(ST_GeomFromText("POINT(10 10)    "))) as result;
SELECT HEX(ST_AsWKB(ST_GeomFromText("GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(10 10)), LINESTRING(0 0, 1 1), GEOMETRYCOLLECTION())   "))) as result;
SELECT ST_AsText(ST_GeomFromWKB(0x010100000000000000000024400000000000002440)) as result;
SELECT ST_AsText(ST_GeomFromWKB(0x01070000000300000001070000000100000001010000000000000000002440000000000000244001020000000200000000000000000000000000000000000000000000000000F03F000000000000F03F010700000000000000)) as result;
CREATE TABLE t2 (id INT PRIMARY KEY AUTO_INCREMENT, g GEOMETRY NOT
                 NULL SRID 0, SPATIAL INDEX(g)) ENGINE=INNODB;
INSERT INTO t2(g) VALUES (ST_GEOMFROMTEXT('POINT(0 0)'));
INSERT INTO t2(g) VALUES (ST_GEOMFROMTEXT('POINT(10 0)'));
INSERT INTO t2(g) VALUES (ST_GEOMFROMTEXT('POINT(10 10)'));
SELECT id FROM t2;
DROP TABLE t2;
CREATE TABLE t3 (id INT PRIMARY KEY, g GEOMETRY NOT NULL SRID 0,
                 SPATIAL INDEX(g)) ENGINE=INNODB;
INSERT INTO t3(id, g) VALUES
(1, ST_GEOMFROMTEXT('POINT(0 0)')),
(2, ST_GEOMFROMTEXT('POINT(10 0)')),
(3, ST_GEOMFROMTEXT('POINT(10 10)'));
SELECT id FROM t3;
DROP TABLE t3;
SELECT ST_X(ST_PointFromText('POINT(.0  0)'));
SELECT ST_Y(ST_PointFromText('point(0  .0)'));
CREATE TABLE t1 (col_1 CHAR(7));
INSERT INTO t1 VALUES ('POINT(.');
DROP TABLE t1;
