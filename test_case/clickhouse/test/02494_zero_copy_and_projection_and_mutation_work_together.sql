SYSTEM STOP REPLICATION QUEUES wikistat2;
SYSTEM START REPLICATION QUEUES wikistat2;
-- Such condition will lead to successful queries.
SET function_sleep_max_microseconds_per_block = 5000000;
