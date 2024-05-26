SELECT COUNT() FROM system.mutations WHERE database = currentDatabase() AND table like 'mutations_and_quorum%' and is_done = 0;
DROP TABLE IF EXISTS mutations_and_quorum1 SYNC;
DROP TABLE IF EXISTS mutations_and_quorum2 SYNC;
