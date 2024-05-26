SELECT number FROM numbers(10) LIMIT 0 + 1;
SELECT number FROM numbers(10) LIMIT toUInt8('1');
SELECT number FROM numbers(10) LIMIT toFloat32('1');
SELECT count() <= 1 FROM (SELECT number FROM numbers(10) LIMIT randConstant() % 2);
