DROP TABLE IF EXISTS checksums_r3;
DROP TABLE IF EXISTS checksums_r2;
DROP TABLE IF EXISTS checksums_r1;
SYSTEM STOP REPLICATION QUEUES checksums_r2;
SYSTEM STOP REPLICATION QUEUES checksums_r3;
SYSTEM START REPLICATION QUEUES checksums_r2;
SYSTEM START REPLICATION QUEUES checksums_r3;
SYSTEM FLUSH LOGS;
DROP TABLE IF EXISTS checksums_r3;
DROP TABLE IF EXISTS checksums_r2;
DROP TABLE IF EXISTS checksums_r1;
