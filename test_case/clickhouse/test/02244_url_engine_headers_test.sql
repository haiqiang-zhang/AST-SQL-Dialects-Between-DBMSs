select * from url('http://127.0.0.1:8123?query=select+12', 'RawBLOB');
select * from url('http://127.0.0.1:8123?query=select+12', 'RawBLOB', headers('X-ClickHouse-Database'='default'));
drop table if exists url;
select * from url;