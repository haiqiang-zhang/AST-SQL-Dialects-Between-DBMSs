SELECT '== Only last version remains after OPTIMIZE W/ CLEANUP ==';
OPTIMIZE TABLE test FINAL CLEANUP;
select * from test order by uid;
INSERT INTO test (*) VALUES ('d1', 1, 0), ('d1', 2, 1), ('d1', 3, 0), ('d1', 4, 1), ('d1', 5, 0), ('d2', 1, 0), ('d3', 1, 0), ('d4', 1, 0),  ('d5', 1, 0), ('d6', 1, 0), ('d6', 3, 1);
SELECT '== OPTIMIZE W/ CLEANUP (remove d6) ==';
OPTIMIZE TABLE test FINAL CLEANUP;
select * from test order by uid;
DROP TABLE IF EXISTS test;
