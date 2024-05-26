SELECT '-- argument validation';
SELECT substring(materialize('hello'), -1, -1);
SELECT '-- FixedString arguments';
SELECT '-- Enum arguments';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab(e8 Enum8('hello' = -5, 'world' = 15), e16 Enum16('shark' = -999, 'eagle' = 9999)) ENGINE MergeTree ORDER BY tuple();
INSERT INTO TABLE tab VALUES ('hello', 'shark'), ('world', 'eagle');
SELECT '-- Constant enums';
DROP TABLE tab;
SELECT '-- negative offset argument';
SELECT '-- negative length argument';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab (s String, l Int8, r Int8) ENGINE = Memory;
INSERT INTO tab VALUES ('abcdefgh', 2, -2), ('12345678', 3, -3);
DROP TABLE IF EXISTS tab;
CREATE TABLE tab (s FixedString(8), l Int8, r Int8) ENGINE = Memory;
INSERT INTO tab VALUES ('abcdefgh', 2, -2), ('12345678', 3, -3);
DROP TABLE IF EXISTS tab;
SELECT '-- negative offset and size';
DROP TABLE IF EXISTS t;
CREATE TABLE t
(
    s String,
    l Int8,
    r Int8
) ENGINE = Memory;
INSERT INTO t VALUES ('abcdefgh', -2, -2),('12345678', -3, -3);
SELECT '-';
DROP TABLE IF EXISTS t;
CREATE TABLE t(
                  s FixedString(8),
                  l Int8,
                  r Int8
) engine = Memory;
INSERT INTO t VALUES ('abcdefgh', -2, -2),('12345678', -3, -3);
DROP table if exists t;
SELECT '-- UBSAN bug';
SELECT '-- Alias';
SELECT byteSlice('hello', 2, 2);
