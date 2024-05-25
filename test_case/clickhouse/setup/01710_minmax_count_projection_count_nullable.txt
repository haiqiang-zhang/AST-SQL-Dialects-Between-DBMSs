DROP TABLE IF EXISTS test;
CREATE TABLE test (`val` LowCardinality(Nullable(String))) ENGINE = MergeTree ORDER BY tuple() SETTINGS index_granularity = 8192;
insert into test select number == 3 ? 'some value' : null from numbers(5);
