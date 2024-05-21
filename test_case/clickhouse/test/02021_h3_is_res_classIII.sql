DROP TABLE IF EXISTS h3_indexes;
CREATE TABLE h3_indexes (h3_index UInt64) ENGINE = Memory;
INSERT INTO h3_indexes VALUES (geoToH3(0.0, 0.0, 0));
INSERT INTO h3_indexes VALUES (geoToH3(10.0, 0.0, 1));
INSERT INTO h3_indexes VALUES (geoToH3(0.0, 10.0, 2));
INSERT INTO h3_indexes VALUES (geoToH3(10.0, 10.0, 3));
SELECT h3IsResClassIII(h3_index) FROM h3_indexes ORDER BY h3_index;
DROP TABLE h3_indexes;
