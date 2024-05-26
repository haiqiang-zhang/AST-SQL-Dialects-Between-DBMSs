SELECT dictGetOrDefault('range_dictionary', 'value', toUInt64(2), toDate(toLowCardinality(materialize('2019-05-15'))), 2);
DROP DICTIONARY IF EXISTS range_dictionary;
DROP TABLE IF EXISTS range_dictionary_nullable_source_table;
