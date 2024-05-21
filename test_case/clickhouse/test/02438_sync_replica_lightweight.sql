system stop replicated sends rmt1;
system stop merges rmt2;
set insert_keeper_fault_injection_probability=0;
select type, new_part_name from system.replication_queue where database=currentDatabase() and table='rmt2' order by new_part_name;
set optimize_throw_if_noop = 1;
system start replicated sends rmt1;
select type, new_part_name from system.replication_queue where database=currentDatabase() and table='rmt2' order by new_part_name;
select type, new_part_name from system.replication_queue where database=currentDatabase() and table='rmt2' order by new_part_name;
system start merges rmt2;
