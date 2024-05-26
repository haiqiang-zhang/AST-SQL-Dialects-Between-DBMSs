set max_bytes_before_external_sort = 0;
drop table if exists stack;
set max_insert_threads = 4;
create table stack(item_id Int64, brand_id Int64, rack_id Int64, dt DateTime, expiration_dt DateTime, quantity UInt64)
Engine = MergeTree 
partition by toYYYYMM(dt) 
order by (brand_id, toStartOfHour(dt)) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into stack 
select number%99991, number%11, number%1111, toDateTime('2020-01-01 00:00:00')+number/100, 
   toDateTime('2020-02-01 00:00:00')+number/10, intDiv(number,100)+1
from numbers_mt(10000000);
