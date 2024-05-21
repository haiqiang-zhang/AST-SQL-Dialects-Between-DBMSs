CREATE TABLE test_tuple (`p` DateTime, `i` int, `j` int) ENGINE = MergeTree PARTITION BY (toDate(p), i) ORDER BY j SETTINGS index_granularity = 1;
insert into test_tuple values (1, 1, 1);
