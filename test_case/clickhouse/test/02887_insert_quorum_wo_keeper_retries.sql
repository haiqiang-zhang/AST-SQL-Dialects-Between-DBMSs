SET insert_keeper_fault_injection_probability=0;
SET insert_keeper_max_retries = 0;
SET insert_quorum = 2;
system enable failpoint replicated_merge_tree_insert_quorum_fail_0;
