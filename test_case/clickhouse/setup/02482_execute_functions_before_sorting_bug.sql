set allow_suspicious_low_cardinality_types=1;
drop table if exists test;
create table test (x LowCardinality(Int32)) engine=Memory;
insert into test select 1;
insert into test select 2;
