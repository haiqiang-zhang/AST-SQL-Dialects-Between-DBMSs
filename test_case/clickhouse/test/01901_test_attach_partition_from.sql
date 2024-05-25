SELECT count() FROM test_alter_attach_01901S;
INSERT INTO test_alter_attach_01901S VALUES (1, '2020-01-01');
SELECT count() FROM test_alter_attach_01901S;
DROP TABLE test_alter_attach_01901S;
