DROP TABLE IF EXISTS decimal;
CREATE TABLE decimal
(
    a Array(Decimal32(3)),
    b Array(Decimal64(3)),
    c Array(Decimal128(3)),
    nest Nested
    (
        a Decimal(9,2),
        b Decimal(18,2),
        c Decimal(38,2)
    ),
    tup Tuple(Decimal32(1), Decimal64(1), Decimal128(1))
) ENGINE = Memory;
INSERT INTO decimal (a, b, c, nest.a, nest.b, nest.c, tup)
    VALUES ([0.1, 0.2, 0.3], [0.4, 0.5, 0.6], [0.7, 0.8, 0.9], [1.1, 1.2], [2.1, 2.2], [3.1, 3.2], (9.1, 9.2, 9.3));
SELECT toTypeName(a), toTypeName(b), toTypeName(c) FROM decimal;
SELECT arrayJoin(a) FROM decimal;
SELECT tup, tup.1, tup.2, tup.3 FROM decimal;
SELECT a, arrayPopBack(a), arrayPopFront(a), arrayResize(a, 1), arraySlice(a, 2, 1) FROM decimal;
SELECT arrayPushBack(a, toDecimal32(0, 3)), arrayPushFront(a, toDecimal32(0, 3)) FROM decimal;
SELECT length(a), length(b), length(c) FROM decimal;
SELECT empty(a), empty(b), empty(c) FROM decimal;
SELECT notEmpty(a), notEmpty(b), notEmpty(c) FROM decimal;
SELECT arrayUniq(a), arrayUniq(b), arrayUniq(c) FROM decimal;
SELECT has(a, toDecimal32(0.1, 3)), has(a, toDecimal32(1.0, 3)) FROM decimal;
SELECT indexOf(a, toDecimal32(0.1, 3)), indexOf(a, toDecimal32(1.0, 3)) FROM decimal;
SELECT toDecimal32(12345.6789, 4) AS x, countEqual([x+1, x, x], x), countEqual([x, x-1, x], x), countEqual([x, x], x-0);
SELECT number % 2 ? toDecimal32('32.1', 5) : toDecimal32('32.2', 5) FROM system.numbers LIMIT 2;
SELECT number % 2 ? toDecimal32('32.1', 5) : toDecimal64('64.2', 5) FROM system.numbers LIMIT 2;
SELECT number % 2 ? toDecimal32('32.1', 5) : toDecimal128('128.2', 5) FROM system.numbers LIMIT 2;
SELECT number % 2 ? toDecimal64('64.1', 5) : toDecimal64('64.2', 5) FROM system.numbers LIMIT 2;
SELECT number % 2 ? toDecimal64('64.1', 5) : toDecimal128('128.2', 5) FROM system.numbers LIMIT 2;
SELECT number % 2 ? toDecimal128('128.1', 5) : toDecimal128('128.2', 5) FROM system.numbers LIMIT 2;
DROP TABLE IF EXISTS decimal;
