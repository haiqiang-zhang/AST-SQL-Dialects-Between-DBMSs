WITH substring('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 1, number) AS prefix, prefix || 'x' AS a, prefix || 'y' AS b SELECT a = b, a < b, a > b, a <= b, a >= b FROM numbers(40);
WITH arrayJoin(['aaa', 'bbb']) AS a, 'aaa\0bbb' AS b SELECT a = b, a < b, a > b, a <= b, a >= b;
WITH arrayJoin(['aaa', 'zzz']) AS a, 'aaa\0bbb' AS b SELECT a = b, a < b, a > b, a <= b, a >= b;
WITH arrayJoin(['aaa', 'bbb']) AS a, materialize('aaa\0bbb') AS b SELECT a = b, a < b, a > b, a <= b, a >= b;
WITH arrayJoin(['aaa', 'zzz']) AS a, materialize('aaa\0bbb') AS b SELECT a = b, a < b, a > b, a <= b, a >= b;
SELECT empty(toFixedString('', 1 + randConstant() % 100));
