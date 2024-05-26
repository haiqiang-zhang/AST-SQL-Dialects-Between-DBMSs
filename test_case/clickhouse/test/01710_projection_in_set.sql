select sum(j), avg(k) from x where i in (select number from numbers(4));
select j, k from x where i in (select number from numbers(4));
drop table x;
create table if not exists flows (SrcAS UInt32, Bytes UInt64) engine MergeTree() order by tuple();
insert into table flows values (15169, 83948), (12322, 98989), (60068, 99990), (15169, 89898), (15169, 83948), (15169, 89898), (15169, 83948), (15169, 89898), (15169, 83948), (15169, 89898), (15169, 83948), (15169, 89898);
select if(SrcAS in (select SrcAS from flows group by SrcAS order by sum(Bytes) desc limit 10) , SrcAS, 33) as SrcAS from flows where 2 == 2 order by SrcAS;
drop table flows;
