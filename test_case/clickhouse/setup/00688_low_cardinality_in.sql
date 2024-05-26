set allow_suspicious_low_cardinality_types = 1;
drop table if exists lc_00688;
create table lc_00688 (str StringWithDictionary, val UInt8WithDictionary) engine = MergeTree order by tuple();
insert into lc_00688 values ('a', 1), ('b', 2);
