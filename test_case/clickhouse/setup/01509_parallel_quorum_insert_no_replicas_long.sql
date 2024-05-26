DROP TABLE IF EXISTS r1 SYNC;
DROP TABLE IF EXISTS r2 SYNC;
SET insert_quorum_parallel=1;
SET insert_quorum=3;
