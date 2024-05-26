SELECT * FROM pk_func ORDER BY toDate(d), ui LIMIT 5;
DROP TABLE pk_func;
DROP TABLE IF EXISTS nORX;
CREATE TABLE nORX (`A` Int64, `B` Int64, `V` Int64) ENGINE = MergeTree ORDER BY (A, negate(B)) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
SELECT *
FROM nORX
WHERE B >= 1000
ORDER BY
    A ASC,
    -B ASC
LIMIT 3
SETTINGS max_threads = 1;
DROP TABLE nORX;
