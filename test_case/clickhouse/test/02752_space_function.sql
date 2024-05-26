SELECT 'const, uint';
SELECT space(3::UInt8), length(space(3::UInt8));
SELECT 'const, int';
SELECT 'const, int, negative';
SELECT 'negative tests';
SELECT 'null';
SELECT space(NULL);
DROP TABLE IF EXISTS defaults;
CREATE TABLE defaults
(
    u8 UInt8,
    u16 UInt16,
    u32 UInt32,
    u64 UInt64,
    i8 Int8,
    i16 Int16,
    i32 Int32,
    i64 Int64
) ENGINE = Memory();
INSERT INTO defaults values (3, 12, 4, 56, 3, 12, -4, 56) (2, 10, 21, 20, 2, 10, -21, 20) (1, 4, 9, 5, 1, 4, -9, 5) (0, 5, 7, 7, 0, 5, -7, 7);
SELECT 'const, uint, multiple';
SELECT 'const int, multiple';
SELECT 'non-const, uint';
SELECT 'non-const, int';
DROP TABLE defaults;
