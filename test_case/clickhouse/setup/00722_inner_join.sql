SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS one;
CREATE TABLE one(dummy UInt8) ENGINE = Memory;
SET join_default_strictness = 'ALL';
