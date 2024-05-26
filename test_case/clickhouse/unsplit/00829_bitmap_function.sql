SELECT bitmapToArray(bitmapBuild([1, 2, 3, 4, 5]));
SELECT bitmapCardinality(bitmapBuild([1, 2, 3, 4, 5]));
SELECT bitmapAndCardinality(bitmapBuild([1,2,3]),bitmapBuild([3,4,5]));
SELECT bitmapOrCardinality(bitmapBuild([1,2,3]),bitmapBuild([3,4,5]));
SELECT bitmapXorCardinality(bitmapBuild([1,2,3]),bitmapBuild([3,4,5]));
SELECT bitmapAndnotCardinality(bitmapBuild([1,2,3]),bitmapBuild([3,4,5]));
DROP TABLE IF EXISTS bitmap_test;
CREATE TABLE bitmap_test(pickup_date Date, city_id UInt32, uid UInt32)ENGINE = Memory;
INSERT INTO bitmap_test SELECT '2019-01-01', 1, number FROM numbers(1,50);
INSERT INTO bitmap_test SELECT '2019-01-02', 1, number FROM numbers(11,60);
INSERT INTO bitmap_test SELECT '2019-01-03', 2, number FROM numbers(1,10);
SELECT groupBitmap( uid ) AS user_num FROM bitmap_test;
SELECT pickup_date, groupBitmap( uid ) AS user_num, bitmapToArray(groupBitmapState( uid )) AS users FROM bitmap_test GROUP BY pickup_date ORDER BY pickup_date;
SELECT
    bitmapCardinality(day_today) AS today_users,
    bitmapCardinality(day_before) AS before_users,
    bitmapOrCardinality(day_today, day_before) AS all_users,
    bitmapAndCardinality(day_today, day_before) AS old_users,
    bitmapAndnotCardinality(day_today, day_before) AS new_users,
    bitmapXorCardinality(day_today, day_before) AS diff_users
FROM
(
 SELECT city_id, groupBitmapState( uid ) AS day_today FROM bitmap_test WHERE pickup_date = '2019-01-02' GROUP BY city_id ORDER BY city_id
) js1
ALL LEFT JOIN
(
 SELECT city_id, groupBitmapState( uid ) AS day_before FROM bitmap_test WHERE pickup_date = '2019-01-01' GROUP BY city_id ORDER BY city_id
) js2
USING city_id;
SELECT
    bitmapCardinality(day_today) AS today_users,
    bitmapCardinality(day_before) AS before_users,
    bitmapCardinality(bitmapOr(day_today, day_before))ll_users,
    bitmapCardinality(bitmapAnd(day_today, day_before)) AS old_users,
    bitmapCardinality(bitmapAndnot(day_today, day_before)) AS new_users,
    bitmapCardinality(bitmapXor(day_today, day_before)) AS diff_users
FROM
(
 SELECT city_id, groupBitmapState( uid ) AS day_today FROM bitmap_test WHERE pickup_date = '2019-01-02' GROUP BY city_id ORDER BY city_id
) js1
ALL LEFT JOIN
(
 SELECT city_id, groupBitmapState( uid ) AS day_before FROM bitmap_test WHERE pickup_date = '2019-01-01' GROUP BY city_id ORDER BY city_id
) js2
USING city_id;
SELECT count(*) FROM bitmap_test WHERE bitmapHasAny((SELECT groupBitmapState(uid) FROM bitmap_test WHERE pickup_date = '2019-01-01'), bitmapBuild([uid]));
DROP TABLE IF EXISTS bitmap_state_test;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE bitmap_state_test
(
	pickup_date Date,
	city_id UInt32,
    uv AggregateFunction( groupBitmap, UInt32 )
)
ENGINE = AggregatingMergeTree( pickup_date, ( pickup_date, city_id ), 8192);
INSERT INTO bitmap_state_test SELECT
    pickup_date,
    city_id,
    groupBitmapState(uid) AS uv
