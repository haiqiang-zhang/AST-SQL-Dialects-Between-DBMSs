SELECT dictGet('dictdb_01376.dict_exists', 'value', toUInt64(1)) as val FROM numbers(2) GROUP BY val;
EXPLAIN SYNTAX SELECT dictGet('dictdb_01376.dict_exists', 'value', toUInt64(1)) as val FROM numbers(2) GROUP BY val;
DROP DICTIONARY dictdb_01376.dict_exists;
DROP TABLE dictdb_01376.table_for_dict;
DROP DATABASE dictdb_01376;
