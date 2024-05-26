select 1 intersect select 1;
select 2 intersect select 1;
select 1 except select 1;
select 2 except select 1;
select number from numbers(20) intersect select number from numbers(5, 5);
select 1 except select 2 intersect select 1;
select 1 except select 2 intersect select 2;
select 1 intersect select 1 except select 2;
select 1 intersect select 1 except select 1;
select 1 intersect select 1 except select 2 intersect select 1 except select 3 intersect select 1;
select 1 intersect select 1 except select 2 intersect select 1 except select 3 intersect select 2;
select 1 intersect select 1 except select 2 intersect select 1 except select 3 intersect select 2 except select 1;
select * from (select 1 intersect select 1);
with (select number from numbers(10) intersect select 5) as a select a * 10;
with (select 5 except select 1) as a select a except select 5;
with (select number from numbers(10) intersect select 5) as a select a intersect select 1;
with (select number from numbers(10) intersect select 5) as a select a except select 1;
select count() from (select number from numbers(10) except select 5);
with (select count() from (select 1 union distinct select 2 except select 1)) as max
select count() from (select 1 union all select max) limit 100;
select 1 union all select 1 intersect select 1;
select 1 union all select 1 intersect select 2;
select * from (select 1 union all select 2 union all select 3 union all select 4 except select 3 union all select 5) order by 1;
select * from (select 1 union all select 2 union all select 3 union all select 4 intersect select 3 union all select 5) order by 1;
select * from (select 1 union all select 2 union all select 3 union all select 4 intersect select 3 union all select 5 except select 1) order by 1;
select 1 intersect (select 1 except select 2);
select 1 union all select 2  except (select 2 except select 1 union all select 1) except select 4;
explain syntax select 1 intersect select 1;
explain syntax select 1 except select 1;
explain syntax select 1 union all select 2  except (select 2 except select 1 union all select 1) except select 4;
set limit=1;
select 1 intersect select 1;
(((select 1) intersect select 1));
