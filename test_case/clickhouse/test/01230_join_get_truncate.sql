SELECT joinGet('join_test', 'num', 500);
-- replace all the values

INSERT INTO join_test (id, num) SELECT number, number * 2 FROM system.numbers LIMIT 1000;
SELECT joinGet ('join_test', 'num', 500);
TRUNCATE TABLE join_test;
INSERT INTO join_test (id, num) SELECT number, number FROM system.numbers LIMIT 1000;
INSERT INTO join_test (id, num) SELECT number, number * 2 FROM system.numbers LIMIT 1000;
SELECT joinGet('join_test', 'num', 500);
DROP TABLE join_test;
