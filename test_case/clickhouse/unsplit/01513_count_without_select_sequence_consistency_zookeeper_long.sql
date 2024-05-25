SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS quorum1 SYNC;
DROP TABLE IF EXISTS quorum2 SYNC;
DROP TABLE IF EXISTS quorum3 SYNC;
SET select_sequential_consistency=0;
SET optimize_trivial_count_query=1;
SET insert_quorum=2, insert_quorum_parallel=0;
SYSTEM STOP FETCHES quorum1;
