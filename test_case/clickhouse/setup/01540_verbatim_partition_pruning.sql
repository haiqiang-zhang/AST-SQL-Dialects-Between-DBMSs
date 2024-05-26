drop table if exists xy;
create table xy(x int, y int) engine MergeTree partition by intHash64(x) % 2 order by y settings index_granularity = 1;
insert into xy values (0, 2), (2, 3), (8, 4), (9, 5);
SET max_rows_to_read = 2;
