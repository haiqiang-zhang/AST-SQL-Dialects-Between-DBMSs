create materialized view mv1 to dst as select * from src;
create materialized view mv2 to dst as select * from src;
insert into src select * from numbers(1e6) settings log_queries=1, max_untracked_memory=0, parallel_view_processing=1;
system flush logs;
