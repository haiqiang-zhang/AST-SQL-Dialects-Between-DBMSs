-- Probably that's why we have to replace repsistent lock with ephemeral sometimes.
-- See also "Replacing persistent lock with ephemeral for path {}. It can happen only in case of local part loss"
-- in StorageReplicatedMergeTree::createZeroCopyLockNode
set insert_keeper_fault_injection_probability=0;
set allow_unrestricted_reads_from_keeper=1;
