select *, toTypeName(b) from tab_00718;
alter table tab_00718 modify column b UInt32;
alter table tab_00718 modify column b LowCardinality(UInt32);
alter table tab_00718 modify column b StringWithDictionary;
alter table tab_00718 modify column b LowCardinality(UInt32);
alter table tab_00718 modify column b String;
alter table tab_00718 modify column b LowCardinality(UInt32);
drop table if exists tab_00718;
