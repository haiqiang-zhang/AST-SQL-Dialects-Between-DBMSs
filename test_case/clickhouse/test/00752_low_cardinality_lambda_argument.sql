select arrayFilter(x -> x % 2 == 0, arr) from lc_lambda;
drop table if exists lc_lambda;
drop table if exists test_array;
CREATE TABLE test_array(resources_host Array(LowCardinality(String))) ENGINE = MergeTree() ORDER BY (resources_host);
insert into test_array values (['a']);
SELECT arrayMap(i -> [resources_host[i]], arrayEnumerate(resources_host)) FROM test_array;
drop table if exists test_array;
