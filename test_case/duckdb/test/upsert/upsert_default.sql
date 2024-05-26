select * from tbl;
insert into t values (1, 1) on conflict do nothing;
insert into t values (1, 1) on conflict do nothing;
insert into t values (1, 1) on conflict (i) do update set j = excluded.i;
