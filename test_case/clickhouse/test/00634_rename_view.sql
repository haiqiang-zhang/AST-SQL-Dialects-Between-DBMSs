rename table v_test1 to v_test11, v_test2 to v_test22;
SELECT name, engine FROM system.tables WHERE name IN ('v_test1', 'v_test2', 'v_test11', 'v_test22') AND database = currentDatabase() ORDER BY name;
DROP TABLE test1_00634;
DROP TABLE test2_00634;
DROP TABLE v_test11;
DROP TABLE v_test22;
