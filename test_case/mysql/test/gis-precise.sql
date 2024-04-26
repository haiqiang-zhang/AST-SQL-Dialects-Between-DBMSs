
-- Disabled on Windows ASAN due to https://bugs.llvm.org/show_bug.cgi?id=35365
--source include/not_asan_windows.inc


--
-- Spatial objects
--

--disable_warnings
DROP TABLE IF EXISTS t1;

select 1, ST_Intersects(ST_GeomFromText('POLYGON((0 0,20 0,20 20,0 20,0 0))'), ST_GeomFromText('POLYGON((10 10,30 10,30 30,10 30,10 10))'));
select 0, ST_Intersects(ST_GeomFromText('POLYGON((0 0,20 10,10 30, 0 0))'), ST_GeomFromText('POLYGON((10 40, 40 50, 20 70, 10 40))'));
select 1, ST_Intersects(ST_GeomFromText('POLYGON((0 0,20 10,10 30, 0 0))'), ST_GeomFromText('POINT(10 10)'));
select 1, ST_Intersects(ST_GeomFromText('POLYGON((0 0,20 10,10 30, 0 0))'), ST_GeomFromText('POLYGON((10 10,30 20,20 40, 10 10))'));
select 0, ST_Within(ST_GeomFromText('POLYGON((0 0,20 10,10 30, 0 0))'), ST_GeomFromText('POLYGON((10 10,30 20,20 40, 10 10))'));
select 1, ST_Within(ST_GeomFromText('POLYGON((1 1,20 10,10 30, 1 1))'), ST_GeomFromText('POLYGON((0 0,30 5,10 40, 0 0))'));


create table t1 (g point);
insert into t1 values 
(ST_GeomFromText('POINT(2 2)')), (ST_GeomFromText('POINT(2 4)')), (ST_GeomFromText('POINT(2 6)')), (ST_GeomFromText('POINT(2 8)')),
(ST_GeomFromText('POINT(4 2)')), (ST_GeomFromText('POINT(4 4)')), (ST_GeomFromText('POINT(4 6)')), (ST_GeomFromText('POINT(4 8)')),
(ST_GeomFromText('POINT(6 2)')), (ST_GeomFromText('POINT(6 4)')), (ST_GeomFromText('POINT(6 6)')), (ST_GeomFromText('POINT(6 8)')),
(ST_GeomFromText('POINT(8 2)')), (ST_GeomFromText('POINT(8 4)')), (ST_GeomFromText('POINT(8 6)')), (ST_GeomFromText('POINT(8 8)'));

select ST_astext(g) from t1 where ST_Within(g, ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1))'));
select 'Contains';
select ST_astext(g) from t1 where ST_Contains(ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1))'), g);
select 'st_Intersects';
select ST_astext(g) from t1 where ST_Intersects(ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1))'), g);
select 'Contains';
select ST_astext(g) from t1 where ST_Contains(ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1))'), g);
select 'Contains2';
select ST_astext(g) from t1 where ST_Contains(ST_GeomFromText('POLYGON((5 1, 7 1, 7 7, 5 7, 3 3, 5 3, 5 1), (5.01 3.01, 6 5, 9 5, 8 3, 5.01 3.01))'), g);

DROP TABLE t1;

select 0, ST_Within(ST_GeomFromText('LINESTRING(15 15, 50 50, 60 60)'), ST_GeomFromText('POLYGON((10 10,30 20,20 40, 10 10))'));
select 1, ST_Within(ST_GeomFromText('LINESTRING(15 15, 16 16)'), ST_GeomFromText('POLYGON((10 10,30 20,20 40, 10 10))'));


select 1, ST_Intersects(ST_GeomFromText('LINESTRING(15 15, 50 50)'), ST_GeomFromText('LINESTRING(50 15, 15 50)'));
select 1, ST_Intersects(ST_GeomFromText('LINESTRING(15 15, 50 50)'), ST_GeomFromText('LINESTRING(16 16, 51 51)'));

select 1, ST_Intersects(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('POLYGON((50 5, 55 10, 0 45, 50 5))'));

select ST_astext(ST_Union(ST_geometryfromtext('point(1 1)'), ST_geometryfromtext('polygon((0 0, 2 0, 1 2, 0 0))')));
select ST_astext(ST_Intersection(ST_geometryfromtext('point(1 1)'), ST_geometryfromtext('polygon((0 0, 2 0, 1 2, 0 0))')));

