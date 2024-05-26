SELECT 'Into String';
SELECT reinterpret(49, 'String');
SELECT 'Into FixedString';
SELECT reinterpretAsFixedString(49);
SELECT 'Into Numeric Representable';
SELECT 'Integer and Integer types';
SELECT reinterpret(257, 'UInt8'), reinterpretAsUInt8(257);
SELECT reinterpret(257, 'Int8'), reinterpretAsInt8(257);
SELECT reinterpret(257, 'UInt16'), reinterpretAsUInt16(257);
SELECT reinterpret(257, 'Int16'), reinterpretAsInt16(257);
SELECT reinterpret(257, 'UInt32'), reinterpretAsUInt32(257);
SELECT reinterpret(257, 'Int32'), reinterpretAsInt32(257);
SELECT reinterpret(257, 'UInt64'), reinterpretAsUInt64(257);
SELECT reinterpret(257, 'Int64'), reinterpretAsInt64(257);
SELECT reinterpret(257, 'Int128'), reinterpretAsInt128(257);
SELECT reinterpret(257, 'UInt256'), reinterpretAsUInt256(257);
SELECT reinterpret(257, 'Int256'), reinterpretAsInt256(257);
SELECT 'Integer and Float types';
SELECT reinterpretAsFloat32(a), reinterpretAsUInt32(toFloat32(0.2)) as a;
SELECT reinterpretAsFloat64(a), reinterpretAsUInt64(toFloat64(0.2)) as a;
SELECT 'Integer and String types';
SELECT reinterpret(a, 'String'), reinterpretAsString(a), reinterpretAsUInt8('1') as a;
SELECT 'Dates';
SELECT 'Decimals';
SELECT 'ReinterpretErrors';
