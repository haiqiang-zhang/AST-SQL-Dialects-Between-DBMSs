set allow_suspicious_low_cardinality_types=1;
set allow_experimental_analyzer=1;
create table tab (x LowCardinality(Nullable(Float64))) engine = MergeTree order by x settings allow_nullable_key=1;
insert into tab select number from numbers(2);