select ST_Intersects(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('POLYGON((50 5, 55 10, 0 45, 50 5))'));
select ST_contains(ST_GeomFromText('MULTIPOLYGON(((0 0, 0 5, 5 5, 5 0, 0 0)), ((6 6, 6 11, 11 11, 11 6, 6 6)))'), ST_GeomFromText('POINT(5 10)'));
select ST_Disjoint(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((10 10, 10 15, 15 15, 15 10, 10 10))'));
select ST_Disjoint(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((10 10, 10 4, 4 4, 4 10, 10 10))'));
select ST_Overlaps(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((10 10, 10 4, 4 4, 4 10, 10 10))'));
select ST_Overlaps(ST_GeomFromText('POLYGON((0 0, 0 5, 5 5, 5 0, 0 0))'), ST_GeomFromText('POLYGON((1 1, 1 4, 4 4, 4 1, 1 1))'));

-- Distance tests
select ST_DISTANCE(ST_GeomFromText('polygon((0 0, 1 2, 2 1, 0 0))'), ST_GeomFromText('polygon((2 2, 3 4, 4 3, 2 2))'));
select ST_DISTANCE(ST_GeomFromText('polygon((0 0, 1 2, 2 1, 0 0))'), ST_GeomFromText('linestring(0 1, 1 0)'));
select ST_DISTANCE(ST_GeomFromText('polygon((0 0, 3 6, 6 3, 0 0))'), ST_GeomFromText('polygon((2 2, 3 4, 4 3, 2 2))'));
select ST_DISTANCE(ST_GeomFromText('polygon((0 0, 3 6, 6 3, 0 0),(2 2, 3 4, 4 3, 2 2))'), ST_GeomFromText('point(3 3)'));
select ST_DISTANCE(ST_GeomFromText('linestring(0 0, 3 6, 6 3, 0 0)'), ST_GeomFromText('polygon((2 2, 3 4, 4 3, 2 2))'));


-- Operations tests
select ST_astext(ST_Intersection(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('POLYGON((50 5, 55 10, 0 45, 50 5))')));
select ST_astext(ST_Intersection(ST_GeomFromText('LINESTRING(0 0, 50 45, 40 50, 0 0)'), ST_GeomFromText('LINESTRING(50 5, 55 10, 0 45, 50 5)')));
select ST_astext(ST_Intersection(ST_GeomFromText('LINESTRING(0 0, 50 45, 40 50)'), ST_GeomFromText('LINESTRING(50 5, 55 10, 0 45)')));
select ST_astext(ST_Intersection(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('POINT(20 20)')));
select ST_astext(ST_Intersection(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('LINESTRING(-10 -10, 200 200)')));
select ST_astext(ST_Intersection(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('LINESTRING(-10 -10, 200 200, 199 201, -11 -9)')));
select ST_astext(ST_UNION(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('LINESTRING(-10 -10, 200 200, 199 201, -11 -9)')));

select ST_astext(ST_intersection(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 1, 0 2, 0 0))')));

select ST_astext(ST_symdifference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 1, 0 2, 0 0))')));
select ST_astext(ST_UNION(ST_GeomFromText('POLYGON((0 0, 50 45, 40 50, 0 0))'), ST_GeomFromText('LINESTRING(-10 -10, 200 200, 199 201, -11 -9)')));

-- Buffer() tests
--replace_numeric_round 5
select ST_astext(ST_buffer(ST_geometryfromtext('point(1 1)'), 1));
create table t1(geom geometrycollection);
insert into t1 values (ST_GeomFromText('POLYGON((0 0, 10 10, 0 8, 0 0))'));
insert into t1 values (ST_GeomFromText('POLYGON((1 1, 10 10, 0 8, 1 1))'));
select ST_astext(geom), ST_area(geom),ST_area(ST_buffer(geom,2)) from t1;
select ST_NUMPOINTS(ST_EXTERIORRING(ST_buffer(geom,2))) from t1;

set @geom=ST_GeomFromText('LINESTRING(2 1, 4 2, 2 3, 2 5)');
set @buff=ST_buffer(@geom,1);
select ST_NUMPOINTS(ST_EXTERIORRING(@buff)) from t1;

-- cleanup
DROP TABLE t1;
select st_touches(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'));
select st_touches(ST_GeomFromText('point(1 1)'), ST_GeomFromText('point(1 1)'));
select st_touches(ST_GeomFromText('polygon((0 0, 2 2, 0 4, 0 0))'), ST_GeomFromText('point(1 1)'));
select st_touches(ST_GeomFromText('polygon((0 0, 2 2, 0 4, 0 0))'), ST_GeomFromText('point(1 0)'));
select st_touches(ST_GeomFromText('polygon((0 0, 2 2, 0 4, 0 0))'), ST_GeomFromText('point(1 2)'));
select st_touches(ST_GeomFromText('polygon((0 0, 2 2, 0 4, 0 0))'), ST_GeomFromText('polygon((1 1.2, 1 0, 2 0, 1 1.2))'));
select st_touches(ST_GeomFromText('polygon((0 0, 2 2, 0 4, 0 0))'), ST_GeomFromText('polygon((1 1, 1 0, 2 0, 1 1))'));
SELECT ST_Equals(ST_PolyFromText('POLYGON((67 13, 67 18, 67 18, 59 18, 59 13, 67 13) )'),ST_PolyFromText('POLYGON((67 13, 67 18, 59 19, 59 13, 59 13, 67 13) )')) as result;
SELECT ST_Equals(ST_PolyFromText('POLYGON((67 13, 67 18, 67 18, 59 18, 59 13, 67 13) )'),ST_PolyFromText('POLYGON((67 13, 67 18, 59 18, 59 13, 59 13, 67 13) )')) as result;
SELECT ST_Equals(ST_PointFromText('POINT (12 13)'),ST_PointFromText('POINT (12 13)')) as result;
select mbrcoveredby(ST_GeomFromText("point(2 4)"), ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"));
select mbrcontains(ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"), ST_GeomFromText("point(2 4)"));
select mbrcovers(ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"), ST_GeomFromText("point(2 4)"));
select mbrtouches(ST_GeomFromText("point (2 4)"), ST_GeomFromText("point (2 4)"));
select mbrtouches(ST_GeomFromText("point(2 4)"), ST_GeomFromText("linestring(2 0, 2 6)"));
select mbrtouches(ST_GeomFromText("point(2 4)"), ST_GeomFromText("linestring(2 0, 2 4)"));
select mbrtouches(ST_GeomFromText("point(2 4)"), ST_GeomFromText("polygon((2 2, 6 2, 6 6, 2 6, 2 2))"));
select mbrtouches(ST_GeomFromText("linestring(1 0, 2 0)"), ST_GeomFromText("polygon((0 0, 3 0, 3 3, 0 3, 0 0))"));
select mbrtouches(ST_GeomFromText("linestring(3 2, 4 2)"), ST_GeomFromText("polygon((0 0, 3 0, 3 3, 0 3, 0 0))"));
select mbrwithin(ST_GeomFromText("point(2 4)"), ST_GeomFromText("point(2 4)"));
select mbrwithin(ST_GeomFromText("point(2 4)"), ST_GeomFromText("linestring(2 0, 2 6)"));
select mbrwithin(ST_GeomFromText("point(2 4)"), ST_GeomFromText("linestring(2 0, 2 4)"));
select mbrwithin(ST_GeomFromText("point(2 4)"), ST_GeomFromText("polygon((2 2, 10 2, 10 10, 2 10, 2 2))"));
select mbrwithin(ST_GeomFromText("linestring(1 0, 2 0)"), ST_GeomFromText("linestring(0 0, 3 0)"));
select mbrwithin(ST_GeomFromText("linestring(1 0, 2 0)"), ST_GeomFromText("polygon((0 0, 3 0, 3 3, 0 3, 0 0))"));
select mbrwithin(ST_GeomFromText("linestring(1 1, 2 1)"), ST_GeomFromText("polygon((0 0, 3 0, 3 3, 0 3, 0 0))"));
select mbrwithin(ST_GeomFromText("linestring(0 1, 3 1)"), ST_GeomFromText("polygon((0 0, 3 0, 3 3, 0 3, 0 0))"));

SET @a=0x0000000001030000000200000005000000000000000000000000000000000000000000000000002440000000000000000000000000000024400000000000002440000000000000000000000000000024400000000000000000000000000000000000000000000000000000F03F000000000000F03F0000000000000040000000000000F03F00000000000000400000000000000040000000000000F03F0000000000000040000000000000F03F000000000000F03F;
SELECT ST_ASTEXT(ST_TOUCHES(@a, ST_GEOMFROMTEXT('point(0 0)'))) t;
select st_union((cast(linestring(point(6,-68), point(-22,-4)) as binary(13))),
                st_intersection(point(6,8),multipoint(point(3,1),point(-4,-6),point(1,6),point(-3,-5),point(5,4))));
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
select st_difference((convert(st_polygonfromwkb(linestring(point(1,1))) using gb18030)),
                     st_geomcollfromwkb(point(1,1)));
SET sql_mode = default;
select ST_astext(ST_geomfromwkb(ST_AsWKB(st_intersection(linestring(point(-59,82),point(32,29)), point(2,-5))))) as result;

SELECT ST_AsText(ST_Symdifference(ST_GeomFromText('POLYGON((5 0,15 25,25 0,15 5,5 0))'),ST_GeomFromText('POLYGON((5 0,15 25,25 0,15 5,5 0))')));
SELECT st_equals(ST_GeomFromWKB(ST_AsWKB(Polygon(Linestring(Point(0, 0),Point(1, 0),Point(1, 1),Point(0, 1), Point(0, 0))))),
                                  ST_GeomFromText('POLYGON((0 0, 1 0, 1 1, 0 1, 0 0))'));
SET @plgnwkb=0x0103000000010000000500000000000000000000000000000000000000000000000000F03F0000000000000000000000000000F03F000000000000F03F0000000000000000000000000000F03F00000000000000000000000000000000;

SELECT ST_equals(ST_GeomFromWKB(@plgnwkb), ST_GeomFromText('polygon((0 0, 1 0, 1 1, 0 1, 0 0))'));
select ST_astext(st_union(
             st_intersection(
                               multipoint(point(-1,-1)),
                               point(1,-1)
                                  ),
              st_difference(
                              multipoint(point(-1,1)),
                              point(-1,-1)
                                 )));
select ST_astext(st_union(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                       st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_intersection(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                              st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_difference(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                            st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_symdifference(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                               st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));


-- Empty collection and non-empty collection
select ST_astext(st_intersection(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                              st_difference(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_difference(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                            st_difference(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_symdifference(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                               st_difference(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));


-- Non-empty collection and empty collection
select ST_astext(st_union(ST_GeomFromText('multipoint(2 2, 3 3)'), st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_intersection(ST_GeomFromText('multipoint(2 2, 3 3)'), st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_symdifference(ST_GeomFromText('multipoint(2 2, 3 3)'), st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));
select ST_astext(st_difference(ST_GeomFromText('multipoint(2 2, 3 3)'), st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)'))));

-- Empty intermediate or final result
select ST_astext(st_difference(ST_GeomFromText('multipoint(2 2, 3 3)'), ST_GeomFromText('multipoint(0 0, 4 4)')));
select ST_astext(st_difference(ST_GeomFromText('multipoint(2 2, 3 3)'), ST_GeomFromText('multipoint(2 2, 3 3)')));
select ST_astext(st_symdifference(ST_GeomFromText('multipoint(2 2, 3 3)'), ST_GeomFromText('multipoint(0 0, 4 4)')));
select ST_astext(st_symdifference(ST_GeomFromText('multipoint(2 2, 3 3)'), ST_GeomFromText('multipoint(2 2, 3 3)')));

-- Spatial relation check operations involving empty geometry collections.
-- Empty collection and empty collection
select st_intersects(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                     st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_disjoint(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_equals(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_contains(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_within(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_touches(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_overlaps(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_crosses(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));


-- Empty collection and non-empty collection
select st_intersects(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                     st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_disjoint(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_equals(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_contains(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_within(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_touches(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_overlaps(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_crosses(st_intersection(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_union(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));


-- Non-empty collection and empty collection
select st_intersects(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                     st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_disjoint(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_equals(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_contains(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_within(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                 st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_touches(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_overlaps(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                   st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select st_crosses(st_union(ST_GeomFromText('point(1 1)'), ST_GeomFromText('multipoint(2 2, 3 3)')), 
                  st_intersection(ST_GeomFromText('point(0 0)'), ST_GeomFromText('point(1 1)')));
select
st_within(
           multipoint(point(4,2),point(-6,-8)),
           polygon(
                      linestring(point(13,0),point(13,0)),
                      linestring(point(2,4), point(2,4))
                         ));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection()'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(,)'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(point(0 0),)'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(,point(0 0))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection((point(0 0)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'));

-- Spatial set operations on nested geometry collections, which are flattened and
-- their basic components sent to BG algorithms.
SELECT ST_AsText(st_union(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                       ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_difference(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                            ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_intersection(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                              ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_symdifference(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                               ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1), Point(2 2)))')));
select
st_within(
           multipoint(point(4,2),point(-6,-8)),
           polygon(
                      linestring(point(13,0),point(13,0)),
                      linestring(point(2,4), point(2,4))
                         ));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection()'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(,)'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(point(0 0),)'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(,point(0 0))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection((point(0 0)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection())'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))'));
SELECT ST_AsText(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'));

-- Spatial set operations on nested geometry collections, which are flattened and
-- their basic components sent to BG algorithms.
SELECT ST_AsText(st_union(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                       ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_difference(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                            ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_intersection(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                              ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)))')));
SELECT ST_AsText(st_symdifference(ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1)), GeometryCollection(linestring(1 1, 2 2)))'),
                               ST_GeomFromText('GeometryCollection(GeometryCollection(Point(1 1), Point(2 2)))')));

select ST_astext(st_difference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 0 1, 1 1, 1 0, 0 0))'))) as result;

select ST_astext(st_symdifference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 0 1, 1 1, 1 0, 0 0))'))) as result;
select ST_astext(ST_symdifference(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 0, 0 0,0 1, 0 0))'))) as result;

SELECT ST_Equals(ST_GeomFromText('polygon((0 0, 1 0, 0 1, 0 0))'), ST_GeomFromText('polygon((0 0, 1 0, 0 0,0 1, 0 0))')) as result;



select ST_astext(ST_PolyFromWKB(ST_AsWKB(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(1, 0), Point(0, 0))))));
 select ST_AsText(ST_PolygonFromText('POLYGON((10 10,20 10,20 20,10 20, 10 10))'));
 select ST_area(ST_PolygonFromText('POLYGON((10 10,20 10,20 20,10 20, 10 10))'));

 select ST_AsText(Polygon(LineString(Point(0, 0), Point(1, 0), Point(1,1), Point(0, 1), Point(0, 0))));

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

select st_touches(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))'));
select st_overlaps(ST_GeometryFromText('geometrycollection(polygon((0 0, 2 0, 2 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 3 0, 3 1, 1 1, 1 0)))'));
select st_crosses(ST_GeometryFromText('geometrycollection(multipoint(0 0, 1 0, 1 1, 0 1, 0 0))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))'));
select st_astext(st_union(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))')));
select st_astext(st_union(ST_GeometryFromText('geometrycollection(polygon((0 0, 2 0, 2 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 3 0, 3 1, 1 1, 1 0)))')));
select st_astext(st_intersection(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))')));
select st_astext(st_intersection(ST_GeometryFromText('geometrycollection(polygon((0 0, 2 0, 2 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 3 0, 3 1, 1 1, 1 0)))')));
select st_astext(st_difference(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))')));
select st_astext(st_difference(ST_GeometryFromText('geometrycollection(polygon((0 0, 2 0, 2 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 3 0, 3 1, 1 1, 1 0)))')));
select st_astext(st_symdifference(ST_GeometryFromText('geometrycollection(polygon((0 0, 1 0, 1 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 2 0, 2 1, 1 1, 1 0)))')));
select st_astext(st_symdifference(ST_GeometryFromText('geometrycollection(polygon((0 0, 2 0, 2 1, 0 1, 0 0)))'), ST_GeometryFromText('geometrycollection(polygon((1 0, 3 0, 3 1, 1 1, 1 0)))')));

select ST_astext(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(1, 0), Point(0, 0))));
select ST_astext(ST_envelope(ST_PolyFromWKB(ST_AsWKB(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(1, 0), Point(0, 0)))))));
select ST_astext(ST_centroid(ST_PolyFromWKB(ST_AsWKB(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(1, 0), Point(0, 0)))))));
select ST_astext(ST_convexhull(ST_PolyFromWKB(ST_AsWKB(Polygon(LineString(Point(0, 0), Point(30, 0), Point(30, 30), Point(1, 0), Point(0, 0)))))));


SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POINT(10 10),MULTIPOINT(0 0,10 10))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POINT(10 10),MULTIPOINT(0 0,10 10))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('linestring(0 0, 1 1, 2 2)')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multipoint(0 0, 1 1, 2 2)')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multilinestring((0 0, 1 1, 2 2), (3 3, 4 4, 5 5))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('polygon((0 0, 1 1, 2 2, 0 0), (3 3, 4 4, 5 5, 3 3))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multipolygon(((0 0, 1 1, 2 2, 0 0), (3 3, 4 4, 5 5, 3 3)), ((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('geometrycollection(polygon((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)), polygon((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multipolygon(((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)), ((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multipolygon(((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('polygon((0 0, 1 0, 1 1, 0 1, 0 0))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('multipoint(0 0, 3 0, 3 3, 0 3, 0 0, 1 1, 2 1, 2 2, 1 2, 1 1)')));


SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('GEOMETRYCOLLECTION(POINT(10 10),MULTIPOINT(0 0,10 10))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('linestring(0 0, 1 1, 2 2)')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multipoint(0 0, 1 1, 2 2)')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multilinestring((0 0, 1 1, 2 2), (3 3, 4 4, 5 5))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('polygon((0 0, 1 1, 2 2, 0 0), (3 3, 4 4, 5 5, 3 3))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multipolygon(((0 0, 1 1, 2 2, 0 0), (3 3, 4 4, 5 5, 3 3)), ((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('geometrycollection(polygon((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)), polygon((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multipolygon(((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)), ((0 0, 1 0, 1 1, 0 1, 0 0)))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multipolygon(((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('polygon((0 0, 1 0, 1 1, 0 1, 0 0))')));
SELECT ST_AsText(ST_Convexhull(ST_GeomFromText('multipoint(0 0, 3 0, 3 3, 0 3, 0 0, 1 1, 2 1, 2 2, 1 2, 1 1)')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(MULTIPOINT(0 0,10 10))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)))')));
SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('GEOMETRYCOLLECTION()')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION()')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION()')));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION()'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION()'),ST_GeomFromText('POINT(10 10)'));
SELECT ST_Distance(ST_GeomFromText('POINT(10 10)'),ST_GeomFromText('GEOMETRYCOLLECTION()'));

-- Bug #17541849   ST_AREA() NOT RETURNING CONSISTENT RESULTS WITH THE SELF INTERSECTING POLYGONS
Select ST_Area(ST_PolygonFromText('POLYGON((0 0, 30 30, 30 0, 0 5, 0 0, 30 5, 30 0, 0 10, 0 0, 30 10, 30 0, 0 0))')) as Result;
Select ST_Area(ST_PolygonFromText('POLYGON((1 1, 10 1, 1 0, 10 0, 1 -1, 10 -1, 7 2, 7 -2, 4 2, 4 -2, 1 1))')) as Result;

Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (-1 -1, -10 -1, -10 -15, -1 -15, -1 -1))'))) as Result;

-- Bug #17606622 ISSUES WITH THE ST_CENTROID() FOR THE POLYGONS AND MULTIPOLYGONS
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 10 1, 10 20, 1 20, 1 1),(-1 -1, -10 -1, -10 -15, -1 -15, -1 -1)))'))) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (5 5))'))) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (1 1))'))) as Result;

Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 1, 10 1, 10 20, 1 20, 1 1), (5 5, 6 5, 6 6, 5 6, 5 5))'))) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 0, 2 0, 3 0, 4 0, 5 0, 1 0))'))) as Result;
Select ST_AsText(ST_Centroid(ST_PolyFromText('POLYGON((1 0, 2 0, 3 0, 4 0, 5 0, 1 0), (2 0, 3 0, 2 0))'))) as Result;

-- Bug #17611279 ST_CENTROID() RETURNING POINT(0 0) FOR VALID MULTIPOLYGONS
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 2 1, 2 3, 1 3, 1 1),(1 1, 2 1, 2 3, 1 3, 1 1)),((1 1, 2 1, 2 3, 1 3, 1 1)))'))) as Result;
Select ST_AsText(ST_Centroid(ST_MultiPolygonFromText('MULTIPOLYGON(((1 1, 2 1, 2 3, 1 3, 1 1),(1 1, 2 1, 2 3, 1 3, 1 1)),((20 20, 30 20, 30 40, 20 40, 20 20)))'))) as Result;
select ST_astext(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '0'),Point('-0', '0'), Point('0', '-0'))))) as result;
select ST_Astext(ST_Envelope(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '0'),Point('-0', '0'), Point('0', '-0')))))) as result;
select ST_astext(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '-0'),Point('-0', '0'), Point('0', '0'))))) as result;
select ST_Astext(ST_Envelope(ST_MPointFromWKB(ST_AsWKB(MultiPoint(Point('0', '-0'),Point('-0', '0'), Point('0', '0')))))) as result;

