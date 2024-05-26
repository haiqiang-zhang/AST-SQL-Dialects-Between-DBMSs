SELECT pickup_date, groupBitmapMerge(uv) AS users from bitmap_state_test group by pickup_date order by pickup_date;
SELECT groupBitmap( uid ) AS user_num FROM bitmap_test;
SELECT pickup_date, groupBitmap( uid ) AS user_num, bitmapToArray(groupBitmapState( uid )) AS users FROM bitmap_test GROUP BY pickup_date order by pickup_date;
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
SELECT bitmapToArray(bitmapAnd(groupBitmapState(uid), bitmapBuild(CAST([4294967296, 4294967297, 4294967298], 'Array(UInt64)')))) FROM bitmap_test GROUP BY city_id ORDER BY city_id;
DROP TABLE bitmap_state_test;
DROP TABLE bitmap_test;
