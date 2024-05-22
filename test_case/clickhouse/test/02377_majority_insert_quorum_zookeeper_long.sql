-- no-replicated-database:
--   The number of replicas is doubled, so `SYSTEM STOP FETCHES` stop not enough replicas.

SET insert_quorum_parallel = false;
SET select_sequential_consistency = 1;
DROP TABLE IF EXISTS quorum1;
DROP TABLE IF EXISTS quorum2;
DROP TABLE IF EXISTS quorum3;
SET insert_quorum = 'auto';
SET insert_keeper_fault_injection_probability=0;
-- stop replica 3
SYSTEM STOP FETCHES quorum3;
-- Sync replica 3
SYSTEM START FETCHES quorum3;
SYSTEM STOP FETCHES quorum2;
SYSTEM STOP FETCHES quorum3;
SET insert_quorum_timeout = 5000;
SYSTEM START FETCHES quorum2;
SYSTEM START FETCHES quorum3;
SET insert_quorum_timeout = 600000;
