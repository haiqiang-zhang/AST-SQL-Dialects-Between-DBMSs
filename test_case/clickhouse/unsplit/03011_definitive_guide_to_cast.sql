SET session_timezone = 'Europe/Amsterdam';
SELECT CAST(123 AS String);
SELECT CAST(1234567890 AS DateTime('Europe/Amsterdam'));
SELECT CAST('[1, 2, 3]' AS Array(UInt8));
SET cast_keep_nullable = 1;
SELECT CAST(x AS UInt8) AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('NULL'));
SET cast_keep_nullable = 0;


SELECT CAST(257 AS UInt8);
SELECT CAST(-1 AS UInt8);
SELECT arrayJoin(CAST($$['Hello', 'wo\'rld\\']$$ AS Array(String))) AS x, CAST($$wo\'rld\\$$ AS FixedString(9)) AS y;
SELECT CAST(-123 AS UInt8), CAST(1234 AS UInt8);
SELECT CAST('1234' AS UInt8);
SELECT CAST('[ 123 ,456, ]' AS Array(UInt16));
SELECT CAST(1.9, 'Int64'), CAST(-1.9, 'Int64');
SELECT [] AS x, CAST(x AS Array(Array(Array(Tuple(UInt64, String))))) AS y, toTypeName(x), toTypeName(y);


-- For example, it is 1 AM in Amsterdam:

SELECT CAST(0 AS DateTime('Europe/Amsterdam'));
SELECT CAST(1234567890.123456 AS DateTime64(6, 'Europe/Amsterdam'));
SELECT CAST(-0.111111 AS DateTime64(6, 'Europe/Amsterdam'));
SELECT CAST(1234567890.123456 AS DateTime('Europe/Amsterdam'));
SELECT CAST(-1 AS DateTime('Europe/Amsterdam'));
SELECT CAST(1e20 AS DateTime64(6, 'Europe/Amsterdam'));

-- (the number of seconds since the Unix epoch), similarly how it is done for the DateTime data type,
-- for convenience (while the internal representation of Date is the number of days,
-- often people want the unix timestamp to be also parsed into the Date data type):

SELECT CAST(14289 AS Date);
SELECT CAST(1234567890 AS Date);
SELECT CAST(123 AS String);
SELECT cast(123 AS String);
SELECT Cast(123 AS String);
SELECT CAST(123, 'String');
SELECT CAST(123, 'Str'||'ing');
SELECT CasT(123, 'String');
SELECT CAST(123 AS String);
SELECT CAST(123 AS `String`);
SELECT CAST(123 AS "String");
SELECT CAST(123, 'String');
SELECT 'String' AS String, CAST(123, String);


SELECT _CAST(x, 'UInt8') AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('456'));
SELECT CAST(123 AS UInt8);
SELECT 123::String;
SELECT 1.1::Decimal(30, 20);
SELECT CAST(1.1 AS Decimal(30, 20));
SELECT CAST(-1 AS UInt64);
SELECT [1.1, 2.3]::Array(Decimal(30, 20));
SELECT [1.1, 2.3 + 0]::Array(Decimal(30, 20));
SELECT -1::String;
SELECT accurateCastOrNull(1.123456789, 'Float32');
SELECT accurateCastOrDefault(-1, 'UInt64', 0::UInt64);
SELECT accurateCastOrDefault(-1, 'UInt64');
SELECT accurateCastOrDefault(-1, 'DateTime');

-- `toUInt8`, `toUInt16`, `toUInt32`, `toUInt64`, `toUInt128`, `toUInt256`,
-- `toInt8`, `toInt16`, `toInt32`, `toInt64`, `toInt128`, `toInt256`,
-- `toFloat32`, `toFloat64`,
-- `toDecimal32`, `toDecimal64`, `toDecimal128`, `toDecimal256`,
-- `toDate`, `toDate32`, `toDateTime`, `toDateTime64`,
-- `toUUID`, `toIPv4`, `toIPv6`,
-- `toIntervalNanosecond`, `toIntervalMicrosecond`, `toIntervalMillisecond`,
-- `toIntervalSecond`, `toIntervalMinute`, `toIntervalHour`,
-- `toIntervalDay`, `toIntervalWeek`, `toIntervalMonth`, `toIntervalQuarter`, `toIntervalYear`

-- These functions work under the same rules as the CAST operator and can be thought as elementary implementation parts of that operator. They allow implementation-defined overflow while converting between numeric types.

SELECT toUInt8(-1);
SELECT toFloat64(123);
SELECT toDecimal32('123.456', 2);
SELECT toDateTime('2024-04-25 01:02:03', 'Europe/Amsterdam');
SELECT toDateTime64('2024-04-25 01:02:03', 6, 'Europe/Amsterdam');


SELECT toDateTime('2024-04-25 01:02:03');
SELECT toDateTime64('2024-04-25 01:02:03.456789', 6);
SELECT toString(1710612085::DateTime, 'America/Los_Angeles');
SELECT toString(1710612085::DateTime);


SELECT toUInt8OrNull('123'), toUInt8OrNull('-123'), toUInt8OrNull('1234'), toUInt8OrNull(' 123');
SELECT toUInt8OrZero('123'), toUInt8OrZero('-123'), toUInt8OrZero('1234'), toUInt8OrZero(' 123');
SELECT toUInt8OrDefault('123', 10), toUInt8OrDefault('-123', 10), toUInt8OrDefault('1234', 10), toUInt8OrDefault(' 123', 10);
SELECT toUInt8OrDefault('123'), toUInt8OrDefault('-123'), toUInt8OrDefault('1234'), toUInt8OrDefault(' 123');
SELECT toTypeName(toUInt8OrNull('123')), toTypeName(toUInt8OrZero('123'));
SELECT toUInt8OrNull(123::FixedString(3));
SELECT toUInt8OrNull('123'::FixedString(4));
SELECT toUInt8OrNull('123\0'::FixedString(4));
SELECT toUInt8OrNull('123\0');
SELECT DATE '2024-04-25', TIMESTAMP '2024-01-01 02:03:04', INTERVAL 1 MINUTE, INTERVAL '12 hour';
SELECT DATE('2024-04-25'), TIMESTAMP('2024-01-01 02:03:04'), FROM_UNIXTIME(1234567890);
SELECT date '2024-04-25', timeSTAMP('2024-01-01 02:03:04'), From_Unixtime(1234567890);


SELECT parseDateTimeBestEffort('25 Apr 1986 1pm');
SELECT toDayOfMonth(toDateTime(1234567890));
