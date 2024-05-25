SELECT 'Checking s2 index generation.';
SELECT s2ToGeo(s2_index), geoToS2(longitude, latitude) FROM s2_indexes ORDER BY s2_index;
SELECT first, second, result FROM (
    SELECT
        s2ToGeo(geoToS2(longitude, latitude)) AS output_geo,
        tuple(roundBankers(longitude, 5), roundBankers(latitude, 5)) AS first,
        tuple(roundBankers(output_geo.1, 5), roundBankers(output_geo.2, 5)) AS second,
        if(first = second, 'ok', 'fail') AS result
    FROM s2_indexes
    ORDER BY s2_index
 );
DROP TABLE IF EXISTS s2_indexes;
