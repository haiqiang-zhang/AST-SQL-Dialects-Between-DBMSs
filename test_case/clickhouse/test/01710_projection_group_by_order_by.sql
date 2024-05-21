drop table if exists tp;
create table tp (type Int32, eventcnt UInt64, projection p (select sum(eventcnt), type group by type order by sum(eventcnt))) engine = MergeTree order by type;
drop table if exists tp;