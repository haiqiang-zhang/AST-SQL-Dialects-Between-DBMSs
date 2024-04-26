
--
-- Test of count(distinct ..)
--

--disable_warnings
drop table if exists t1;
create table t1(n int not null, key(n)) delay_key_write = 1;
let $1=100;
 dec $1;
select count(distinct n) from t1;
drop table t1;
