set allow_suspicious_low_cardinality_types = 1;
drop table if exists tab_00718;
create table tab_00718 (a String, b LowCardinality(UInt32)) engine = MergeTree order by a;
insert into tab_00718 values ('a', 1);
