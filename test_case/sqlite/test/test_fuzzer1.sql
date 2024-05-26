SELECT count(*) FROM streetname;
ATTACH 'test.db2' AS aux;
CREATE TABLE aux.f3_rules(ruleset, cfrom, cto, cost);
INSERT INTO f3_rules(ruleset, cfrom, cto, cost) VALUES(0, 'x','y', 10);
INSERT INTO f3_rules(ruleset, cfrom, cto, cost) VALUES(1, 'a','b', 10);
CREATE TABLE "fuzzer [x] rules table"(a, b, c, d);
INSERT INTO "fuzzer [x] rules table" VALUES(0, NULL, 'abc', 10);
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(0, 'x', NULL, 20);
INSERT INTO "fuzzer [x] rules table" VALUES(0, NULL, NULL, 10);
INSERT INTO "fuzzer [x] rules table" VALUES(0, 'x', 'x', 10);
DROP TABLE IF EXISTS x;
INSERT INTO "fuzzer [x] rules table" VALUES(0, 'c', 'd', 1001);
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(0, 'd', 'c', 0);
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(0, 'd', 'c', -20);
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(
    0, 'x', '12345678901234567890123456789012345678901234567890', 2
  );
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(
    0, 'x', '123456789012345678901234567890123456789012345678901', 2
  );
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(
    0, '123456789012345678901234567890123456789012345678901', 'x', 2
  );
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES(-1, 'x', 'y', 2);
DROP TABLE IF EXISTS x;
DELETE FROM "fuzzer [x] rules table";
INSERT INTO "fuzzer [x] rules table" VALUES((1<<32)+100, 'x', 'y', 2);
CREATE TABLE [x2 "rules] (a, b, c, d);
INSERT INTO [x2 "rules] VALUES(0, 'a', 'b', 5);
DROP TABLE IF EXISTS x2;
DROP TABLE IF EXISTS x2;
DROP TABLE IF EXISTS x2;
DROP TABLE IF EXISTS x2;
CREATE TABLE x3_rules(rule_set, cFrom, cTo, cost);
INSERT INTO x3_rules VALUES(2, 'a', 'x', 10);
INSERT INTO x3_rules VALUES(2, 'a', 'y',  9);
INSERT INTO x3_rules VALUES(2, 'a', 'z',  8);
CREATE INDEX i1 ON x3_rules(cost);
CREATE TABLE t1(a, b);
CREATE INDEX i2 ON t1(b);
INSERT INTO x3_rules VALUES(1, 'a', 't',  5);
INSERT INTO x3_rules VALUES(1, 'a', 'u',  4);
INSERT INTO x3_rules VALUES(1, 'a', 'v',  3);
DROP TABLE x3;
SELECT * FROM x3_rules;
CREATE TABLE x4_rules(a, b, c, d);
INSERT INTO x4_rules VALUES(0, 'a', 'b', 10);
INSERT INTO x4_rules VALUES(0, 'a', 'c', 11);
INSERT INTO x4_rules VALUES(0, 'bx', 'zz', 20);
INSERT INTO x4_rules VALUES(0, 'cx', 'yy', 15);
INSERT INTO x4_rules VALUES(0, 'zz', '!!', 50);
CREATE TABLE x5_rules(a, b, c, d);
INSERT INTO x5_rules VALUES(0, 'a', '0.1.2.3.4.5.6.7.8.9.a', 1);
