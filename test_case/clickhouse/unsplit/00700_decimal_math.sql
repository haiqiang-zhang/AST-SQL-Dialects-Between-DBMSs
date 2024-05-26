SELECT toDecimal32('42.42', 4) AS x, toDecimal32(log(x), 4) AS y, round(exp(y), 6);
SELECT toDecimal32('42.42', 4) AS x, toDecimal32(sqrt(x), 3) AS y, y * y;
SELECT toDecimal32('42.42', 4) AS x, toDecimal32(cbrt(x), 4) AS y, toDecimal64(y, 4) * y * y;
SELECT toDecimal32('1.0', 5) AS x, erf(x), erfc(x);
SELECT toDecimal32('1.0', 2) AS x, asin(x), acos(x), atan(x);
SELECT toDecimal64('42.42', 4) AS x, toDecimal32(sqrt(x), 3) AS y, y * y;
SELECT toDecimal64('42.42', 4) AS x, toDecimal32(cbrt(x), 4) AS y, toDecimal64(y, 4) * y * y;
SELECT toDecimal128('42.42', 4) AS x, toDecimal32(sqrt(x), 3) AS y, y * y;
SELECT toDecimal128('42.42', 4) AS x, toDecimal32(cbrt(x), 4) AS y, toDecimal64(y, 4) * y * y;
