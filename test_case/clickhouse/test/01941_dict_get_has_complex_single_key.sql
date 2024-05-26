SELECT 'dictGet';
SELECT dictGet('test_dictionary', 'value', tuple('Key'));
SELECT 'dictHas';
SELECT dictHas('test_dictionary', tuple('Key'));
DROP DICTIONARY test_dictionary;
DROP TABLE test_dictionary_source;
