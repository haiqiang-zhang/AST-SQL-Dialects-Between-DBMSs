system stop replicated sends rmt_master;
system flush logs;
select 'before';
system start replicated sends rmt_master;
system flush logs;
select 'after';
