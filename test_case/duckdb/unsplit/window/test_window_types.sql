PRAGMA enable_verification;
create table a as select range%3::${type} j, range::${type} AS i from range(1, 7, 1);
drop table a;
select j, i, sum(i) over () from a order by 1,2;
select j, i, sum(i) over (partition by j) from a order by 1,2;
select j, i, sum(i) over (partition by j order by i) from a order by 1,2;
