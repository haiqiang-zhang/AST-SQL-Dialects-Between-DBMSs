SELECT leftPad(toFixedString('abc', 3), 0), leftPad('abc', CAST('0', 'Int32'));
SELECT leftPad(toFixedString('abc343243424324', 15), 1) as a, toTypeName(a);
SELECT rightPad(toFixedString('abc', 3), 0), rightPad('abc', CAST('0', 'Int32'));
SELECT
    hex(leftPad(toFixedString('abc34324' as s, 8), number)) as result,
    hex(leftPad(s, number)) = result,
    hex(leftPadUTF8(toFixedString(s, 8), number)) = result,
    hex(leftPadUTF8(s, number)) = result
FROM numbers(20);
