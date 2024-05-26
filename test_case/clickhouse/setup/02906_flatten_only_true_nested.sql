set flatten_nested = 1;
drop table if exists test_nested;
create table test_nested (data Nested(x UInt32, y UInt32)) engine=Memory;
