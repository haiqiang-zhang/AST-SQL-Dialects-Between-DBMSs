SET session_timezone = 'Europe/Amsterdam';
-- 1. SQL standard CAST operator: `CAST(value AS Type)`.

SELECT CAST(123 AS String);
SELECT CAST(1234567890 AS DateTime('Europe/Amsterdam'));
SELECT CAST('[1, 2, 3]' AS Array(UInt8));
SET cast_keep_nullable = 1;
SELECT CAST(x AS UInt8) AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('NULL'));
SET cast_keep_nullable = 0;
SELECT CAST(x AS UInt8) AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('NULL'));
-- There are various type conversion rules, some worth noting.

-- Conversion between numeric types can involve implementation-defined overflow:

SELECT CAST(257 AS UInt8);
SELECT CAST(-1 AS UInt8);
-- While for simple data types, it does not interpret escape sequences:

SELECT arrayJoin(CAST($$['Hello', 'wo\'rld\\']$$ AS Array(String))) AS x, CAST($$wo\'rld\\$$ AS FixedString(9)) AS y;
-- it can be stricter for numbers by not tolerating overflows in some cases:

SELECT CAST(-123 AS UInt8), CAST(1234 AS UInt8);
SELECT CAST('-123' AS UInt8);
-- In some cases it still allows overflows, but it is implementation defined:

SELECT CAST('1234' AS UInt8);
SELECT CAST(' 123' AS UInt8);
SELECT CAST('123 ' AS UInt8);
-- But for composite data types, it involves a more featured parser, that takes care of whitespace inside the data structures:

SELECT CAST('[ 123 ,456, ]' AS Array(UInt16));
SELECT CAST(1.9, 'Int64'), CAST(-1.9, 'Int64');
-- However, you might find it amusing that an empty array of Nothing data type can be converted to arrays of any dimensions:

SELECT [] AS x, CAST(x AS Array(Array(Array(Tuple(UInt64, String))))) AS y, toTypeName(x), toTypeName(y);
-- where Unix epoch starts from 1970-01-01T00:00:00Z (the midnight of Gregorian year 1970 in UTC),
-- and the number of seconds don't count the coordination seconds, as in Unix.

-- For example, it is 1 AM in Amsterdam:

SELECT CAST(0 AS DateTime('Europe/Amsterdam'));
SELECT CAST(1234567890.123456 AS DateTime64(6, 'Europe/Amsterdam'));
SELECT CAST(-0.111111 AS DateTime64(6, 'Europe/Amsterdam'));
SELECT CAST(1234567890.123456 AS DateTime('Europe/Amsterdam'));
SELECT CAST(-1 AS DateTime('Europe/Amsterdam'));
SELECT CAST(1e20 AS DateTime64(6, 'Europe/Amsterdam'));
-- and in this case, it throws an exception on overflow (I don't mind if we change this behavior in the future):

 SELECT CAST(1e20 AS DateTime64(9, 'Europe/Amsterdam'));
-- If a number is converted to a Date data type, the value is interpreted as the number of days since the Unix epoch,
-- but if the number is larger than the range of the data type, it is interpreted as a unix timestamp
-- (the number of seconds since the Unix epoch), similarly how it is done for the DateTime data type,
-- for convenience (while the internal representation of Date is the number of days,
-- often people want the unix timestamp to be also parsed into the Date data type):

SELECT CAST(14289 AS Date);
SELECT CAST(1234567890 AS Date);
-- The operator is case-insensitive:

SELECT CAST(123 AS String);
SELECT cast(123 AS String);
SELECT Cast(123 AS String);
SELECT CAST(123, 'String');
SELECT CAST(123, 'Str'||'ing');
-- This does not work: SELECT materialize('String') AS type, CAST(123, type);
SELECT CasT(123, 'String');
-- It's worth noting that the operator form does not allow to specify the type name as a string literal:

-- This does not work: SELECT CAST(123 AS 'String');
SELECT CAST(123 AS String);
SELECT CAST(123 AS `String`);
SELECT CAST(123 AS "String");
SELECT CAST(123, 'String');
SELECT CAST(123, String);
-- However, you can cheat:

SELECT 'String' AS String, CAST(123, String);
-- This is needed when ClickHouse has to persist an expression for future use, like in table definitions, including primary and partition keys and other indices.

-- The function is not intended to be used directly. When a user uses a regular `CAST` operator or function in a table definition, it is transparently converted to `_CAST` to persist its behavior. However, the user can still use the internal version directly:

SELECT _CAST(x, 'UInt8') AS y, toTypeName(y) FROM VALUES('x Nullable(String)', ('123'), ('456'));
--  does not work, here UInt8 is interpreted as an alias for the value:
SELECT _CAST(123 AS UInt8);
SELECT CAST(123 AS UInt8);
-- 4. PostgreSQL-style cast syntax `::`

SELECT 123::String;
-- In this example, we parse `1.1` as Decimal and do not involve any type conversion:

SELECT 1.1::Decimal(30, 20);
SELECT CAST(1.1 AS Decimal(30, 20));
-- Another example:

SELECT -1::UInt64;
SELECT CAST(-1 AS UInt64);
-- For composite data types, if a value is a literal, it is parsed directly:

SELECT [1.1, 2.3]::Array(Decimal(30, 20));
SELECT [1.1, 2.3 + 0]::Array(Decimal(30, 20));
SELECT 1-1::String;
-- But one interesting example is the unary minus. Here the minus is not an operator but part of the numeric literal:

SELECT -1::String;
SELECT 1 AS x, -x::String;
-- 5. Accurate casting functions: `accurateCast`, `accurateCastOrNull`, `accurateCastOrDefault`.

-- These functions check if the value is exactly representable in the target data type.

-- The function `accurateCast` performs the conversion or throws an exception if the value is not exactly representable:

SELECT accurateCast(1.123456789, 'Float32');
-- The function `accurateCastOrNull` always wraps the target type into Nullable, and returns NULL if the value is not exactly representable:

SELECT accurateCastOrNull(1.123456789, 'Float32');
SELECT accurateCastOrDefault(-1, 'UInt64', 0::UInt64);
SELECT accurateCastOrDefault(-1, 'UInt64');
SELECT accurateCastOrDefault(-1, 'DateTime');
-- These functions are case-sensitive, and there are no corresponding operators:

SELECT ACCURATECAST(1, 'String');
-- 6. Explicit conversion functions:

-- `toString`, `toFixedString`,
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
-- The length of FixedString and the scale of Decimal and DateTime64 types are mandatory arguments, while the time zone of the DateTime data type is optional.

-- If the time zone is not specified, the time zone of the argument's data type is used, and if the argument is not a date time, the session time zone is used.

SELECT toDateTime('2024-04-25 01:02:03');
SELECT toDateTime64('2024-04-25 01:02:03.456789', 6);
SELECT toString(1710612085::DateTime, 'America/Los_Angeles');
SELECT toString(1710612085::DateTime);
-- it can be non-constant. Let's clarify: in this example, the resulting data type is a String;
it does not have a time zone parameter:

SELECT toString(1710612085::DateTime, tz) FROM Values('tz String', 'Europe/Amsterdam', 'America/Los_Angeles');
-- that don't throw exceptions on parsing errors.
-- They use the same rules to the accurateCast operator:

SELECT toUInt8OrNull('123'), toUInt8OrNull('-123'), toUInt8OrNull('1234'), toUInt8OrNull(' 123');
SELECT toUInt8OrZero('123'), toUInt8OrZero('-123'), toUInt8OrZero('1234'), toUInt8OrZero(' 123');
SELECT toUInt8OrDefault('123', 10), toUInt8OrDefault('-123', 10), toUInt8OrDefault('1234', 10), toUInt8OrDefault(' 123', 10);
SELECT toUInt8OrDefault('123'), toUInt8OrDefault('-123'), toUInt8OrDefault('1234'), toUInt8OrDefault(' 123');
SELECT toTypeName(toUInt8OrNull('123')), toTypeName(toUInt8OrZero('123'));
-- Although it is a room for extension:

SELECT toUInt8OrNull(123);
-- String and FixedString work:

SELECT toUInt8OrNull(123::FixedString(3));
SELECT toUInt8OrNull('123'::FixedString(4));
SELECT toUInt8OrNull('123\0'::FixedString(4));
SELECT toUInt8OrNull('123\0');
SELECT DATE '2024-04-25', TIMESTAMP '2024-01-01 02:03:04', INTERVAL 1 MINUTE, INTERVAL '12 hour';
-- 8. SQL-compatibility aliases for explicit conversion functions:

SELECT DATE('2024-04-25'), TIMESTAMP('2024-01-01 02:03:04'), FROM_UNIXTIME(1234567890);
SELECT date '2024-04-25', timeSTAMP('2024-01-01 02:03:04'), From_Unixtime(1234567890);
-- `parseDateTimeBestEffort`, `parseDateTimeBestEffortUS`, `parseDateTime64BestEffort`, `parseDateTime64BestEffortUS`, `toUnixTimestamp`

-- These functions are similar to explicit conversion functions but provide special rules on how the conversion is performed.

SELECT parseDateTimeBestEffort('25 Apr 1986 1pm');
SELECT toDayOfMonth(toDateTime(1234567890));