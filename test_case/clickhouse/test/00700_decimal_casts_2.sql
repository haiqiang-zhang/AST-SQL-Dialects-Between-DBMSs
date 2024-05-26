SELECT toDecimal128('1234567890', 28) AS x, toDecimal128(x, 29), toDecimal128(toDecimal128('1234567890', 28), 29);
SELECT toDecimal64('1234567890', 8) AS x, toDecimal64(x, 9), toDecimal64(toDecimal64('1234567890', 8), 9);
SELECT toDecimal32('12345678', 1) AS x, toDecimal32(x, 2), toDecimal32(toDecimal32('12345678', 1), 2);
SELECT toDecimal128('9223372036854775807', 6) AS x, toInt64(x), toInt64(-x);
SELECT toDecimal128('2147483647', 10) AS x, toInt32(x), toInt32(-x);
SELECT toDecimal128('-0.9', 8) AS x, toUInt64(x);
SELECT toDecimal128('-0.8', 4) AS x, toUInt32(x);
SELECT toDecimal128('-0.7', 2) AS x, toUInt16(x);
SELECT toDecimal128('-0.6', 6) AS x, toUInt8(x);
