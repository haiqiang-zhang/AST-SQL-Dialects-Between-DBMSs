SYSTEM STOP FETCHES quorum1;
SET select_sequential_consistency=0;
SET select_sequential_consistency=1;
SET insert_quorum_timeout=100;
SYSTEM START FETCHES quorum1;
