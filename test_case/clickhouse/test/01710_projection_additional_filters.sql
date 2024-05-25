SELECT count(), min(a), max(a) FROM t SETTINGS additional_table_filters = {'t' : '0'};
DROP TABLE t;
drop table if exists atf_p;
create table atf_p (x UInt64) engine = MergeTree order by tuple();
insert into atf_p select number from numbers(10);
select count() from atf_p settings additional_table_filters = {'atf_p': 'x <= 2'};
drop table atf_p;
