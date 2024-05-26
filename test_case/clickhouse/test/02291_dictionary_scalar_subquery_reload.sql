SELECT * FROM test_dictionary;
INSERT INTO test_dictionary_source_table VALUES (4, '4');
SYSTEM RELOAD DICTIONARY test_dictionary;
SELECT * FROM test_dictionary;
DROP DICTIONARY test_dictionary;
DROP VIEW test_dictionary_view;
DROP TABLE test_dictionary_source_table;
