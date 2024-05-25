select *, _part from mt order by _part;
alter table  mt update n = n + (n not in m) in partition id '1' where 1 settings mutations_sync=1;
drop table m;
optimize table mt final;
select mutation_id, command, parts_to_do_names, parts_to_do, is_done from system.mutations where database=currentDatabase();
select * from mt order by p, n;
drop table mt;
