SELECT
    eventday,
    count(*)
FROM mytable_local
WHERE (toYYYYMM(eventday) = 202007) AND (user_id = 742522) AND (eventday >= '2020-07-03') AND (eventday <= '2020-07-25')
GROUP BY eventday
ORDER BY eventday;
DROP TABLE mytable_local;
DROP TABLE IF EXISTS table_float;
CREATE TABLE table_float
(
    f Float64,
    u UInt32
)
ENGINE = MergeTree
ORDER BY (f, u);
INSERT INTO table_float VALUES (1.2, 1) (1.3, 2) (1.4, 3) (1.5, 4);
DROP TABLE table_float;
