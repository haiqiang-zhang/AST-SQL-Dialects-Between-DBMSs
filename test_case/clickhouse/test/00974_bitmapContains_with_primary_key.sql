SELECT count(*) FROM test WHERE bitmapContains(bitmapBuild([1, 5, 7, 9]), toUInt8(num));
SELECT count(*) FROM test WHERE bitmapContains(bitmapBuild([1, 5, 7, 9]), toUInt16(num));
SELECT count(*) FROM test WHERE bitmapContains(bitmapBuild([1, 5, 7, 9]), toUInt32(num));
SELECT count(*) FROM test WHERE bitmapContains(bitmapBuild([1, 5, 7, 9]), toUInt64(num));
DROP TABLE test;
