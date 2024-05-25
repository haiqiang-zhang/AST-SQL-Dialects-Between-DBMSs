-- FIXME no-random-merge-tree-settings requires investigation

drop table if exists data_01513;
create table data_01513 (key String) engine=MergeTree() order by key;
insert into data_01513 select number%10e3 from numbers(2e6);
optimize table data_01513 final;
set max_memory_usage='500M';
set max_threads=1;
set max_block_size=500;
set max_bytes_before_external_group_by=0;
drop table data_01513;
