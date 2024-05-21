drop table if exists xp;
drop table if exists xp_d;
create table xp(A Date, B Int64, S String) Engine=MergeTree partition by toYYYYMM(A) order by B;
insert into xp select '2020-01-01', number , '' from numbers(100000);
drop table if exists xp;
drop table if exists xp_d;
