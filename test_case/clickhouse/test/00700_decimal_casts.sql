SELECT toDecimal32('1.1', 1), toDecimal32('1.1', 2), toDecimal32('1.1', 8);
SELECT '0.1' AS x, toDecimal64(x, 0);
SELECT '0.1' AS x, toDecimal128(x, 0);
SELECT toFloat32(9999999)   as x, toDecimal32(x, 0), toDecimal32(-x, 0), toDecimal64(x, 0), toDecimal64(-x, 0);
SELECT toInt32(999999999) as x, toDecimal64(x, 9), toDecimal64(-x, 9), toDecimal128(x, 29), toDecimal128(-x, 29);
SELECT CAST('42.4200', 'Decimal(9,2)') AS a, CAST(a, 'Decimal(9,2)'), CAST(a, 'Decimal(18, 2)'), CAST(a, 'Decimal(38, 2)');
