drop table if exists t;
create table t (a Int) engine = MergeTree order by a;
insert into t select number < 20 ? 0 : 1 from numbers(50);
alter table t add column s String default 'foo';
select s from t prewhere a != 1 where rowNumberInBlock() % 2 = 0 limit 1;
drop table t;
