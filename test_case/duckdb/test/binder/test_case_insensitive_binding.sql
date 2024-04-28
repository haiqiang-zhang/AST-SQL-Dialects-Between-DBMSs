PRAGMA enable_verification;
CREATE TABLE test ("HeLlO" INTEGER);
INSERT INTO test VALUES (1);
SELECT HeLlO FROM test;
SELECT hello FROM test;
SELECT "HeLlO" FROM test;
SELECT "HELLO" FROM test;
SELECT "HELLo" FROM test;
SELECT test.HeLlO FROM test;
SELECT test.hello FROM test;
SELECT test."HeLlO" FROM test;
SELECT test."HELLO" FROM test;
SELECT test."HELLo" FROM test;
UPDATE test SET hello=3;
UPDATE test SET HeLlO=3;
DROP TABLE test;
CREATE TABLE test("HeLlO" INTEGER, "HELLO" INTEGER);
CREATE TABLE test1("HeLlO" INTEGER);
CREATE TABLE test2("HELLO" INTEGER);
SELECT HeLlO FROM test1, test2;
SELECT hello FROM test1, test2;
SELECT "HeLlO" FROM test1, test2;
SELECT "HELLO" FROM test1, test2;
SELECT "HELLo" FROM test1, test2;
SELECT test1.HeLlO FROM test1, test2;
SELECT test1.hello FROM test1, test2;
SELECT test1."HeLlO" FROM test1, test2;
SELECT test1."HELLO" FROM test1, test2;
SELECT test1."HELLo" FROM test1, test2;
SELECT test2.HeLlO FROM test1, test2;
SELECT test2.hello FROM test1, test2;
SELECT test2."HeLlO" FROM test1, test2;
SELECT test2."HELLO" FROM test1, test2;
SELECT test2."HELLo" FROM test1, test2;
SELECT * FROM test1 JOIN test2 USING (hello);
SELECT alias(HeLlO) FROM test;
SELECT alias(hello) FROM test;
SELECT alias(x) FROM (SELECT HeLlO as x FROM test) tbl;;
SELECT hello FROM (SELECT 42) tbl("HeLlO");
