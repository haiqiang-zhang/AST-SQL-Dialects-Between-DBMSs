SELECT
    toTypeName(ui64), toTypeName(i64),
    toTypeName(ui32), toTypeName(i32),
    toTypeName(ui16), toTypeName(i16),
    toTypeName(ui8), toTypeName(i8)
FROM generateRandom('ui64 UInt64, i64 Int64, ui32 UInt32, i32 Int32, ui16 UInt16, i16 Int16, ui8 UInt8, i8 Int8')
LIMIT 1;
SELECT
    ui64, i64,
    ui32, i32,
    ui16, i16,
    ui8, i8
FROM generateRandom('ui64 UInt64, i64 Int64, ui32 UInt32, i32 Int32, ui16 UInt16, i16 Int16, ui8 UInt8, i8 Int8', 1, 10, 10)
LIMIT 10;
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT '-';
SELECT
    hex(i)
FROM generateRandom('i FixedString(4)', 1, 10, 10)
LIMIT 10;
SELECT '-';
SELECT '-';
DROP TABLE IF EXISTS test_table;
CREATE TABLE test_table(a Array(Int8), d Decimal32(4), c Tuple(DateTime64(3, 'UTC'), UUID)) ENGINE=Memory;
INSERT INTO test_table SELECT * FROM generateRandom('a Array(Int8), d Decimal32(4), c Tuple(DateTime64(3, \'UTC\'), UUID)', 1, 10, 2)
LIMIT 10;
SELECT * FROM test_table ORDER BY a, d, c;
DROP TABLE IF EXISTS test_table;
SELECT '-';
DROP TABLE IF EXISTS test_table_2;
CREATE TABLE test_table_2(a Array(Int8), b UInt32, c Nullable(String), d Decimal32(4), e Nullable(Enum16('h' = 1, 'w' = 5 , 'o' = -200)), f Float64, g Tuple(Date, DateTime('UTC'), DateTime64(3, 'UTC'), UUID), h FixedString(2)) ENGINE=Memory;
INSERT INTO test_table_2 SELECT * FROM generateRandom('a Array(Int8), b UInt32, c Nullable(String), d Decimal32(4), e Nullable(Enum16(\'h\' = 1, \'w\' = 5 , \'o\' = -200)), f Float64, g Tuple(Date, DateTime(\'UTC\'), DateTime64(3, \'UTC\'), UUID), h FixedString(2)', 10, 5, 3)
LIMIT 10;
SELECT a, b, c, d, e, f, g, hex(h) FROM test_table_2 ORDER BY a, b, c, d, e, f, g, h;
SELECT '-';
DROP TABLE IF EXISTS test_table_2;
