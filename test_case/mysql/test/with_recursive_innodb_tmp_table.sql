
set session internal_tmp_mem_storage_engine='memory';

create table t1(a int);
insert into t1 values(1),(2),(3);
set big_tables=1;
set optimizer_switch='block_nested_loop=off';
select 0 as n
union all
select n+1 from qn where n<10)
select * from qn;
select 0 as n
union all
select 2*n+2 from qn where n<50
union all
select 2*n+1 from qn where n<50
)
select count(n),max(n) from qn;

set optimizer_switch=default;

set big_tables=1;

set big_tables=0;

set @@tmp_table_size=1024,@@max_heap_table_size=16384;

set @@tmp_table_size=30000,@@max_heap_table_size=30000;

set @@tmp_table_size=60000,@@max_heap_table_size=60000;
drop table t1;
set session internal_tmp_mem_storage_engine=default;
