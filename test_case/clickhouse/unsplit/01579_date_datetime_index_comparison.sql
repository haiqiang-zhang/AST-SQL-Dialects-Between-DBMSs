drop table if exists test_index;
create table test_index(date Date) engine MergeTree partition by toYYYYMM(date) order by date;
insert into test_index values('2020-10-30');
select 1 from test_index where date < toDateTime('2020-10-30 06:00:00');
drop table if exists test_index;
select toTypeName([-1, toUInt32(1)]);
