PRAGMA enable_verification;
create table test as select * from (values (42, 43), (44, 45)) v(i, j);;
select i, sum(j) as s from test group by i order by #1;;