Select ST_AsText(ST_ConvexHull(ST_GeomFromText('MULTIPOINT(5 0,25 0,15 10,15 25)')));

Select ST_AsText(ST_ConvexHull(ST_GeomFromText('POLYGON((5 0,15 25,25 0,15 5,5 0))')));

Select ST_AsText(ST_ConvexHull(ST_GeomFromText('MULTIPOLYGON(((0 0,0 10,10 10,10 0,0 0)),((4 4,4 6,6 6,6 4,4 4)))')));

SELECT ST_AsText(ST_convexhull(ST_GeomFromText('MULTIPOINT(5 -3,0 2,5 7,10 2,10 0,10 -2)')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('MULTIPOINT(5 0,0 5,5 10,10 5,10 -5)')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('MULTIPOINT(2 -5,2 5,8 5,8 2,8 0)')));

SELECT ST_AsText(st_ConvexHull(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)),POLYGON((0 0,10 0,10 -10,0 -10,0 0)))')));

SELECT ST_AsText(st_ConvexHull(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10,10 0,0 0),LINESTRING(0 0,10 0,10 -10,0 -10,0 0))')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('MULTILINESTRING((4 7,1 0,1 7),(4 9,8 6,9 4))')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('POLYGON((5 2,5 5,2 8,5 2))')));
SELECT ST_AsText(st_Convexhull(ST_GeomFromText('multipoint(0 0, 3 0, 3 3, 0 3, 0 0, 1 1, 2 1, 2 2, 1 2, 1 1)')));
SELECT ST_AsText(st_Convexhull(ST_GeomFromText('multipolygon(((0 0, 3 0, 3 3, 0 3, 0 0), (1 1, 2 1, 2 2, 1 2, 1 1)), ((0 0, 1 0, 1 1, 0 1, 0 0)))')));
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

SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,-10 10,-10 0,0 0)),POLYGON((0 0,0 10,10 10,10 0,0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)),POLYGON((0 0,0 -10,10 -10,10 0,0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)),POLYGON((0 0,10 0,10 -10,0 -10,0 0)))')));
select (ST_aswkb(cast(st_union(multipoint(
                                       point(8,6), point(1,-17679),
                                       point(-9,-9)),
                            linestring(point(91,12), point(-77,49),
                                       point(53,-81)))as binary(40))))
in  ('1','2');
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 10,20 20),GEOMETRYCOLLECTION())'),ST_GeomFromText('LINESTRING(5 0,10 0)'));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 10,20 20),GEOMETRYCOLLECTION())'),ST_GeomFromText('multipoint(5 0,10 0)'));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 10,20 20))'),ST_GeomFromText('LINESTRING(5 0,10 0)'));

SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 10,20 20),GEOMETRYCOLLECTION(point(2 4), GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION()))))'),ST_GeomFromText('GEOMETRYCOLLECTION(multipoint(5 0,10 0), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION()))'));
SELECT ST_Distance(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,10 10,20 20),GEOMETRYCOLLECTION())'),ST_GeomFromText('LINESTRING(5 0,10 0)'));

SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10),GEOMETRYCOLLECTION())')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10),GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10,10 10),GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), point(4 4), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION()')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(), GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())))')));

SELECT ST_intersects(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_disjoint(ST_GeomFromText('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION())'),ST_GeomFromText('GEOMETRYCOLLECTION()'));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POINT(-0 0)')));

SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POINT(0 -0)')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(0 -0)')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(-0 0)')));

SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(0 -0)'))) =ST_AsText(ST_ConvexHull(ST_GeomFromText('POINT(-0 0)'))) ;
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POLYGON((0 0))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POLYGON((0 0,5 5))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POLYGON((0 0,5 5,10 10, 0 0))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('MULTIPOLYGON(((0 0,5 5)),((1 1,1 1,1 1,1 1)))')));
Select st_astext(st_centroid(ST_GeomFromText('geometrycollection(polygon((0 0,0 10,10 10,10 0,0 0)))')));
Select st_astext(st_centroid(ST_GeomFromText('geometrycollection(geometrycollection(),polygon((0 0,0 10,10 10,10 0,0 0)))')));
Select st_astext(st_convexhull(ST_GeomFromText('geometrycollection(polygon((0 0,0 10,10 10,10 0,0 0)))')));
Select st_astext(st_convexhull(ST_GeomFromText('geometrycollection(geometrycollection(),polygon((0 0,0 10,10 10,10 0,0 0)))')));
select st_distance(ST_GeomFromText('geometrycollection(geometrycollection(),polygon((0 0,0 10,10 10,10 0,0 0)))'),ST_GeomFromText('linestring(0 0,10 10)'));
select st_distance(ST_GeomFromText('geometrycollection(geometrycollection(),polygon((0 0,0 10,10 10,10 0,0 0)))'),ST_GeomFromText('point(100 100)'));
Select st_distance(ST_GeomFromText('geometrycollection(polygon((0 0,0 10,10 10,10 0,0 0)))'),ST_GeomFromText('point(100 100)'));
Select st_distance(ST_GeomFromText('geometrycollection(polygon((0 0,0 10,10 10,10 0,0 0)))'),ST_GeomFromText('linestring(0 0,10 10)'));
SELECT ST_AsText(ST_ConvexHull(ST_GeomFromText('GeometryCollection(POLYGON((0 0)))')));
SELECT ST_AsText(ST_Centroid(ST_GeomFromText('GeometryCollection(POLYGON((0 0)))')));
SELECT ST_DISTANCE(ST_GeomFromText('POLYGON((0 0, 1 1))'), ST_GeomFromText('POLYGON((1 0, 0 1))'));

select st_astext(st_makeenvelope(st_geomfromtext('point(0 0)'), st_geomfromtext('point(2 2)')));
select st_astext(st_makeenvelope(st_geomfromtext('point(0 0)'), st_geomfromtext('point(-22 -11)')));
select st_distance_sphere(st_geomfromtext('point(-120 45)'), st_geomfromtext('point(30.24 68.37)'));
SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 10,5 15)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(5 0,5 10),GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('LINESTRING(5 0,5 10)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTIPOINT(5 0,5 10),GEOMETRYCOLLECTION())'),ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 1,5 11)'));
SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 10,5 15)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 11,5 15)'));

SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 0)'),ST_GEOMFROMTEXT('MULTIPOINT(3 0,15 0)'));
SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 0)'),ST_GEOMFROMTEXT('MULTIPOINT(3 0,5 0)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 0)'),ST_GEOMFROMTEXT('MULTIPOINT(3 0,4 0)'));

SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(5 3,15 3)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,5 10)'),ST_GEOMFROMTEXT('MULTIPOINT(0 3,15 3)'));
SELECT 1, MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 0)'),ST_GEOMFROMTEXT('MULTIPOINT(6 0,6 10)'));
SELECT MBRTOUCHES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 0)'),ST_GEOMFROMTEXT('MULTIPOINT(6 -5,6 10)'));
set @centroid_point = ST_CENTROID(ST_UNION(ST_UNION(ST_GEOMFROMTEXT('MULTILINESTRING((-556 966,-721 -210),(-202 390,-954 804,682 504,-394 -254,832 371,907 -369,827 126,-567 -337,-304 -555,-957 -483,-660 792),(-965 -940,814 -804,-477 -909,-128 57,-819 880,761 497,-559 40,-431 427,179 -291,-707 315,137 -781,-416 -371,-5 -156),(-600 -570,-481 -191,991 -361,768 888,-647 566,795 -861,-82 -575,-593 539))'), ST_GEOMFROMTEXT('MULTIPOLYGON(((805 69,249 708,147 455,546 -672,-218 843,458 24,-630 -420,-83 -69, 805 69)),((196 -219,-201 663,-867 521,-910 -315,-749 801,-402 820,-167 -817,-526 -163,744 -988,-588 -370,573 695,-597 513,-246 439, 196 -219)),((32 -903,189 -871,-778 -741,784 340,403 -555,607 -540,-513 -982,700 -124,344 732,714 151,-812 -252,-440 -895,-426 231,-819 -357, 32 -903)),((-395 830,454 -143,788 -279,618 -843,-490 -507,-224 17, -395 830)))')), ST_INTERSECTION(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(-169 -570),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTILINESTRING((683 4,864 -634,548 -891,727 -691,-570 32,-334 -438,127 -317,241 -12,-807 947,-987 693,-345 -867,854 -106)),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTIPOLYGON(((266 51,851 523,-781 366,-607 -581, 266 51)),((416 -450,-973 880,103 226,-896 -857,-369 761, 416 -450)),((168 171,26 -99,-606 -490,-174 -138,-325 -218,-833 -652,-255 -445,-882 -762,-202 -560, 168 171)),((-423 -216,-531 -190,-147 821,362 441,645 -128,-997 708,134 -426,714 -9,147 842,-887 -870,688 -330,689 17,-314 -262,401 -112,-606 761, -423 -216)),((-582 -373,-360 -84,-727 -171,412 -660,750 -846,-464 718,163 -11,489 -659,586 -324,-741 -198,144 -165,644 -80,930 -487,-504 -205, -582 -373))),MULTIPOLYGON(((266 51,851 523,-781 366,-607 -581, 266 51)),((416 -450,-973 880,103 226,-896 -857,-369 761, 416 -450)),((168 171,26 -99,-606 -490,-174 -138,-325 -218,-833 -652,-255 -445,-882 -762,-202 -560, 168 171)),((-423 -216,-531 -190,-147 821,362 441,645 -128,-997 708,134 -426,714 -9,147 842,-887 -870,688 -330,689 17,-314 -262,401 -112,-606 761, -423 -216)),((-582 -373,-360 -84,-727 -171,412 -660,750 -846,-464 718,163 -11,489 -659,586 -324,-741 -198,144 -165,644 -80,930 -487,-504 -205, -582 -373))),GEOMETRYCOLLECTION(),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTILINESTRING((683 4,864 -634,548 -891,727 -691,-570 32,-334 -438,127 -317,241 -12,-807 947,-987 693,-345 -867,854 -106)))'), ST_GEOMFROMTEXT('MULTIPOINT(157 69,-725 -189,-176 -41,676 375,33 -672,-76 47)')), ST_UNION(ST_ENVELOPE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(-896 100,-793 810,243 -525,650 -373,599 170,-554 -890),POINT(945 -828),POINT(945 -828),LINESTRING(-896 100,-793 810,243 -525,650 -373,599 170,-554 -890),POINT(945 -828),MULTIPOINT(-47 307,-768 -425,-3 167,-170 30,-784 721,951 146,407 790,37 850,-466 738),GEOMETRYCOLLECTION(),MULTIPOINT(-47 307,-768 -425,-3 167,-170 30,-784 721,951 146,407 790,37 850,-466 738),MULTIPOLYGON(((104 113,688 423,-859 602,272 978, 104 113)),((981 -394,189 -400,649 -325,-977 371,30 859,590 318,329 -894,-51 262,197 952,-846 -139,-920 399, 981 -394)),((-236 -759,834 757,857 747,437 -146,194 913,316 862,976 -491,-745 933,610 687,-149 -164,-803 -565,451 -275, -236 -759)),((572 96,-160 -607,529 930,-544 -132,458 294, 572 96))))')), ST_CENTROID(ST_GEOMFROMTEXT('POINT(-939 -921)'))))));

DO ST_AsText(@centroid_point) as centroid;

DO MBRWITHIN(@centroid_point, ST_INTERSECTION(ST_GEOMFROMTEXT('MULTILINESTRING((541 -927,-414 316,-429 -444,212 260,-125 104,445 563,-713 -975,-976 514),(-830 882,-377 914,-915 919,-535 -23,-508 979),(806 347,-87 220,226 -22,-12 468,707 598,83 951,-592 701,833 964,270 -932,743 -514,231 469,-575 -122,-99 -245,416 465,801 -587))'), ST_GEOMFROMTEXT('LINESTRING(-96 -182,-373 75,697 687,-881 -463,-557 -959,-493 810)'))) as result;
select ST_Length(ST_MLineFromWKB(0x0000000005000000020000000002000000035FB317E5EF3AB327E3A4B378469B67320000000000000000C0240000000000003FF05FD8ADAB9F560000000000000000000000000200000003000000000000000000000000000000000000000000000000BFF08B439581062540240000000000004341C37937E08000)) as length;
               geometrycollection(point(4.297374e+307,8.433875e+307)));
select st_distance(linestring(point(26,87),point(13,95)),
                   geometrycollection(point(4.297374e+307,8.433875e+307))) as dist;
select st_distance(linestring(point(26,87),point(13,95)),
                   geometrycollection(point(4.297374e+307,8.433875e+307), point(1e308, 1e308))) as dist;
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
select ST_GeomFromText('linestring(-2 -2, 12 7)') into @l;
select st_intersects(@a, @l);

select ST_GeomFromText('linestring(5 5, 15 4)') into @l;
select st_intersects(@a, @l);

select ST_GeomFromText('linestring(7 6, 15 4)') into @l;
select st_intersects(@a, @l);

select ST_GeomFromText('linestring(6 2, 12 1)') into @l;
select st_intersects(@a, @l);
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

select 1, st_intersects(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';

select 0, st_overlaps(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';


select 1, st_touches(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';

select 1, st_intersects(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';

select 0, st_overlaps(t.geom, p.geom)
from tbl_polygon t, tbl_polygon p
where t.id = 'POLY1' and p.id = 'POLY2';

drop table if exists tbl_polygon;
SELECT
ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((-7 -2,-9 3,-2 -8),(3 7,5 6,-7 -9,7 -1,-2 -8,2 9,4 6,-5 -5)),
                                               MULTILINESTRING((2 -2,2 -3,2 -1,-10 7,1 -2,-2 0,-9 -2,10 5,-7 -8,-9 -1,1 -1,-2 3,5 -9,-8 -9,-10 -9)),
                                               MULTIPOINT(-7 -5,6 9,7 4))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POLYGON((0 0,0 5,5 5,5 0,0 0))'));

SELECT ST_ISVALID(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0),(4 4,4 6,6 6,6 4,4 4))'));

SELECT ST_ISVALID(ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 5,5 5,5 0,0 0)))'));

SELECT ST_ISVALID(ST_GEOMFROMTEXT('MULTIPOLYGON(((0 0,0 10,10 10,10 0,0 0)),((14 14,14 16,16 16,16 14,14 14)))'));
SELECT st_astext(ST_VALIDATE(ST_GEOMFROMTEXT('POINT(0 0)')));
SELECT st_astext(ST_VALIDATE(ST_GEOMFROMTEXT('LINESTRING(0 0,10 10)')));
SELECT st_astext(ST_VALIDATE(ST_GEOMFROMTEXT('POLYGON((0 0, 10 0, 10 10, 0 10, 0 0))')));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0, 0 0))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('LINESTRING(0 0,0 10)'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POINT(0 0)'));

SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0, 0 0)))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(0 0,0 10))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(0 0))'));

SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0, 0 0))))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(LINESTRING(0 0,0 10)))'));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(0 0)))'));
SELECT ST_ASTEXT(ST_MAKEENVELOPE(ST_GEOMFROMTEXT('POINT(0 1)', 4236),
                                 ST_GEOMFROMTEXT('POINT(0 0)', 0)));
SELECT ST_ASTEXT(ST_MAKEENVELOPE(ST_GEOMFROMTEXT('POINT(0 1)', 4145),
                                 ST_GEOMFROMTEXT('POINT(0 0)', 0)));
