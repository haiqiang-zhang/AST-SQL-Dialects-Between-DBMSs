DROP TABLE IF EXISTS table1;
DROP TABLE IF EXISTS table2;
CREATE TABLE table1
(
dt Date,
id Int32,
arr Array(LowCardinality(String))
) ENGINE = MergeTree PARTITION BY toMonday(dt)
ORDER BY (dt, id) SETTINGS index_granularity = 8192;
CREATE TABLE table2
(
dt Date,
id Int32,
arr Array(LowCardinality(String))
) ENGINE = MergeTree PARTITION BY toMonday(dt)
ORDER BY (dt, id) SETTINGS index_granularity = 8192;
insert into table1 (dt, id, arr) values ('2019-01-14', 1, ['aaa']);
insert into table2 (dt, id, arr) values ('2019-01-14', 1, ['aaa','bbb','ccc']);
