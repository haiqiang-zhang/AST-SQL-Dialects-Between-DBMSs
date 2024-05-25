SELECT reinterpretAsUUID(x) FROM t_uuid;
SELECT reinterpretAsFloat32(x), reinterpretAsFloat64(x) FROM t_uuid;
SELECT reinterpretAsInt8(x), reinterpretAsInt16(x), reinterpretAsInt32(x), reinterpretAsInt64(x), reinterpretAsInt128(x), reinterpretAsInt256(x) FROM t_uuid;
SELECT reinterpretAsUInt8(x), reinterpretAsUInt16(x), reinterpretAsUInt32(x), reinterpretAsUInt64(x), reinterpretAsUInt128(x), reinterpretAsUInt256(x) FROM t_uuid;
SELECT reinterpretAsUUID(reinterpretAsUInt128(reinterpretAsUInt32(reinterpretAsUInt256(x)))) FROM t_uuid;
DROP TABLE IF EXISTS t_uuid;
