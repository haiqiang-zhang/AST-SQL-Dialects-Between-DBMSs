SELECT divideDecimal(toDecimal32(0, 2), toDecimal128(11.123456, 6));
SELECT multiplyDecimal(toDecimal32(0, 2), toDecimal128(11.123456, 6));
SELECT sum(multiplyDecimal(toDecimal64(number, 1), toDecimal64(number, 5))) FROM numbers(1000);
SELECT sum(divideDecimal(toDecimal64(number, 1), toDecimal64(number, 5))) FROM (select * from numbers(1000) OFFSET 1);
