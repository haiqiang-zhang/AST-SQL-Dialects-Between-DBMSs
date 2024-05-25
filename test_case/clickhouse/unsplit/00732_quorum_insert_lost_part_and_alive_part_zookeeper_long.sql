SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS quorum1;
DROP TABLE IF EXISTS quorum2;
SET insert_quorum=2, insert_quorum_parallel=0;
SET select_sequential_consistency=1;
SET insert_quorum_timeout=0;
SYSTEM STOP FETCHES quorum1;
SET select_sequential_consistency=0;
SET select_sequential_consistency=1;
SYSTEM START FETCHES quorum1;