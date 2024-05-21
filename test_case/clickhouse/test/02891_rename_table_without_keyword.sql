DROP DATABASE IF EXISTS {CLICKHOUSE_DATABASE:Identifier};
CREATE DATABASE IF NOT EXISTS {CLICKHOUSE_DATABASE:Identifier};
CREATE TABLE IF NOT EXISTS {CLICKHOUSE_DATABASE:Identifier}.r1 (name String) Engine=Memory();
SHOW TABLES FROM {CLICKHOUSE_DATABASE:Identifier};
RENAME TABLE {CLICKHOUSE_DATABASE:Identifier}.r1 TO {CLICKHOUSE_DATABASE:Identifier}.r1_bak;
SHOW TABLES FROM {CLICKHOUSE_DATABASE:Identifier};
RENAME {CLICKHOUSE_DATABASE:Identifier}.r1_bak TO {CLICKHOUSE_DATABASE:Identifier}.r1;
SHOW TABLES FROM {CLICKHOUSE_DATABASE:Identifier};
CREATE TABLE IF NOT EXISTS {CLICKHOUSE_DATABASE:Identifier}.r2 (name String) Engine=Memory();
RENAME {CLICKHOUSE_DATABASE:Identifier}.r1 TO {CLICKHOUSE_DATABASE:Identifier}.r1_bak,
       {CLICKHOUSE_DATABASE:Identifier}.r2 TO {CLICKHOUSE_DATABASE:Identifier}.r2_bak;
SHOW TABLES FROM {CLICKHOUSE_DATABASE:Identifier};
CREATE TABLE IF NOT EXISTS {CLICKHOUSE_DATABASE:Identifier}.source_table (
                id UInt64,
                value String
            ) ENGINE = Memory;
CREATE DICTIONARY IF NOT EXISTS {CLICKHOUSE_DATABASE:Identifier}.test_dictionary
(
    id UInt64,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '{CLICKHOUSE_DATABASE:String}.dictionary_table'))
LAYOUT(FLAT())
LIFETIME(MIN 0 MAX 1000);
SHOW DICTIONARIES FROM {CLICKHOUSE_DATABASE:Identifier};
RENAME {CLICKHOUSE_DATABASE:Identifier}.test_dictionary TO {CLICKHOUSE_DATABASE:Identifier}.test_dictionary_2;
SHOW DICTIONARIES FROM {CLICKHOUSE_DATABASE:Identifier};
SHOW DATABASES LIKE '{CLICKHOUSE_DATABASE:String}';
RENAME {CLICKHOUSE_DATABASE:Identifier} TO {CLICKHOUSE_DATABASE_1:Identifier};
SHOW DATABASES LIKE '{CLICKHOUSE_DATABASE:String}';
DROP DATABASE IF EXISTS {CLICKHOUSE_DATABASE:Identifier};