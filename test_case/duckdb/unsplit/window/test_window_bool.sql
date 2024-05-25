PRAGMA enable_verification;
create table a as select range%2==0 j, range::integer AS i from range(1, 5, 1);
drop table a;
create table a as select range%2 j, range%3==0 AS i from range(1, 5, 1);
select j, i, bool_and(i) over (), bool_or(i) over () from a order by 1,2;
select j, i, bool_and(i) over (partition by j), bool_or(i) over (partition by j) from a order by 1,2;
select j, i, bool_and(not i) over (partition by j order by i), bool_and(i) over (partition by j order by i), bool_or(i) over (partition by j order by i) from a order by 1,2;
