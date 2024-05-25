DROP TABLE IF EXISTS mutations_and_quorum1 SYNC;
DROP TABLE IF EXISTS mutations_and_quorum2 SYNC;
SET insert_quorum=2, insert_quorum_parallel=0, insert_quorum_timeout=300e3;
SELECT COUNT() FROM system.mutations WHERE database = currentDatabase() AND table like 'mutations_and_quorum%' and is_done = 0;
DROP TABLE IF EXISTS mutations_and_quorum1 SYNC;
DROP TABLE IF EXISTS mutations_and_quorum2 SYNC;