SELECT ST_ASTEXT(ST_MAKEENVELOPE(ST_GEOMFROMTEXT('POINT(0 1)', 0),
                                 ST_GEOMFROMTEXT('POINT(0 0)', 2000)));
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
set @centroid_point = ST_CENTROID(ST_UNION(ST_UNION(ST_GEOMFROMTEXT('MULTILINESTRING((-556 966,-721 -210),(-202 390,-954 804,682 504,-394 -254,832 371,907 -369,827 126,-567 -337,-304 -555,-957 -483,-660 792),(-965 -940,814 -804,-477 -909,-128 57,-819 880,761 497,-559 40,-431 427,179 -291,-707 315,137 -781,-416 -371,-5 -156),(-600 -570,-481 -191,991 -361,768 888,-647 566,795 -861,-82 -575,-593 539))'), ST_GEOMFROMTEXT('MULTIPOLYGON(((805 69,249 708,147 455,546 -672,-218 843,458 24,-630 -420,-83 -69, 805 69)),((196 -219,-201 663,-867 521,-910 -315,-749 801,-402 820,-167 -817,-526 -163,744 -988,-588 -370,573 695,-597 513,-246 439, 196 -219)),((32 -903,189 -871,-778 -741,784 340,403 -555,607 -540,-513 -982,700 -124,344 732,714 151,-812 -252,-440 -895,-426 231,-819 -357, 32 -903)),((-395 830,454 -143,788 -279,618 -843,-490 -507,-224 17, -395 830)))')), ST_INTERSECTION(ST_UNION(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(-169 -570),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTILINESTRING((683 4,864 -634,548 -891,727 -691,-570 32,-334 -438,127 -317,241 -12,-807 947,-987 693,-345 -867,854 -106)),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTIPOLYGON(((266 51,851 523,-781 366,-607 -581, 266 51)),((416 -450,-973 880,103 226,-896 -857,-369 761, 416 -450)),((168 171,26 -99,-606 -490,-174 -138,-325 -218,-833 -652,-255 -445,-882 -762,-202 -560, 168 171)),((-423 -216,-531 -190,-147 821,362 441,645 -128,-997 708,134 -426,714 -9,147 842,-887 -870,688 -330,689 17,-314 -262,401 -112,-606 761, -423 -216)),((-582 -373,-360 -84,-727 -171,412 -660,750 -846,-464 718,163 -11,489 -659,586 -324,-741 -198,144 -165,644 -80,930 -487,-504 -205, -582 -373))),MULTIPOLYGON(((266 51,851 523,-781 366,-607 -581, 266 51)),((416 -450,-973 880,103 226,-896 -857,-369 761, 416 -450)),((168 171,26 -99,-606 -490,-174 -138,-325 -218,-833 -652,-255 -445,-882 -762,-202 -560, 168 171)),((-423 -216,-531 -190,-147 821,362 441,645 -128,-997 708,134 -426,714 -9,147 842,-887 -870,688 -330,689 17,-314 -262,401 -112,-606 761, -423 -216)),((-582 -373,-360 -84,-727 -171,412 -660,750 -846,-464 718,163 -11,489 -659,586 -324,-741 -198,144 -165,644 -80,930 -487,-504 -205, -582 -373))),GEOMETRYCOLLECTION(),MULTIPOINT(384 290,-601 123,408 86,-616 -300,160 -474,-979 -4,-63 -824,-689 -765,-219 802,-54 -93,191 -982,-723 -449),MULTILINESTRING((683 4,864 -634,548 -891,727 -691,-570 32,-334 -438,127 -317,241 -12,-807 947,-987 693,-345 -867,854 -106)))'), ST_GEOMFROMTEXT('MULTIPOINT(157 69,-725 -189,-176 -41,676 375,33 -672,-76 47)')), ST_UNION(ST_ENVELOPE(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(LINESTRING(-896 100,-793 810,243 -525,650 -373,599 170,-554 -890),POINT(945 -828),POINT(945 -828),LINESTRING(-896 100,-793 810,243 -525,650 -373,599 170,-554 -890),POINT(945 -828),MULTIPOINT(-47 307,-768 -425,-3 167,-170 30,-784 721,951 146,407 790,37 850,-466 738),GEOMETRYCOLLECTION(),MULTIPOINT(-47 307,-768 -425,-3 167,-170 30,-784 721,951 146,407 790,37 850,-466 738),MULTIPOLYGON(((104 113,688 423,-859 602,272 978, 104 113)),((981 -394,189 -400,649 -325,-977 371,30 859,590 318,329 -894,-51 262,197 952,-846 -139,-920 399, 981 -394)),((-236 -759,834 757,857 747,437 -146,194 913,316 862,976 -491,-745 933,610 687,-149 -164,-803 -565,451 -275, -236 -759)),((572 96,-160 -607,529 930,-544 -132,458 294, 572 96))))')), ST_CENTROID(ST_GEOMFROMTEXT('POINT(-939 -921)'))))));


DO ST_AsText(@centroid_point) as centroid;

DO MBRWITHIN(@centroid_point, ST_INTERSECTION(ST_GEOMFROMTEXT('MULTILINESTRING((541 -927,-414 316,-429 -444,212 260,-125 104,445 563,-713 -975,-976 514),(-830 882,-377 914,-915 919,-535 -23,-508 979),(806 347,-87 220,226 -22,-12 468,707 598,83 951,-592 701,833 964,270 -932,743 -514,231 469,-575 -122,-99 -245,416 465,801 -587))'), ST_GEOMFROMTEXT('LINESTRING(-96 -182,-373 75,697 687,-881 -463,-557 -959,-493 810)'))) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POINT(0 0)'),
                  ST_GEOMFROMTEXT('POINT(0 0)'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POINT(0 0)'),
                  ST_GEOMFROMTEXT('POINT(1 1)'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POINT(1 0)'),
                  ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(0 0))'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POINT(0 0)'),
                  ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(0 0))'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLlECTION(POINT(0 0))'),
                  ST_GEOMFROMTEXT('POINT(0 0)'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('GEOMETRYCOLlECTION(POINT(0 0))'),
                  ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POINT(0 0))'));
