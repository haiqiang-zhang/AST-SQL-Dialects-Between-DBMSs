SELECT a, c FROM test_rlp WHERE c%2 == 0 AND b < 5;
DROP POLICY IF EXISTS test_rlp_policy ON test_rlp;
SELECT a, c FROM test_rlp WHERE b < 5 SETTINGS optimize_move_to_prewhere = 0;
SELECT a, c FROM test_rlp PREWHERE b < 5;
DROP TABLE test_rlp;
