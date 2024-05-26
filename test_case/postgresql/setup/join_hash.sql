begin;
set local min_parallel_table_scan_size = 0;
set local parallel_setup_cost = 0;
set local enable_hashjoin = on;
end;
end;
create table simple as
  select generate_series(1, 20000) AS id, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
alter table simple set (parallel_workers = 2);
