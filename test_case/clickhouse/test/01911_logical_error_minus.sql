-- It appeared to trigger assertion.

SET cross_to_inner_join_rewrite = 1;
DROP TABLE IF EXISTS codecTest;
CREATE TABLE codecTest (
    key      UInt64,
    name     String,
    ref_valueF64 Float64,
    ref_valueF32 Float32,
    valueF64 Float64  CODEC(Gorilla),
    valueF32 Float32  CODEC(Gorilla)
) Engine = MergeTree ORDER BY key;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
    SELECT number AS n, 'e()', e() AS v, v, v, v FROM system.numbers LIMIT 1, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
    SELECT number AS n, 'log2(n)', log2(n) AS v, v, v, v FROM system.numbers LIMIT 101, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
    SELECT number AS n, 'n*sqrt(n)', n*sqrt(n) AS v, v, v, v FROM system.numbers LIMIT 201, 100;
INSERT INTO codecTest (key, name, ref_valueF64, valueF64, ref_valueF32, valueF32)
    SELECT number AS n, 'sin(n*n*n)*n', sin(n * n * n * n* n) AS v, v, v, v FROM system.numbers LIMIT 301, 100;
SELECT IF(2, NULL, 0.00009999999747378752), IF(104, 1048576, NULL), c1.key, IF(1, NULL, NULL), c2.key FROM codecTest AS c1 , codecTest AS c2 WHERE ignore(IF(255, -2, NULL), arrayJoin([65537]), IF(3, 1024, 9223372036854775807)) AND IF(NULL, 256, NULL) AND (IF(NULL, '1048576', NULL) = (c1.key - NULL)) LIMIT 65535;
SELECT c1.key, c1.name, c1.ref_valueF64, c1.valueF64, c1.ref_valueF64 - c1.valueF64 AS dF64, '', c2.key, c2.ref_valueF64 FROM codecTest AS c1 , codecTest AS c2 WHERE (dF64 != 3) AND c1.valueF64 != 0 AND (c2.key = (c1.key - 1048576)) LIMIT 0;
DROP TABLE codecTest;
CREATE TABLE codecTest (
    key      UInt64,
    ref_valueU64 UInt64,
    ref_valueU32 UInt32,
    ref_valueU16 UInt16,
    ref_valueU8  UInt8,
    ref_valueI64 Int64,
    ref_valueI32 Int32,
    ref_valueI16 Int16,
    ref_valueI8  Int8,
    ref_valueDT  DateTime,
    ref_valueD   Date,
    valueU64 UInt64   CODEC(DoubleDelta),
    valueU32 UInt32   CODEC(DoubleDelta),
    valueU16 UInt16   CODEC(DoubleDelta),
    valueU8  UInt8    CODEC(DoubleDelta),
    valueI64 Int64    CODEC(DoubleDelta),
    valueI32 Int32    CODEC(DoubleDelta),
    valueI16 Int16    CODEC(DoubleDelta),
    valueI8  Int8     CODEC(DoubleDelta),
    valueDT  DateTime CODEC(DoubleDelta),
    valueD   Date     CODEC(DoubleDelta)
) Engine = MergeTree ORDER BY key SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO codecTest (key, ref_valueU64, valueU64, ref_valueI64, valueI64)
    VALUES (1, 18446744073709551615, 18446744073709551615, 9223372036854775807, 9223372036854775807), (2, 0, 0, -9223372036854775808, -9223372036854775808), (3, 18446744073709551615, 18446744073709551615, 9223372036854775807, 9223372036854775807);
INSERT INTO codecTest (key, ref_valueU64, valueU64, ref_valueU32, valueU32, ref_valueU16, valueU16, ref_valueU8, valueU8, ref_valueI64, valueI64, ref_valueI32, valueI32, ref_valueI16, valueI16, ref_valueI8, valueI8, ref_valueDT, valueDT, ref_valueD, valueD)
    SELECT number as n, n * n * n as v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, toDateTime(v), toDateTime(v), toDate(v), toDate(v)
    FROM system.numbers LIMIT 101, 1000;
INSERT INTO codecTest (key, ref_valueU64, valueU64, ref_valueU32, valueU32, ref_valueU16, valueU16, ref_valueU8, valueU8, ref_valueI64, valueI64, ref_valueI32, valueI32, ref_valueI16, valueI16, ref_valueI8, valueI8, ref_valueDT, valueDT, ref_valueD, valueD)
    SELECT number as n, n as v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, toDateTime(v), toDateTime(v), toDate(v), toDate(v)
    FROM system.numbers LIMIT 2001, 1000;
INSERT INTO codecTest (key, ref_valueU64, valueU64, ref_valueU32, valueU32, ref_valueU16, valueU16, ref_valueU8, valueU8, ref_valueI64, valueI64, ref_valueI32, valueI32, ref_valueI16, valueI16, ref_valueI8, valueI8, ref_valueDT, valueDT, ref_valueD, valueD)
    SELECT number as n, n + (rand64() - 9223372036854775807)/1000 as v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, v, toDateTime(v), toDateTime(v), toDate(v), toDate(v)
    FROM system.numbers LIMIT 3001, 1000;
SELECT IF(2, NULL, 0.00009999999747378752), IF(104, 1048576, NULL), c1.key, IF(1, NULL, NULL), c2.key FROM codecTest AS c1 , codecTest AS c2 WHERE ignore(IF(255, -2, NULL), arrayJoin([65537]), IF(3, 1024, 9223372036854775807)) AND IF(NULL, 256, NULL) AND (IF(NULL, '1048576', NULL) = (c1.key - NULL)) LIMIT 65535;
DROP TABLE codecTest;
