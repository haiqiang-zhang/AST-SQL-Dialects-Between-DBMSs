DROP TABLE IF EXISTS a;
DROP TABLE iF EXISTS b;
CREATE TABLE a ( a UInt64, b UInt64) ENGINE = Memory;
CREATE TABLE b ( b UInt64) ENGINE = Memory;
SET allow_experimental_analyzer = 1;
SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS a;
DROP TABLE iF EXISTS b;
