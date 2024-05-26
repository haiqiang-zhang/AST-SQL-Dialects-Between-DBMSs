SELECT operand, low, high, count, WIDTH_BUCKET(operand, low, high, count) FROM mytable WHERE count != 0;
SELECT '----------';
SELECT '----------';
SELECT '----------';
SELECT '----------';
SELECT '----------';
SELECT toTypeName(WIDTH_BUCKET(1, 2, 3, toUInt8(1)));
SELECT '----------';
