SELECT geoToS2(37.79506683, arrayJoin([55.71290588,37.79506683]));
SELECT s2ToGeo(arrayJoin([4704772434919038107,9926594385212866560]));
SELECT s2GetNeighbors(arrayJoin([1157339245694594829, 5074766849661468672]));
SELECT s2CellsIntersect(9926595209846587392, arrayJoin([9926594385212866560, 5074766849661468672]));
SELECT s2CapContains(1157339245694594829, toFloat64(1), arrayJoin([1157347770437378819,1157347770437378389]));
SELECT s2CapUnion(3814912406305146967, toFloat64(1), 1157347770437378819, toFloat64(1));
SELECT s2RectAdd(5178914411069187297, 5177056748191934217, arrayJoin([5179056748191934217,5177914411069187297]));
SELECT s2RectContains(5179062030687166815, 5177056748191934217, arrayJoin([5177914411069187297, 5177914411069187297]));
SELECT s2RectUnion(5178914411069187297, 5177056748191934217, 5179062030687166815, arrayJoin([5177056748191934217, 5177914411069187297]));
SELECT s2RectIntersection(5178914411069187297, 5177056748191934217, 5179062030687166815, arrayJoin([5177056748191934217,5177914411069187297]));