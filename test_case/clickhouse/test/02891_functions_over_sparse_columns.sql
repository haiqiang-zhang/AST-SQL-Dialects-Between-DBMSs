select arrayMap(x -> (x <= key), [1]) from test;
drop table test;
