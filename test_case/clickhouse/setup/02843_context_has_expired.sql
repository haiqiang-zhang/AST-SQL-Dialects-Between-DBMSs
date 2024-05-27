DROP DICTIONARY IF EXISTS 02843_dict;
DROP TABLE IF EXISTS 02843_source;
DROP TABLE IF EXISTS 02843_join;
CREATE TABLE 02843_source
(
  id UInt64,
  value String
)
ENGINE=Memory;
CREATE DICTIONARY 02843_dict
(
    id UInt64,
    value String
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(TABLE '02843_source'))
LAYOUT(DIRECT());