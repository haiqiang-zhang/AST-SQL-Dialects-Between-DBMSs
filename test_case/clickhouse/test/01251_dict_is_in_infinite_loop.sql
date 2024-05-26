SELECT dictIsIn('database_for_dict.dictionary_with_hierarchy', toUInt64(2), toUInt64(1));
SELECT dictGetHierarchy('database_for_dict.dictionary_with_hierarchy', toUInt64(11));
DROP DICTIONARY IF EXISTS database_for_dict.dictionary_with_hierarchy;
CREATE DICTIONARY database_for_dict.dictionary_with_hierarchy
(
    id UInt64, parent_id UInt64 HIERARCHICAL, value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(host 'localhost' port tcpPort() user 'default' db 'database_for_dict' table 'dict_source'))
LAYOUT(FLAT())
LIFETIME(MIN 1 MAX 1);
DROP DICTIONARY IF EXISTS database_for_dict.dictionary_with_hierarchy;
CREATE DICTIONARY database_for_dict.dictionary_with_hierarchy
(
    id UInt64, parent_id UInt64 HIERARCHICAL, value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(host 'localhost' port tcpPort() user 'default' db 'database_for_dict' table 'dict_source'))
LAYOUT(CACHE(SIZE_IN_CELLS 10))
LIFETIME(MIN 1 MAX 1);
DROP DICTIONARY database_for_dict.dictionary_with_hierarchy;
DROP TABLE database_for_dict.dict_source;
DROP DATABASE database_for_dict;
