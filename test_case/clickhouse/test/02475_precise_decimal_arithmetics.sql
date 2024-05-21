-- check cases when one of operands is zero
SELECT divideDecimal(toDecimal32(0, 2), toDecimal128(11.123456, 6));
SELECT multiplyDecimal(toDecimal32(0, 2), toDecimal128(11.123456, 6));
SELECT multiplyDecimal(toDecimal32(123.123, 3), toDecimal128(0, 1));
SELECT multiplyDecimal(toDecimal256(1e38, 0), toDecimal256(1e38, 0));
SELECT divideDecimal(toDecimal256(1e66, 0), toDecimal256(1e-10, 10), 0);
-- test different signs
SELECT divideDecimal(toDecimal128(123.76, 2), toDecimal128(11.123456, 6));
SELECT divideDecimal(toDecimal32(123.123, 3), toDecimal128(11.4, 1), 2);
SELECT divideDecimal(toDecimal128(-123.76, 2), toDecimal128(11.123456, 6));
SELECT divideDecimal(toDecimal32(123.123, 3), toDecimal128(-11.4, 1), 2);
SELECT divideDecimal(toDecimal32(-123.123, 3), toDecimal128(-11.4, 1), 2);
SELECT multiplyDecimal(toDecimal64(123.76, 2), toDecimal128(11.123456, 6));
SELECT multiplyDecimal(toDecimal32(123.123, 3), toDecimal128(11.4, 1), 2);
SELECT multiplyDecimal(toDecimal64(-123.76, 2), toDecimal128(11.123456, 6));
SELECT multiplyDecimal(toDecimal32(123.123, 3), toDecimal128(-11.4, 1), 2);
SELECT multiplyDecimal(toDecimal32(-123.123, 3), toDecimal128(-11.4, 1), 2);
SELECT sum(multiplyDecimal(toDecimal64(number, 1), toDecimal64(number, 5))) FROM numbers(1000);
SELECT sum(divideDecimal(toDecimal64(number, 1), toDecimal64(number, 5))) FROM (select * from numbers(1000) OFFSET 1);
SELECT multiplyDecimal(toNullable(toDecimal64(10, 1)), toDecimal64(100, 5));
SELECT multiplyDecimal(toDecimal64(10, 1), toNullable(toDecimal64(100, 5)));
SELECT multiplyDecimal(toNullable(toDecimal64(10, 1)), toNullable(toDecimal64(100, 5)));
SELECT divideDecimal(toNullable(toDecimal64(10, 1)), toDecimal64(100, 5));
SELECT divideDecimal(toDecimal64(10, 1), toNullable(toDecimal64(100, 5)));
SELECT divideDecimal(toNullable(toDecimal64(10, 1)), toNullable(toDecimal64(100, 5)));
