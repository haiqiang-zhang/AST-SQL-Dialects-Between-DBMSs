SELECT 'Non constant map';
INSERT INTO test_map VALUES ({'K0':'V0'});
SELECT has(value, 'K0') FROM test_map;
SELECT 'Constant map';
DROP TABLE test_map;
