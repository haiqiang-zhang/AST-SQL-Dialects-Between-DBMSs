SET session_timezone = 'Europe/Amsterdam';
SELECT CAST(123 AS String);
SET cast_keep_nullable = 1;
SELECT CAST(x AS UInt8) AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('NULL'));
SET cast_keep_nullable = 0;
SELECT arrayJoin(CAST($$['Hello', 'wo\'rld\\']$$ AS Array(String))) AS x, CAST($$wo\'rld\\$$ AS FixedString(9)) AS y;
SELECT cast(123 AS String);
SELECT Cast(123 AS String);
SELECT CasT(123, 'String');
SELECT 123::String;
SELECT 1.1::Decimal(30, 20);
SELECT [1.1, 2.3]::Array(Decimal(30, 20));
SELECT [1.1, 2.3 + 0]::Array(Decimal(30, 20));
SELECT -1::String;
SELECT accurateCastOrNull(1.123456789, 'Float32');
SELECT accurateCastOrDefault(-1, 'UInt64', 0::UInt64);

-- `toIntervalNanosecond`, `toIntervalMicrosecond`, `toIntervalMillisecond`,
-- `toIntervalSecond`, `toIntervalMinute`, `toIntervalHour`,
-- `toIntervalDay`, `toIntervalWeek`, `toIntervalMonth`, `toIntervalQuarter`, `toIntervalYear`

-- These functions work under the same rules as the CAST operator and can be thought as elementary implementation parts of that operator. They allow implementation-defined overflow while converting between numeric types.

SELECT toUInt8(-1);
SELECT toFloat64(123);
SELECT toDecimal32('123.456', 2);
SELECT toDateTime('2024-04-25 01:02:03', 'Europe/Amsterdam');
SELECT toDateTime64('2024-04-25 01:02:03', 6, 'Europe/Amsterdam');
SELECT toString(1710612085::DateTime, 'America/Los_Angeles');
SELECT toUInt8OrNull('123'), toUInt8OrNull('-123'), toUInt8OrNull('1234'), toUInt8OrNull(' 123');
SELECT toUInt8OrZero('123'), toUInt8OrZero('-123'), toUInt8OrZero('1234'), toUInt8OrZero(' 123');
SELECT toUInt8OrDefault('123', 10), toUInt8OrDefault('-123', 10), toUInt8OrDefault('1234', 10), toUInt8OrDefault(' 123', 10);
SELECT DATE '2024-04-25', TIMESTAMP '2024-01-01 02:03:04', INTERVAL 1 MINUTE, INTERVAL '12 hour';
SELECT DATE('2024-04-25'), TIMESTAMP('2024-01-01 02:03:04'), FROM_UNIXTIME(1234567890);
SELECT date '2024-04-25', timeSTAMP('2024-01-01 02:03:04'), From_Unixtime(1234567890);
SELECT parseDateTimeBestEffort('25 Apr 1986 1pm');
SELECT toDayOfMonth(toDateTime(1234567890));
