SELECT left('Hello', 3);
SELECT left('Hello', -3);
SELECT left('Hello', 5);
SELECT left('Hello', -5);
SELECT left('Hello', 6);
SELECT left('Hello', -6);
SELECT left('Hello', 0);
SELECT left('Hello', NULL);
SELECT left(materialize('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ'), 4);
SELECT LEFT('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -4);
SELECT left(toNullable('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ'), 12);
SELECT lEFT('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -12);
SELECT left(materialize(toNullable('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ')), 13);
SELECT left('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -13);
SELECT Left('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 0);
SELECT left('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', NULL);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 4);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -4);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 12);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -12);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 13);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -13);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 0);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', NULL);
SELECT left('Hello', number) FROM numbers(10);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number) FROM numbers(10);
SELECT left('Hello', -number) FROM numbers(10);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -number) FROM numbers(10);
SELECT leftUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number % 3 = 0 ? NULL : (number % 2 ? toInt64(number) : -number)) FROM numbers(10);
SELECT leftUTF8(number < 5 ? 'Hello' : 'ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number % 3 = 0 ? NULL : (number % 2 ? toInt64(number) : -number)) FROM numbers(10);
SELECT right('Hello', 3);
SELECT right('Hello', -3);
SELECT right('Hello', 5);
SELECT right('Hello', -5);
SELECT right('Hello', 6);
SELECT right('Hello', -6);
SELECT right('Hello', 0);
SELECT right('Hello', NULL);
SELECT RIGHT(materialize('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ'), 4);
SELECT right('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -4);
SELECT Right(toNullable('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ'), 12);
SELECT right('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -12);
SELECT rIGHT(materialize(toNullable('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ')), 13);
SELECT right('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -13);
SELECT rIgHt('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 0);
SELECT RiGhT('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', NULL);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 4);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -4);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 12);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -12);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 13);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -13);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', 0);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', NULL);
SELECT right('Hello', number) FROM numbers(10);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number) FROM numbers(10);
SELECT right('Hello', -number) FROM numbers(10);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', -number) FROM numbers(10);
SELECT rightUTF8('ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number % 3 = 0 ? NULL : (number % 2 ? toInt64(number) : -number)) FROM numbers(10);
SELECT rightUTF8(number < 5 ? 'Hello' : 'ÃÂÃÂÃÂ¸ÃÂ²ÃÂµÃÂ', number % 3 = 0 ? NULL : (number % 2 ? toInt64(number) : -number)) FROM numbers(10);
