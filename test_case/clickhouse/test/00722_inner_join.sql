SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS one;
CREATE TABLE one(dummy UInt8) ENGINE = Memory;
SET join_default_strictness = 'ALL';
SELECT count(t.database)
    FROM (SELECT * FROM system.tables WHERE name = 'one') AS t
    JOIN system.databases AS db ON t.database = db.name;
SELECT count(db.name)
    FROM system.tables AS t
    JOIN system.databases AS db ON t.database = db.name
    WHERE t.name = 'one';
SELECT count()
    FROM system.tables AS t
    JOIN system.databases AS db ON db.name = t.database
    WHERE t.name = 'one';
DROP TABLE one;