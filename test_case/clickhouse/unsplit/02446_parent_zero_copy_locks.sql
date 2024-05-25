-- Probably that's why we have to replace repsistent lock with ephemeral sometimes.
-- See also "Replacing persistent lock with ephemeral for path {}. It can happen only in case of local part loss"
-- in StorageReplicatedMergeTree::createZeroCopyLockNode
set insert_keeper_fault_injection_probability=0;
select sleepEachRow(0.5) as test_does_not_rely_on_this;
set optimize_throw_if_noop=1;
select *, _state from system.parts where database=currentDatabase() and table like 'rmt%' and active=0;
set allow_unrestricted_reads_from_keeper=1;
