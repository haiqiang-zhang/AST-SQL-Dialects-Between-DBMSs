set insert_keeper_fault_injection_probability=0;
system stop merges mut;
select type, new_part_name, parts_to_merge from system.replication_queue where database=currentDatabase() and table='mut';
system start merges mut;
set receive_timeout=30;
