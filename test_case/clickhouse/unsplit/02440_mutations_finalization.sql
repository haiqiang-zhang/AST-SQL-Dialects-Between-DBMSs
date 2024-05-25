set insert_keeper_fault_injection_probability=0;
system stop merges mut;
select mutation_id, command, parts_to_do_names, is_done from system.mutations where database=currentDatabase() and table='mut';
create table tmp (n int) engine=MergeTree order by tuple() settings index_granularity=1;
insert into tmp select * from numbers(1000);
alter table tmp update n = sleepEachRow(1) where 1;
select mutation_id, command, parts_to_do_names, is_done from system.mutations where database=currentDatabase() and table='mut';
select mutation_id, command, parts_to_do_names from system.mutations where database=currentDatabase() and table='mut';
drop table tmp;
