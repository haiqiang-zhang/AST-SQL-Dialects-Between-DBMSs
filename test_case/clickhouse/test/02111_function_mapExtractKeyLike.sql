SELECT 'The data of table:';
SELECT * FROM map_extractKeyLike_test ORDER BY id;
SELECT '';
SELECT id, mapExtractKeyLike(map, 'P1%') FROM map_extractKeyLike_test ORDER BY id;
SELECT '';
DROP TABLE map_extractKeyLike_test;
