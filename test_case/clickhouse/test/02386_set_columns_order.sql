SELECT * FROM userid_test WHERE (userid, name) IN (userid_set);
CREATE TABLE userid_set2(userid UInt64, name String, birthdate Date) ENGINE = Set;
INSERT INTO userid_set2 values (1,'John', '1990-01-01');
WITH  'John' AS name,  toDate('1990-01-01') AS birthdate
SELECT * FROM numbers(10)
WHERE (number, name, birthdate) IN (userid_set2);
DROP TABLE userid_set;
DROP TABLE userid_test;
DROP TABLE userid_set2;
