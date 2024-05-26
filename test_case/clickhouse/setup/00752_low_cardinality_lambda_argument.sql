set allow_suspicious_low_cardinality_types=1;
drop table if exists lc_lambda;
create table lc_lambda (arr Array(LowCardinality(UInt64))) engine = Memory;
insert into lc_lambda select range(number) from system.numbers limit 10;
