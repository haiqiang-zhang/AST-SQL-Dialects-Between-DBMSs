SET insert_quorum_parallel = false;
SET select_sequential_consistency = 1;
DROP TABLE IF EXISTS quorum1;
DROP TABLE IF EXISTS quorum2;
DROP TABLE IF EXISTS quorum3;
SET insert_quorum = 'auto';
SET insert_keeper_fault_injection_probability=0;
