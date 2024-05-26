SELECT 'center';
SELECT arraySort(geohashesInBox(-1.0, -1.0, 1.0, 1.0, 3));
SELECT 'north pole';
SELECT 'south pole';
SELECT 'wrap point around equator';
SELECT 'arbitrary values in all 4 quarters';
SELECT 'small range always produces array of length 1';
SELECT lon/5 - 180 AS lon1, lat/5 - 90 AS lat1, lon1 AS lon2, lat1 AS lat2, geohashesInBox(lon1, lat1, lon2, lat2, 1)  AS g
FROM (SELECT arrayJoin(range(360*5)) AS lon,  arrayJoin(range(180*5)) AS lat) WHERE length(g) != 1;
SELECT lon/5 - 40 AS lon1, lat/5 - 20 AS lat1, lon1 AS lon2, lat1 AS lat2, geohashesInBox(lon1, lat1, lon2, lat2, 12) AS g
FROM (SELECT arrayJoin(range(80*5)) AS lon,  arrayJoin(range(10*5)) AS lat) WHERE length(g) != 1;
SELECT lon/5 - 40 AS lon1, lat/5 - 20 AS lat1, lon1 + 0.0000000001 AS lon2, lat1 + 0.0000000001 AS lat2, geohashesInBox(lon1, lat1, lon2, lat2, 1) AS g
FROM (SELECT arrayJoin(range(80*5)) AS lon,  arrayJoin(range(10*5)) AS lat) WHERE length(g) != 1;
SELECT 'zooming';
SELECT 'input values are clamped to -90..90, -180..180 range';
SELECT length(geohashesInBox(-inf, -inf, inf, inf, 3));
SELECT 'errors';
