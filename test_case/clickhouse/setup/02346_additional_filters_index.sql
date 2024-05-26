create table table_1 (x UInt32, y String, INDEX a (length(y)) TYPE minmax GRANULARITY 1) engine = MergeTree order by x settings index_granularity = 2;
insert into table_1 values (1, 'a'), (2, 'bb'), (3, 'ccc'), (4, 'dddd');
set max_rows_to_read = 2;
