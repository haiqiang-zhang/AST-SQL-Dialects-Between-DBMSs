PRAGMA enable_verification;
pragma verify_external;
CREATE TABLE test1 (i INT, s1 VARCHAR, s2 VARCHAR);
INSERT INTO test1 VALUES (1, 'thisisareallylongstring', 'thisisareallylongstringtoo');
CREATE TABLE test2 (i INT, s1 VARCHAR, s2 VARCHAR);
INSERT INTO test2 VALUES (1, 'longstringsarecool', 'coolerthanshortstrings');
SELECT t1.i, t1.s1, t1.s2, t2.s1, t2.s2 FROM test1 t1, test2 t2 WHERE t1.i = t2.i;