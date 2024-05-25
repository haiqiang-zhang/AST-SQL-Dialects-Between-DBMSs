DROP DICTIONARY IF EXISTS dict;
DROP TABLE IF EXISTS view;
CREATE DICTIONARY dict (id UInt32, value String)
PRIMARY KEY id
SOURCE(CLICKHOUSE(host 'localhost' port tcpPort() user 'default' db currentDatabase() table 'view'))
LAYOUT (HASHED()) LIFETIME (MIN 600 MAX 600);
SHOW CREATE dict;
DROP DICTIONARY dict;