SELECT ST_WITHIN(ST_GEOMFROMTEXT('MULTIPOINT(0 0,5 5,10 10)'),ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
SELECT ST_WITHIN(ST_GEOMFROMTEXT('MULTIPOINT(0 0,5 0,3 3)'),ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
SELECT ST_CROSSES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 10)'),ST_GEOMFROMTEXT('POLYGON((0 0,5 0,5 5,0 5, 0 0))'));
SELECT ST_CROSSES(ST_GEOMFROMTEXT('MULTIPOINT(2 2, 5 0,10 10)'),ST_GEOMFROMTEXT('POLYGON((0 0,5 0,5 5,0 5, 0 0))'));
SELECT ST_CROSSES(ST_GEOMFROMTEXT('MULTIPOINT(5 0,10 10,20 20)'),ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
SELECT ST_CROSSES(ST_GEOMFROMTEXT('MULTIPOINT(2 2, 5 0,10 10,20 20)'),ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'));
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'), ST_GEOMFROMTEXT('MULTIPOINT(3 3,13 13)'));
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('MULTIPOLYGON(((5 0,0 5,10 5,5 0)),((5 0,0 -5,10 -5,5 0)))'), ST_GEOMFROMTEXT('MULTIPOINT(5 0)'));
SELECT ST_CONTAINS(ST_GEOMFROMTEXT('POLYGON((0 0,0 5,5 5,5 0,0 0))'), ST_GEOMFROMTEXT('MULTIPOINT(5 2,15 14)'));
SELECT ST_ASTEXT(ST_INTERSECTION(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'), 
                                 ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((4 4,4 6,6 6,6 4,4 4)),
                                                                     POLYGON((5 5,5 7,7 7,7 5,5 5)))'))) as result;
                                                           GEOMETRYCOLLECTION(),
                                                           GEOMETRYCOLLECTION(MULTIPOLYGON(((-8 0,-2 -6,-10 -9,-9 7,-2 -10,7 -9,3 -6,-5 -8,-10 -7,-6 10,4 -10,-7 -8,6 -1, -8 0)),((-4 -3,7 -10,-4 -1,-10 -3,3 -3,-10 -4,-1 2,-2 -10,6 -7,-9 -8, -4 -3))),
                                                                              POINT(5 0),
                                                                              MULTIPOINT(-3 0,-4 -8,-3 -4,10 4,0 7,-7 2,4 -8,1 -6),
                                                                              MULTILINESTRING((-10 10,-10 5,9 -9,2 2,-7 2,0 -3,2 3,-6 -4,0 -2),(5 -9,0 -9,6 -4,1 -4,-1 6,2 -9,5 -7,8 10)),
                                                                              MULTILINESTRING((-10 10,-10 5,9 -9,2 2,-7 2,0 -3,2 3,-6 -4,0 -2),(5 -9,0 -9,6 -4,1 -4,-1 6,2 -9,5 -7,8 10)),
                                                                              LINESTRING(10 5,-4 7,-5 -8,-4 4,-4 6,-5 9,-1 6,0 -5)),
                                                           GEOMETRYCOLLECTION(MULTILINESTRING((-8 5,9 -10,-9 9,-9 4,3 -2,4 -6),(3 -10,3 8,-10 4,6 -3,8 -2,3 3,4 -7,-8 6,-3 2,5 3,0 10,2 4,1 -5,-6 1),(10 3,-4 2,4 -4,3 -1,-8 0,-7 -2,10 9,-5 5,-3 6),(0 3,3 7,0 2,4 -1,8 8,-10 -4,2 7,-4 5)),
                                                                              POINT(2 -1),
                                                                              MULTIPOLYGON(((-10 8,1 -4,0 -8,9 2,-8 -6,-3 -7,-10 -1,-10 -9,10 -3, -10 8)),((-6 7,-1 3,2 8,10 -6,-8 4,-9 -10,-8 -8,-2 -1,-9 7,6 -9,5 1,-1 -6, -6 7)),((8 9,0 1,-5 -8,0 8,-3 -6,-9 -2,9 -6,-5 5,-1 -3,-8 2,2 -9,5 -5,7 -7,-9 3,0 -3, 8 9)),((1 -4,-7 -10,10 10,5 3,8 -9,-6 5,2 2,-5 5,-1 5, 1 -4))),
                                                                              MULTIPOLYGON(((-10 8,1 -4,0 -8,9 2,-8 -6,-3 -7,-10 -1,-10 -9,10 -3, -10 8)),((-6 7,-1 3,2 8,10 -6,-8 4,-9 -10,-8 -8,-2 -1,-9 7,6 -9,5 1,-1 -6, -6 7)),((8 9,0 1,-5 -8,0 8,-3 -6,-9 -2,9 -6,-5 5,-1 -3,-8 2,2 -9,5 -5,7 -7,-9 3,0 -3, 8 9)),((1 -4,-7 -10,10 10,5 3,8 -9,-6 5,2 2,-5 5,-1 5, 1 -4)))),
                                                           MULTIPOLYGON(((8 0,7 -6,7 -2,-7 -9,-3 10,-4 -3,3 -10, 8 0)),((7 3,7 6,1 8,4 6,-8 -7,-6 -7,9 -4,-1 3,-7 10, 7 3)),((3 -6,5 4,-3 -6,-5 1,-6 0,0 0,0 -7,-2 -10,-4 8,9 9,4 6, 3 -6)),((7 -7,3 4,-5 0, 7 -7)),((4 -9,-2 -9,-2 10, 4 -9))),
                                                           POLYGON((-3 -6,-3 0,3 -10,3 10,1 -4,-6 -10,8 -5,-9 -8,2 -4,9 10,1 -3, -3 -6)),
                                                           POLYGON((2 -5,0 -2,-3 9,0 4,6 -6,5 -4,-4 2,-6 6,3 -4,1 0,-10 -7,1 6,-7 2, 2 -5)),
                                                           MULTIPOINT(7 8,-6 -3,-1 -7,0 7,-2 1,-8 -8))'),
                          ST_GEOMFROMTEXT('GEOMETRYCOLLECTION()'))) as result;
SELECT ST_ASTEXT(ST_UNION(ST_ENVELOPE(ST_GEOMFROMTEXT('LINESTRING(5 9,-1 10,-2 -6,2 9,2 0,3 6,-3 3,9 -2,-3 -10,-7 -4,1 4)')),
                       ST_UNION(ST_GEOMFROMTEXT('MULTILINESTRING((6 -8,10 -8,3 0,-6 1,0 8,-1 8,-3 -3,6 -6,0 6,1 -6,-1 7,8 3),(-9 -10,-4 0,0 1,-9 1,6 9,-8 7,-2 -6,2 10,-1 -5,3 -5,-1 -10))'), 
                                ST_GEOMFROMTEXT('MULTILINESTRING((8 7,2 6,-6 -8,-2 10,4 1,9 7,5 9,4 1,8 2,-2 10,8 -5))')))) as result;
                                       ST_GEOMFROMTEXT('MULTIPOLYGON(((6 2,1 1,-4 5,1 4,-3 -4,-7 9,-10 2,-6 1,10 -7,0 1,9 4, 6 2)))')), 
                       ST_UNION(ST_GEOMFROMTEXT('LINESTRING(-1 -5,0 -6,4 6,3 3,2 8,-2 6,-4 5,6 -7,-1 -1,-8 6,4 -2)'), 
                                ST_GEOMFROMTEXT('MULTIPOLYGON(((5 -4,-5 -9,-1 -6,-3 0,5 -2, 5 -4)),((-5 -10,-8 -2,-3 7,1 5,5 -10,1 -5,0 10,3 2,1 1, -5 -10)),((4 -2,6 3,7 5,1 2,8 -9,-10 -5,7 -10,-2 -9,-2 0,2 -8,-8 3,5 0, 4 -2)),((6 -4,0 4,-8 -2,10 -10,-6 5, 6 -4)))')))) as result;


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

-- Despite the name, this bug is not about the function name not being printed,
-- it's about raising the wrong error.

--error ER_DATA_OUT_OF_RANGE
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POINT(0 0)', -1));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POINT(0 0)', 1));
SELECT ST_ISVALID(ST_GEOMFROMTEXT('POINT(0 0)', 1000));
SET @star_center= 'POINT(15 10)';
SET @star_all_points= 'MULTIPOINT(5 0,25 0,15 10,15 25)';
SELECT ST_ISVALID(ST_GEOMFROMTEXT(@star_center,-1024));
SELECT ST_ISVALID(ST_GEOMFROMTEXT(@star_all_points,-1));
SET @star_center= 'POINT(15 10)';
SET @star_all_points= 'MULTIPOINT(5 0,25 0,15 10,15 25)';
SELECT ST_VALIDATE(ST_GEOMFROMTEXT(@star_center,-1024));
SELECT ST_VALIDATE(ST_GEOMFROMTEXT(@star_all_points,-1));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('LINESTRING(0 0,5 0,10 0)'),
                  ST_GEOMFROMTEXT('MULTIPOINT(10 0)')) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('LINESTRING(0 0,5 0,10 0)'),
                  ST_GEOMFROMTEXT('MULTIPOINT(0 0,10 0)')) as result;
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'),ST_GEOMFROMTEXT('MULTIPOINT(0 0)'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'),ST_GEOMFROMTEXT('MULTIPOINT(0 0,0 10)'));
SELECT ST_TOUCHES(ST_GEOMFROMTEXT('POLYGON((0 0,0 10,10 10,10 0,0 0))'),ST_GEOMFROMTEXT('MULTIPOINT(0 0,0 10,10 10)'));
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
SELECT ST_ASTEXT(ST_INTERSECTION(
     ST_GEOMFROMTEXT(
          'MULTIPOLYGON(((3 2,7 5,0 0,-9.9 9,10.0002 1,2.232432 2,4 -0.7654,3 2)))'),
     ST_GEOMFROMWKB(ST_AsWKB(
          MULTILINESTRING(
               LINESTRING(POINT(7,0)),LINESTRING(POINT(4,6),POINT(7,5),POINT(5,2),POINT(6,9),POINT(1,8.4),POINT(4,6),POINT(6,9),POINT(0,5),POINT(9,8),POINT(-3.6,+.5)),
               LINESTRING(POINT(+.9,5)),
               LINESTRING(POINT(2,5),POINT(7,1),POINT(2,5),POINT(2.8,6),POINT(1,3),POINT(3,9),POINT(9,7),POINT(6.1,4),POINT(2,7),POINT(8,6),POINT(0,0),POINT(1,9),POINT(4,6.5)),
               LINESTRING(POINT(-.5,6)))))));
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
SELECT ST_ASTEXT(ST_SIMPLIFY(0x000000000200000000000000000000000000000000, 1)) as result;
SELECT ST_ASTEXT(ST_VALIDATE(ST_UNION(ST_GEOMFROMTEXT('MULTIPOLYGON(((-7 -9,-3 7,0 -10,-6 5,10 10,-3 -4,7 9,2 -9)),((1 -10,-3 10,-2 5)))'),
                                      ST_GEOMFROMTEXT('POLYGON((6 10,-7 10,-1 -6,0 5,5 4,1 -9,1 3,-10 -7,-10 8))')))) as result;
