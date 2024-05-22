-- Tag no-replicated-database: Fails due to additional replicas or shards

DROP TABLE IF EXISTS r1 SYNC;
DROP TABLE IF EXISTS r2 SYNC;
SET insert_quorum_parallel=1;
SET insert_quorum=3;
SELECT 'insert to two replicas works';
SET insert_quorum=2, insert_quorum_parallel=1;
SET insert_quorum=1, insert_quorum_parallel=1;
SELECT 'insert to single replica works';
SET insert_quorum=2, insert_quorum_parallel=1;
SELECT 'deduplication works';
SET insert_quorum=1, insert_quorum_parallel=1;
SET insert_quorum=3, insert_quorum_parallel=1;
-- work back ok when quorum=2
SET insert_quorum=2, insert_quorum_parallel=1;
SYSTEM STOP FETCHES r2;
SET insert_quorum_timeout=0;
SYSTEM START FETCHES r2;
SET insert_quorum_timeout=6000000;
SELECT 'insert happened';
DROP TABLE IF EXISTS r1 SYNC;
DROP TABLE IF EXISTS r2 SYNC;
