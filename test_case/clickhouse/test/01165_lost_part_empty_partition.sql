system stop replicated sends rmt1;
select lost_part_count from system.replicas where database = currentDatabase() and table = 'rmt2';
SYSTEM FLUSH LOGS;
system stop replicated sends rmt1;
select lost_part_count from system.replicas where database = currentDatabase() and table = 'rmt2';
SYSTEM FLUSH LOGS;
system stop replicated sends rmt1;
