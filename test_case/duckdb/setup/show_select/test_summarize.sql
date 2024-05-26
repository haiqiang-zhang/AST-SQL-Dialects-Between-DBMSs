PRAGMA enable_verification;
CREATE TABLE types(i INTEGER, j VARCHAR, k HUGEINT, d DOUBLE, e BLOB);
INSERT INTO types VALUES 
	(1, 'hello', 12, 0.5, BLOB 'a\x00b\x00c'), 
	(2, 'world', -12, -0.5, BLOB ''), 
	(3, NULL, NULL, NULL, NULL);
