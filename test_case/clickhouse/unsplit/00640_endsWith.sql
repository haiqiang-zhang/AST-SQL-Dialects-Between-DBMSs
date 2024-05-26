SELECT endsWith(s, 'ow') FROM (SELECT arrayJoin(['', 'o', 'ow', 'Hellow', '3434', 'owfffffffdHe']) AS s);
DROP TABLE IF EXISTS endsWith_test;
CREATE TABLE endsWith_test(S1 String, S2 String, S3 FixedString(2)) ENGINE=Memory;
INSERT INTO endsWith_test values ('11', '22', '33'), ('a', 'a', 'bb'), ('abc', 'bc', '23');
SELECT COUNT() FROM endsWith_test WHERE endsWith(S1, S1);
DROP TABLE endsWith_test;
