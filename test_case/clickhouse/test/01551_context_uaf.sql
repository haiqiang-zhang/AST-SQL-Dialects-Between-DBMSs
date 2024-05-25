create view v as (select * from f);
select * from v;
select * from merge('', 'f');
DROP TABLE f;
DROP TABLE v;
