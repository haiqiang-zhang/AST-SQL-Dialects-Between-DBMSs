SELECT startsWith(s, 'He') FROM (SELECT arrayJoin(['', 'H', 'He', 'Hellow', '3434', 'fffffffffdHe']) AS s);
DROP TABLE IF EXISTS startsWith_test;
CREATE TABLE startsWith_test(S1 String, S2 String, S3 FixedString(2)) ENGINE=Memory;
INSERT INTO startsWith_test values ('11', '22', '33'), ('a', 'a', 'bb'), ('abc', 'ab', '23');
SELECT COUNT() FROM startsWith_test WHERE startsWith(S1, S1);
DROP TABLE startsWith_test;
