select polygonsIntersectionCartesian([[[(0., 0.),(0., 3.),(1., 2.9),(2., 2.6),(2.6, 2.),(2.9, 1.),(3., 0.),(0., 0.)]]], [[[(1., 1.),(1., 4.),(4., 4.),(4., 1.),(1., 1.)]]]);
select arrayMap(a -> arrayMap(b -> arrayMap(c -> (round(c.1, 6), round(c.2, 6)), b), a), polygonsIntersectionSpherical([[[(4.346693, 50.858306), (4.367945, 50.852455), (4.366227, 50.840809), (4.344961, 50.833264), (4.338074, 50.848677), (4.346693, 50.858306)]]], [[[(25.0010, 136.9987), (17.7500, 142.5000), (11.3733, 142.5917)]]]));
select '-------- MultiPolygon with Polygon';
select '-------- MultiPolygon with Polygon with Holes';
select '-------- Polygon with Polygon with Holes';
