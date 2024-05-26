SELECT toUInt32(number) y, toDecimal32(y, 1), toDecimal64(y, 5), toDecimal128(y, 6), toDecimal256(y, 7) FROM numbers(1);
SELECT toInt32(toDecimal32(number, 1)), toInt64(toDecimal32(number, 1)), toInt128(toDecimal32(number, 1)) FROM numbers(9, 1);
SELECT toFloat32(toDecimal32(number, 1)), toFloat32(toDecimal64(number, 2)), toFloat32(toDecimal128(number, 3)) FROM numbers(12, 1);
SELECT toFloat64(toDecimal32(number, 1)), toFloat64(toDecimal64(number, 2)), toFloat64(toDecimal128(number, 3)) FROM numbers(13, 1);
SELECT toInt256(toDecimal32(number, 1)), toInt256(toDecimal64(number, 2)), toInt256(toDecimal128(number, 3)) FROM numbers(14, 1);
