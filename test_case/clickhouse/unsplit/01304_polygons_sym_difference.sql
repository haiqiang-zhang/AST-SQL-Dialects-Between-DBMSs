select polygonsSymDifferenceCartesian([[[(0, 0),(0, 3),(1, 2.9),(2, 2.6),(2.6, 2),(2.9, 1),(3, 0),(0, 0)]]], [[[(1., 1.),(1., 4.),(4., 4.),(4., 1.),(1., 1.)]]]);
select '-------- MultiPolygon with Polygon';
SELECT arrayDistinct(arraySort(arrayMap((x, y) -> (round(x, 3), round(y, 3)), arrayFlatten(polygonsSymDifferenceSpherical([[[(10., 10.), (10., 40.), (40., 40.), (40., 10.), (10., 10.)]], [[(-10., -10.), (-10., -40.), (-40., -40.), (-40., -10.), (-10., -10.)]]], [[[(-20., -20.), (-20., 20.), (20., 20.), (20., -20.), (-20., -20.)]]])))));
select '-------- MultiPolygon with Polygon with Holes';
select '-------- Polygon with Polygon with Holes';