SELECT ST_ASTEXT(ST_UNION(ST_GEOMFROMTEXT('MULTIPOLYGON(((-7 -9,-3 7,0 -10,-6 5,10 10,-3 -4,7 9,2 -9)),((1 -10,-3 10,-2 5)))'),
                          ST_GEOMFROMTEXT('POLYGON((6 10,-7 10,-1 -6,0 5,5 4,1 -9,1 3,-10 -7,-10 8))'))) as result;
SELECT ST_ASTEXT(ST_SIMPLIFY(ST_GEOMFROMTEXT('MULTIPOINT(19 -4, -2 -6, -8 2)'), 1)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('POLYGON((0 0,10 0,10 10,0 10,0 0))'), -10));
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('POLYGON((0 0,10 0,10 10,0 10,0 0))'), -8));
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('POLYGON((0 0,10 0,10 10,0 10,0 0))'), -6));
SELECT
ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(MULTILINESTRING((12 -12,-15 19),(2 -9,-4 -8,18 3,-9 -8),(13 11,-15 9,-16 6,-17 5)),
                                                        LINESTRING(14 -16,-3 18,-13 -7,-10 1))'), 6561)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 10,10 10,10 0,0 0)), POLYGON((10 10,10 20,20 20,20 10,10 10)))'), -1)) as result;
SELECT ST_ASTEXT(ST_BUFFER(ST_GEOMFROMTEXT('GEOMETRYCOLLECTION(POLYGON((0 0,0 5,5 5,5 0,0 0)), POLYGON((10 10,10 20,20 20,20 10,10 10)))'), -1)) as result;
SELECT ST_DISTANCE(ST_GEOMFROMTEXT('MULTILINESTRING((9 8))'),ST_GEOMFROMTEXT('POINT(2 9)'));
SELECT ST_DISTANCE(ST_GEOMFROMTEXT('MULTIPOINT(-.1 5,3 6,2 2,9 5)'),ST_GEOMFROMTEXT('LINESTRING(0 8)'));
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('LINESTRING(0 0)'))) as result;
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('POLYGON((0 0))'))) as result;
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('POLYGON((0 0, 1 1))'))) as result;
SELECT HEX(LINESTRING(POINT(0,0)));
SELECT HEX(ST_GeomFromGeoJSON('{"type":"LineString","coordinates":[[0,0]]}'));
SELECT HEX(POLYGON(LINESTRING(POINT(0,0))));
SELECT HEX(POLYGON(LINESTRING(POINT(0,0),POINT(1,0))));
SELECT HEX(POLYGON(LINESTRING(POINT(0,0),POINT(1,0),POINT(0,0))));
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('POINT(10 10)')));
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('LINESTRING(0 10,10 10)')));
SELECT ST_ASTEXT(ST_ENVELOPE(ST_GEOMFROMTEXT('LINESTRING(0 0,0 10)')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POLYGON((0 0, 1 0, 2 0, 0 0))')));
SELECT ST_AsText(ST_Envelope(ST_GeomFromText('POLYGON((0 0, 0 0, 0 0, 0 0))')));
select st_astext(st_buffer(point(-5,0),8772,
                           st_buffer_strategy( 'point_circle',1024*1024*1024)))
as result;
             st_buffer_strategy('point_circle',1024*1024*1024));

set session max_points_in_geometry=1024*1024;
select st_astext(st_buffer(point(-5,0),8772,
                           st_buffer_strategy( 'point_circle',1024*1024*1024)))
as result;

set session max_points_in_geometry=4*1024*1024;
select st_astext(st_buffer(point(-5,0),8772,
                           st_buffer_strategy( 'point_circle',1024*1024*1024)))
as result;
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

-- Tests for the modified GC component merge algorithm.
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
set @empty_geom = geometrycollection();
select 1, @empty_geom = st_geomfromtext('geometrycollection()') as equal;
SELECT HEX(POLYGON(POINT(0,0)));
SELECT HEX(POINT(POINT(0,0),0));
SELECT ST_ASTEXT(POINT(LINESTRING(POINT(0,0),POINT(1,1)),LINESTRING(POINT(2,2),POINT(3,3))));

-- As a MySQL convention in type conversions, these are allowed.
SELECT ST_ASTEXT(POINT(HEX(POINT(0,0)),HEX(LINESTRING(POINT(0, 0), POINT(1, 1)))));
SELECT ST_AsText(Point('123', '456'));
SELECT ST_AsText(Point('123abc', '456def'));
SELECT ST_AsText(Point('abc123', 'def456'));
SELECT
HEX(MULTIPOLYGON(LINESTRING(POINT(0,0),POINT(1,0),POINT(1,1),POINT(0,0))));
SELECT HEX(MULTIPOLYGON(POINT(0,0)));
SELECT HEX(MULTIPOINT(LINESTRING(POINT(0,0),POINT(1,1))));

-- Wrong byte order at wkb header.
--error ER_GIS_INVALID_DATA
SELECT ST_GeomFromWKB(0x020100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01040000000100000001020000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01040000000100000002020000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01050000000100000001040000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01050000000100000002040000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01060000000100000001020000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01060000000100000003020000000100000000000000000000000000000000000000);
SELECT ST_GeomFromWKB(0x01070000000100000002010000000000000000000000);
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

-- More tests with multipolygon arguments.

--echo --
--echo -- Bug#21198064 GEOMETRY CONSTRUCTION FUNCTIONS ALLOWS INVALID WKT
--echo --
--error ER_GIS_INVALID_DATA
SELECT ST_AsText(ST_GeomFromText("POINT(10 11) POINT(11 12)")) as result;
SELECT ST_AsText(ST_PointFromText("POINT(10 11) POINT(11 12)")) as result;
SELECT ST_AsText(ST_GeomFromText("MULTIPOINT(10 11, 12 13), 14 15")) as result;
SELECT ST_AsText(ST_GeomFromText("POINT(10 11)FOOBAR")) as result;

SELECT HEX(ST_AsWKB(ST_GeomFromText("POINT(10 10)    "))) as result;
SELECT HEX(ST_AsWKB(ST_GeomFromText("GEOMETRYCOLLECTION(GEOMETRYCOLLECTION(POINT(10 10)), LINESTRING(0 0, 1 1), GEOMETRYCOLLECTION())   "))) as result;

SELECT ST_AsText(ST_GeomFromWKB(0x010100000000000000000024400000000000002440)) as result;
SELECT ST_AsText(ST_GeomFromWKB(0x01010000000000000000002440000000000000244011111111)) as result;

SELECT ST_AsText(ST_GeomFromWKB(0x01070000000300000001070000000100000001010000000000000000002440000000000000244001020000000200000000000000000000000000000000000000000000000000F03F000000000000F03F010700000000000000)) as result;
SELECT ST_AsText(ST_GeomFromWKB(0x01070000000300000001070000000100000001010000000000000000002440000000000000244001020000000200000000000000000000000000000000000000000000000000F03F000000000000F03F01070000000000000011111111)) as result;
select st_astext(st_union(cast(point(1,1)as binary(15)),point(1,1))) as res;
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
SELECT ST_AsText(ST_PointFromText('POINT(1 . 1)'));
SELECT ST_AsText(ST_PointFromText('POINT(1 .1)'));
SELECT ST_AsText(ST_LineFromText('LINESTRING(.0 0,0 0,0 0)'));
SELECT ST_X(ST_PointFromText('POINT(.0  0)'));
SELECT ST_Y(ST_PointFromText('point(0  .0)'));

CREATE TABLE t1 (col_1 CHAR(7));
INSERT INTO t1 VALUES ('POINT(.');
SELECT ST_GeomFromText(col_1) FROM t1;
DROP TABLE t1;
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT(0 0, 1 1), (2 2)'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT(0 0, (1 1, 2 2))'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT(0 0, (1 1), 2 2)'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT((0 0), (1 1), 2 2, (3 3), 4 4, 5 5, (6 6))'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT((0 0), (1 1), (2 2), (3 3), (4 4), (5 5), (6 6))'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT()'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT(())'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT((()))'));
SELECT ST_ASTEXT(ST_GEOMFROMTEXT('MULTIPOINT((), ())'));
