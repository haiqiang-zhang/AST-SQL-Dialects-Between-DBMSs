DROP TABLE IF EXISTS quorum1;
DROP TABLE IF EXISTS quorum2;
SET insert_keeper_fault_injection_probability=0;
SET insert_keeper_max_retries = 0;
SET insert_quorum = 2;
