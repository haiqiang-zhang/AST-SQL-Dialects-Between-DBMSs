DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS b;
DROP TABLE IF EXISTS c;
DROP TABLE IF EXISTS d;
CREATE TABLE a (k UInt64, a1 UInt64, a2 String) ENGINE = Memory;
INSERT INTO a VALUES (1, 1, 'a'), (2, 2, 'b'), (3, 3, 'c');
CREATE TABLE b (k UInt64, b1 UInt64, b2 String) ENGINE = Memory;
INSERT INTO b VALUES (1, 1, 'a'), (2, 2, 'b'), (3, 3, 'c');
CREATE TABLE c (k UInt64, c1 UInt64, c2 String) ENGINE = Memory;
INSERT INTO c VALUES (1, 1, 'a'), (2, 2, 'b'), (3, 3, 'c');
CREATE TABLE d (k UInt64, d1 UInt64, d2 String) ENGINE = Memory;
INSERT INTO d VALUES (1, 1, 'a'), (2, 2, 'b'), (3, 3, 'c');
SET allow_experimental_analyzer = 1;