alter table t add column s String default 'foo';
select s from t prewhere a != 1 where rowNumberInBlock() % 2 = 0 limit 1;
drop table t;
