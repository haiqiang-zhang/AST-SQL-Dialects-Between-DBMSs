DROP DATABASE IF EXISTS database_for_dict;
CREATE DATABASE database_for_dict;
DROP TABLE IF EXISTS database_for_dict.table_for_dict;
CREATE TABLE database_for_dict.table_for_dict
(
  key_column UInt64,
  second_column UInt64,
  third_column String
)
ENGINE = MergeTree()
ORDER BY key_column;
INSERT INTO database_for_dict.table_for_dict VALUES (100500, 10000000, 'Hello world');
DROP DATABASE IF EXISTS ordinary_db;
CREATE DATABASE ordinary_db;
DROP DICTIONARY IF EXISTS ordinary_db.dict1;
CREATE DICTIONARY ordinary_db.dict1
(
  key_column UInt64 DEFAULT 0,
  second_column UInt64 DEFAULT 1,
  third_column String DEFAULT 'qqq'
)
PRIMARY KEY key_column
SOURCE(CLICKHOUSE(HOST 'localhost' PORT tcpPort() USER 'default' TABLE 'table_for_dict' PASSWORD '' DB 'database_for_dict'))
LIFETIME(MIN 1 MAX 10)
LAYOUT(FLAT()) SETTINGS(max_result_bytes=1);
SELECT 'INITIALIZING DICTIONARY';
SELECT 'END';
DROP DICTIONARY IF EXISTS ordinary_db.dict1;
DROP DATABASE IF EXISTS ordinary_db;
DROP TABLE IF EXISTS database_for_dict.table_for_dict;
DROP DATABASE IF EXISTS database_for_dict;
