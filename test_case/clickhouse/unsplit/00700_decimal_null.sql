DROP TABLE IF EXISTS decimal;
CREATE TABLE IF NOT EXISTS decimal
(
    a DEC(9, 2),
    b DEC(18, 5),
    c DEC(38, 5),
    d Nullable(DEC(9, 4)),
    e Nullable(DEC(18, 8)),
    f Nullable(DEC(38, 8))
) ENGINE = Memory;
SELECT toNullable(toDecimal32(32, 0)) AS x, assumeNotNull(x);
SELECT ifNull(toDecimal32(1, 0), NULL), ifNull(toDecimal64(1, 0), NULL), ifNull(toDecimal128(1, 0), NULL);
SELECT coalesce(toDecimal32(5, 0), NULL), coalesce(toDecimal64(5, 0), NULL), coalesce(toDecimal128(5, 0), NULL);
SELECT nullIf(toNullable(toDecimal32(1, 0)), toDecimal32(1, 0)), nullIf(toNullable(toDecimal64(1, 0)), toDecimal64(1, 0));
INSERT INTO decimal (a, b, c, d, e, f) VALUES (1.1, 1.1, 1.1, 1.1, 1.1, 1.1);
INSERT INTO decimal (a, b, c, d) VALUES (2.2, 2.2, 2.2, 2.2);
INSERT INTO decimal (a, b, c, e) VALUES (3.3, 3.3, 3.3, 3.3);
INSERT INTO decimal (a, b, c, f) VALUES (4.4, 4.4, 4.4, 4.4);
INSERT INTO decimal (a, b, c) VALUES (5.5, 5.5, 5.5);
SELECT * FROM decimal ORDER BY d, e, f;
SELECT isNull(a), isNotNull(a) FROM decimal WHERE a = toDecimal32(5.5, 1);
SELECT count() FROM decimal WHERE a IS NOT NULL;
DROP TABLE IF EXISTS decimal;
