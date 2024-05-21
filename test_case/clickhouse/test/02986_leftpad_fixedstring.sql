SELECT leftPad(toFixedString('abc', 3), 0), leftPad('abc', CAST('0', 'Int32'));
SELECT leftPad(toFixedString('abc343243424324', 15), 1) as a, toTypeName(a);
SELECT rightPad(toFixedString('abc', 3), 0), rightPad('abc', CAST('0', 'Int32'));
SELECT rightPad(toFixedString('abc343243424324', 15), 1) as a, toTypeName(a);
SELECT
    hex(leftPad(toFixedString('abc34324' as s, 8), number)) as result,
    hex(leftPad(s, number)) = result,
    hex(leftPadUTF8(toFixedString(s, 8), number)) = result,
    hex(leftPadUTF8(s, number)) = result
FROM numbers(20);
SELECT
    hex(rightPad(toFixedString('abc34324' as s, 8), number)) as result,
    hex(rightPad(s, number)) = result,
    hex(rightPadUTF8(toFixedString(s, 8), number)) = result,
    hex(rightPadUTF8(s, number)) = result
FROM numbers(20);
SELECT
    hex(leftPadUTF8(toFixedString('abc34324' as s, 8), number, 'ðªð¸')) as result,
    hex(leftPadUTF8(s, number, 'ðªð¸')) = result
FROM numbers(20);
SELECT
    hex(rightPadUTF8(toFixedString('abc34324' as s, 8), number, 'ðªð¸')) as result,
    hex(rightPadUTF8(s, number, 'ðªð¸')) = result
FROM numbers(20);
SELECT
    hex(leftPadUTF8(toFixedString('ðªð¸' as s, 8), number, 'Ã')) as result,
    hex(leftPadUTF8(s, number, 'Ã')) = result
FROM numbers(20);
SELECT
    hex(rightPadUTF8(toFixedString('ðªð¸' as s, 8), number, 'Ã')) as result,
    hex(rightPadUTF8(s, number, 'Ã')) = result
FROM numbers(20);