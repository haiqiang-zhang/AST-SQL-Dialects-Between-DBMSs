set allow_experimental_analyzer = 1;
with arrayJoin([0, 1, 2, 10]) as x select quantilesGK(100, 0.5, 0.4, 0.1)(x);
with arrayJoin([0, 6, 7, 9, 10]) as x select quantileGK(100, 0.5)(x);
select quantilesGK(10000, 0.25, 0.5, 0.75, 0.0, 1.0, 0, 1)(number + 1) from numbers(1000);
with number + 1 as col select quantilesGK(10000, 0.25, 0.5, 0.75)(col), count(col), quantilesGK(10000, 0.0, 1.0)(col), sum(col) from numbers(1000);
SELECT quantileGKMerge(100, 0.5)(x)
FROM
(
    SELECT quantileGKState(100, 0.5)(number + 1) AS x
    FROM numbers(49999)
);
SELECT quantilesGKMerge(100, 0.5, 0.9, 0.99)(x)
FROM
(
    SELECT quantilesGKState(100, 0.5, 0.9, 0.99)(number + 1) AS x
    FROM numbers(49999)
);
select medianGK(100)(number) from numbers(10);
select quantileGK(100)(number) from numbers(10);
