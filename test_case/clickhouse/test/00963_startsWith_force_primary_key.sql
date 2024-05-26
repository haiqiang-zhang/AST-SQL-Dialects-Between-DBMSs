SELECT count() from test_startsWith where startsWith(a, 'a') settings force_primary_key=1;
DROP TABLE test_startsWith;
