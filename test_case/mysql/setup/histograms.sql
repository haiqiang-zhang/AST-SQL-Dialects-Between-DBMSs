CREATE TABLE all_types (
  col_bool BOOLEAN,
  col_bit BIT(64),
  col_tinyint TINYINT,
  col_smallint SMALLINT,
  col_mediumint MEDIUMINT,
  col_integer INTEGER,
  col_bigint BIGINT,
  col_tinyint_unsigned TINYINT UNSIGNED,
  col_smallint_unsigned SMALLINT UNSIGNED,
  col_mediumint_unsigned MEDIUMINT UNSIGNED,
  col_integer_unsigned INTEGER UNSIGNED,
  col_bigint_unsigned BIGINT UNSIGNED,
  col_float FLOAT,
  col_double DOUBLE,
  col_decimal DECIMAL(65, 2),
  col_date DATE,
  col_time TIME,
  col_year YEAR,
  col_datetime DATETIME,
  col_timestamp TIMESTAMP NULL,
  col_char CHAR(255),
  col_varchar VARCHAR(255),
  col_tinytext TINYTEXT,
  col_text TEXT,
  col_mediumtext MEDIUMTEXT,
  col_longtext LONGTEXT,
  col_binary BINARY(255),
  col_varbinary VARBINARY(255),
  col_tinyblob TINYBLOB,
  col_blob BLOB,
  col_mediumblob MEDIUMBLOB,
  col_longblob LONGBLOB,
  col_enum ENUM('red', 'black', 'pink', 'white', 'purple'),
  col_set SET('one', 'two', 'three'));
INSERT INTO all_types VALUES (
  NULL,     # BOOLEAN
  NULL,     # BIT
  NULL,     # TINYINT
  NULL,     # SMALLINT
  NULL,     # MEDIUMINT
  NULL,     # INTEGER
  NULL,     # BIGINT
  NULL,     # TINYINT_UNSIGNED
  NULL,     # SMALLINT_UNSIGNED
  NULL,     # MEDIUMINT_UNSIGNED
  NULL,     # INTEGER_UNSIGNED
  NULL,     # BIGINT_UNSIGNED
  NULL,     # FLOAT
  NULL,     # DOUBLE
  NULL,     # DECIMAL(65, 2)
  NULL,     # DATE
  NULL,     # TIME
  NULL,     # YEAR
  NULL,     # DATETIME
  NULL,     # TIMESTAMP
  NULL,     # CHAR
  NULL,     # VARCHAR
  NULL,     # TINYTEXT
  NULL,     # TEXT
  NULL,     # MEDIUMTEXT
  NULL,     # LONGTEXT
  NULL,     # BINARY
  NULL,     # VARBINARY
  NULL,     # TINYBLOB
  NULL,     # BLOB
  NULL,     # MEDIUMBLOB
  NULL,     # LONGBLOB
  NULL,     # ENUM
  NULL);
INSERT INTO all_types VALUES (
  FALSE,                                                               # BOOLEAN
  b'0000000000000000000000000000000000000000000000000000000000000000', # BIT
  -128,                                                                # TINYINT
  -32768,                                                              # SMALLINT
  -8388608,                                                            # MEDIUMINT
  -2147483648,                                                         # INTEGER
  -9223372036854775808,                                                # BIGINT
  0,                                                                   # TINYINT_UNSIGNED
  0,                                                                   # SMALLINT_UNSIGNED
  0,                                                                   # MEDIUMINT_UNSIGNED
  0,                                                                   # INTEGER_UNSIGNED
  0,                                                                   # BIGINT_UNSIGNED
  -3.402823466E+38,                                                    # FLOAT
  -1.7976931348623157E+308,                                            # DOUBLE
  -999999999999999999999999999999999999999999999999999999999999999.99, # DECIMAL(65, 2)
  '1000-01-01',                                                        # DATE
  '-838:59:59.000000',                                                 # TIME
  1901,                                                                # YEAR
  '1000-01-01 00:00:00',                                               # DATETIME
  '1970-01-02 00:00:01',                                               # TIMESTAMP
  '',                                                                  # CHAR
  '',                                                                  # VARCHAR
  '',                                                                  # TINYTEXT
  '',                                                                  # TEXT
  '',                                                                  # MEDIUMTEXT
  '',                                                                  # LONGTEXT
  '',                                                                  # BINARY
  '',                                                                  # VARBINARY
  '',                                                                  # TINYBLOB
  '',                                                                  # BLOB
  '',                                                                  # MEDIUMBLOB
  '',                                                                  # LONGBLOB
  'red',                                                               # ENUM
  '');
INSERT INTO all_types VALUES (
  TRUE,                                                                # BOOLEAN
  b'1111111111111111111111111111111111111111111111111111111111111111', # BIT
  127,                                                                 # TINYINT
  32767,                                                               # SMALLINT
  8388607,                                                             # MEDIUMINT
  2147483647,                                                          # INTEGER
  9223372036854775807,                                                 # BIGINT
  255,                                                                 # TINYINT_UNSIGNED
  65535,                                                               # SMALLINT_UNSIGNED
  16777215,                                                            # MEDIUMINT_UNSIGNED
  4294967295,                                                          # INTEGER_UNSIGNED
  18446744073709551615,                                                # BIGINT_UNSIGNED
  3.402823466E+38,                                                     # FLOAT
  1.7976931348623157E+308,                                             # DOUBLE
  999999999999999999999999999999999999999999999999999999999999999.99,  # DECIMAL(65, 2)
  '9999-12-31',                                                        # DATE
  '838:59:59.000000',                                                  # TIME
  2155,                                                                # YEAR
  '9999-12-31 23:59:59',                                               # DATETIME
  '2038-01-19 03:14:07',                                               # TIMESTAMP
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # CHAR
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # VARCHAR
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # TINYTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # TEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # MEDIUMTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # LONGTEXT
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # BINARY
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # VARBINARY
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # TINYBLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # BLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # MEDIUMBLOB
  'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',                     # LONGBLOB
  'purple',                                                            # ENUM
  'three');
