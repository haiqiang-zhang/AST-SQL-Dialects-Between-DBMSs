DROP TABLE IF EXISTS decimal;
CREATE TABLE IF NOT EXISTS decimal
(
    a DECIMAL(9,0),
    b DECIMAL(18,0),
    c DECIMAL(38,0),
    d DECIMAL(9, 9),
    e DEC(18, 18),
    f dec(38, 38),
    g Decimal(9, 3),
    h decimal(18, 9),
    i deciMAL(38, 18),
    j dec(4, 2),
    k NumEriC(23, 4),
    l numeric(9, 3),
    m NUMEric(18, 9),
    n FixED(12, 6),
    o fixed(8, 6)
) ENGINE = Memory;
INSERT INTO decimal (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO decimal (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) VALUES (42, 42, 42, 0.42, 0.42, 0.42, 42.42, 42.42, 42.42, 42.42, 42.42, 42.42, 42.42, 42.42, 42.42);
INSERT INTO decimal (a, b, c, d, e, f, g, h, i, j, k, l, m, n, o) VALUES (-42, -42, -42, -0.42, -0.42, -0.42, -42.42, -42.42, -42.42, -42.42, -42.42, -42.42, -42.42, -42.42, -42.42);
SELECT a + a, a - a, a * a, a / a, intDiv(a, a), intDivOrZero(a, a) FROM decimal WHERE a = 42;
SELECT h + h, h - h FROM decimal WHERE h > 0;
SELECT i + i, i - i FROM decimal WHERE i > 0;
SELECT f + 21, f - 21, f - 84, f * 21, f * -21, f / 21, f / 84 FROM decimal WHERE f > 0;
SELECT 21 + f, 21 - f, 84 - f, 21 * f, -21 * f, 21 / f, 84 / f FROM decimal WHERE f > 0;
SELECT 21 + h, 21 - h, 84 - h, 21 * h, -21 * h FROM decimal WHERE h > 0;
SELECT a, -a, -b, -c, -d, -e, -f, -g, -h, -j from decimal ORDER BY a;
SELECT abs(a), abs(b), abs(c), abs(d), abs(e), abs(f), abs(g), abs(h), abs(j) from decimal ORDER BY a;
SET decimal_check_overflow = 0;
SELECT (h * h) != 0, (h / h) != 1 FROM decimal WHERE h > 0;
SELECT (i * i) != 0, (i / i) = 1 FROM decimal WHERE i > 0;
SELECT e + 1 > e, e + 10 > e, 1 + e > e, 10 + e > e FROM decimal WHERE e > 0;
SELECT f + 1 > f, f + 10 > f, 1 + f > f, 10 + f > f FROM decimal WHERE f > 0;
SELECT toDecimal32(0, 4) AS x, multiIf(x = 0, NULL, intDivOrZero(1, x)), multiIf(x = 0, NULL, intDivOrZero(x, 0));
SELECT toDecimal128(1, 38) / toDecimal128(1, 0) SETTINGS decimal_check_overflow=1;
SELECT toDecimal128(1, 38) / toDecimal128(1, 1) SETTINGS decimal_check_overflow=0;
SELECT toDecimal128(1, 37) / toDecimal128(1, 1) SETTINGS decimal_check_overflow=1;
SELECT toDecimal128(1, 19) / toDecimal128(1, 19) SETTINGS decimal_check_overflow=1;
DROP TABLE IF EXISTS decimal;
