SELECT 'dictGet';
SELECT dictGet('ddl_dictionary_test', 'value', number) FROM system.numbers LIMIT 3;
SELECT 'dictHas';
SELECT dictHas('ddl_dictionary_test', number) FROM system.numbers LIMIT 3;
DROP TABLE ddl_dictonary_test_source;
DROP DICTIONARY ddl_dictionary_test;
