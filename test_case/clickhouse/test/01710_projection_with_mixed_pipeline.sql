alter table t add projection p (select uniqHLL12(x));
insert into t select number + 100 from numbers(100);
drop table if exists t;
