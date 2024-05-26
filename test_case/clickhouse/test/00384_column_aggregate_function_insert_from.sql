SELECT d, uniqMerge(s) FROM aggregates GROUP BY d ORDER BY d;
INSERT INTO aggregates
    SELECT toDate('2016-12-01') AS d, uniqState(toUInt64(arrayJoin(range(100)))) AS s
    UNION ALL
    SELECT toDate('2016-12-02') AS d, uniqState(toUInt64(arrayJoin(range(100)))) AS s
    UNION ALL
    SELECT toDate('2016-12-03') AS d, uniqState(toUInt64(arrayJoin(range(100)))) AS s;
DROP TABLE aggregates;
