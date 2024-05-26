drop table if exists trunc;
set default_table_engine='ReplicatedMergeTree';
set default_table_engine='MergeTree';
create table trunc (n int, primary key n) partition by n % 10;
insert into trunc select * from numbers(20);
