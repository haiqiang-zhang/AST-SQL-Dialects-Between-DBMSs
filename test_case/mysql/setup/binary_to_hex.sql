DROP TABLE IF EXISTS t1, t2;
CREATE TABLE t1 (c1  TINYBLOB,
                 c2  BLOB,
                 c3  MEDIUMBLOB,
                 c4  LONGBLOB,
                 c5  TEXT,
                 c6  BIT(1),
                 c7  CHAR,
                 c8  VARCHAR(10),
                 c9  GEOMETRY) CHARACTER SET = binary;
INSERT INTO t1 VALUES ('tinyblob-text readable', 'blob-text readable',
                       'mediumblob-text readable', 'longblob-text readable',
                       'text readable', b'1', 'c', 'variable',
                        POINT(1, 1));
CREATE TABLE t2(id int, `col1` binary(10),`col2` blob);
INSERT INTO t2 VALUES (1, X'AB1234', X'123ABC'), (2, X'DE1234', X'123DEF');