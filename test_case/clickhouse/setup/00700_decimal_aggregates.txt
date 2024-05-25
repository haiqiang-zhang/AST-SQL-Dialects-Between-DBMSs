DROP TABLE IF EXISTS decimal;
CREATE TABLE decimal
(
    a Decimal32(4),
    b Decimal64(8),
    c Decimal128(8)
) ENGINE = Memory;
INSERT INTO decimal (a, b, c)
SELECT toDecimal32(number - 50, 4), toDecimal64(number - 50, 8) / 3, toDecimal128(number - 50, 8) / 5
FROM system.numbers LIMIT 101;
