system stop cleanup rmt;
system stop merges rmt1;
select 0;
system stop cleanup rmt;
system stop merges rmt1;
set insert_keeper_fault_injection_probability=0;
system stop cleanup rmt3;
