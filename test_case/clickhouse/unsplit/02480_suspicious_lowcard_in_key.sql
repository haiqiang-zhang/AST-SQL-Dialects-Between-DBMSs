set allow_suspicious_low_cardinality_types=1;
drop table if exists test;
create table test (val LowCardinality(Float32)) engine MergeTree order by val;
insert into test values (nan);
drop table if exists test;
