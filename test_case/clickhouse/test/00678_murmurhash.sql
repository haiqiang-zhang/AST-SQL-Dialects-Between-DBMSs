SELECT murmurHash2_32(123456);
SELECT murmurHash2_32(2) = bitXor(toUInt32(0x5bd1e995 * bitXor(toUInt32(3 * 0x5bd1e995) AS a, bitShiftRight(a, 13))) AS b, bitShiftRight(b, 15));
SELECT murmurHash2_32('\x02') = bitXor(toUInt32(0x5bd1e995 * bitXor(toUInt32(3 * 0x5bd1e995) AS a, bitShiftRight(a, 13))) AS b, bitShiftRight(b, 15));
SELECT murmurHash2_64('foo');
SELECT murmurHash3_32('foo');
SELECT murmurHash3_64('foo');
SELECT gccMurmurHash('foo');
SELECT hex(murmurHash3_128('foo'));
