PRAGMA enable_verification;
create table test as
select '2021-02-04 19:30:00'::timestamp t;
select *
from test
where (t::date) = '2021-02-04'::date;
select *
from test
where (t::date) = '2021-02-04';
