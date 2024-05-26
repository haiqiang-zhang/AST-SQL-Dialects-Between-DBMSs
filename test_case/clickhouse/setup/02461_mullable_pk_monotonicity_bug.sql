create table tab (x Nullable(UInt8)) engine = MergeTree order by x settings allow_nullable_key = 1, index_granularity = 2;
insert into tab select number from numbers(4);
set allow_suspicious_low_cardinality_types=1;
set max_rows_to_read = 2;