FROM bitmap_test
GROUP BY pickup_date, city_id;
SELECT pickup_date, groupBitmapMerge(uv) AS users from bitmap_state_test group by pickup_date order by pickup_date;
DROP TABLE IF EXISTS bitmap_column_expr_test;
CREATE TABLE bitmap_column_expr_test
(
    t DateTime,
    z AggregateFunction(groupBitmap, UInt32)
)
ENGINE = MergeTree
PARTITION BY toYYYYMMDD(t)
ORDER BY t;
INSERT INTO bitmap_column_expr_test VALUES (now(), bitmapBuild(cast([3,19,47] as Array(UInt32))));
DROP TABLE IF EXISTS bitmap_column_expr_test2;
CREATE TABLE bitmap_column_expr_test2
(
    tag_id String,
    z AggregateFunction(groupBitmap, UInt32)
)
ENGINE = MergeTree
ORDER BY tag_id;
INSERT INTO bitmap_column_expr_test2 VALUES ('tag1', bitmapBuild(cast([1,2,3,4,5,6,7,8,9,10] as Array(UInt32))));
INSERT INTO bitmap_column_expr_test2 VALUES ('tag2', bitmapBuild(cast([6,7,8,9,10,11,12,13,14,15] as Array(UInt32))));
INSERT INTO bitmap_column_expr_test2 VALUES ('tag3', bitmapBuild(cast([2,4,6,8,10,12] as Array(UInt32))));
SELECT groupBitmapMerge(z) FROM bitmap_column_expr_test2 WHERE like(tag_id, 'tag%');
SELECT arraySort(bitmapToArray(groupBitmapMergeState(z))) FROM bitmap_column_expr_test2 WHERE like(tag_id, 'tag%');
SELECT groupBitmapOr(z) FROM bitmap_column_expr_test2 WHERE like(tag_id, 'tag%');
SELECT groupBitmapAnd(z) FROM bitmap_column_expr_test2 WHERE like(tag_id, 'tag%');
SELECT groupBitmapXor(z) FROM bitmap_column_expr_test2 WHERE like(tag_id, 'tag%');
DROP TABLE IF EXISTS bitmap_column_expr_test3;
CREATE TABLE bitmap_column_expr_test3
(
    tag_id String,
    z AggregateFunction(groupBitmap, UInt64),
    replace Nested (
        from UInt16,
        to UInt64
    )
)
ENGINE = MergeTree
ORDER BY tag_id;
DROP TABLE IF EXISTS numbers10;
CREATE VIEW numbers10 AS SELECT number FROM system.numbers LIMIT 10;
INSERT INTO bitmap_column_expr_test3(tag_id, z, replace.from, replace.to) SELECT 'tag1', groupBitmapState(toUInt64(number)), cast([] as Array(UInt16)), cast([] as Array(UInt64)) FROM numbers10;
INSERT INTO bitmap_column_expr_test3(tag_id, z, replace.from, replace.to) SELECT 'tag2', groupBitmapState(toUInt64(number)), cast([0] as Array(UInt16)), cast([2] as Array(UInt64)) FROM numbers10;
INSERT INTO bitmap_column_expr_test3(tag_id, z, replace.from, replace.to) SELECT 'tag3', groupBitmapState(toUInt64(number)), cast([0,7] as Array(UInt16)), cast([3,101] as Array(UInt64)) FROM numbers10;
INSERT INTO bitmap_column_expr_test3(tag_id, z, replace.from, replace.to) SELECT 'tag4', groupBitmapState(toUInt64(number)), cast([5,999,2] as Array(UInt16)), cast([2,888,20] as Array(UInt64)) FROM numbers10;
DROP TABLE IF EXISTS bitmap_test;
DROP TABLE IF EXISTS bitmap_state_test;
DROP TABLE IF EXISTS bitmap_column_expr_test;
DROP TABLE IF EXISTS bitmap_column_expr_test2;
DROP TABLE IF EXISTS numbers10;
DROP TABLE IF EXISTS bitmap_column_expr_test3;
SELECT bitmapHasAny(bitmapBuild([1, 2, 3, 5]), bitmapBuild(emptyArrayUInt8()));
SELECT bitmapHasAll(bitmapBuild([1, 2, 3, 5]), bitmapBuild(emptyArrayUInt8()));
SELECT bitmapContains(bitmapBuild(emptyArrayUInt32()), toUInt8(0));
SELECT bitmapMin(bitmapBuild(emptyArrayUInt8()));
SELECT bitmapMax(bitmapBuild(emptyArrayUInt8()));
CREATE TABLE bitmap_test(pickup_date Date, city_id UInt32, uid UInt32)ENGINE = Memory;
INSERT INTO bitmap_test SELECT '2019-01-01', 1, number FROM numbers(1,50);
INSERT INTO bitmap_test SELECT '2019-01-02', 1, number FROM numbers(11,60);
INSERT INTO bitmap_test SELECT '2019-01-03', 2, number FROM numbers(1,10);
drop table bitmap_test;
