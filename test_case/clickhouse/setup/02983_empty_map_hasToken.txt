CREATE TABLE test
(
    t String,
    id String,
    h Map(String, String)   
)
ENGINE = MergeTree
ORDER BY (t, id) SETTINGS index_granularity = 4096;
insert into test values ('xxx', 'x', {'content-type':'text/plain','user-agent':'bulk-tests'});
insert into test values ('xxx', 'y', {'content-type':'application/json','user-agent':'bulk-tests'});
insert into test select 'xxx', number, map('content-type', 'x' ) FROM numbers(1e2);
