DROP TABLE IF EXISTS test_dictionary_source;
CREATE TABLE test_dictionary_source (key String, value String) ENGINE=TinyLog;
INSERT INTO test_dictionary_source VALUES ('Key', 'Value');
DROP DICTIONARY IF EXISTS test_dictionary;
CREATE DICTIONARY test_dictionary(key String, value String)
PRIMARY KEY key
LAYOUT(COMPLEX_KEY_HASHED())
SOURCE(CLICKHOUSE(TABLE 'test_dictionary_source'))
LIFETIME(0);
SELECT 'dictGet';
SELECT dictGet('test_dictionary', 'value', tuple('Key'));
SELECT 'dictHas';
SELECT dictHas('test_dictionary', tuple('Key'));
DROP DICTIONARY test_dictionary;
DROP TABLE test_dictionary_source;
