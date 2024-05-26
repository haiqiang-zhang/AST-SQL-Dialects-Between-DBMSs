SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS one;
CREATE TABLE one(dummy UInt8) ENGINE = Memory;
SET join_default_strictness = 'ALL';
SELECT count(t.database)
    FROM (SELECT * FROM system.tables WHERE name = 'one') AS t
    JOIN system.databases AS db ON t.database = db.name;
DROP TABLE one;
