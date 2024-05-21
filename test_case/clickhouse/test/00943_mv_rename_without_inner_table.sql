DROP TABLE IF EXISTS src;
DROP TABLE IF EXISTS dst;
DROP TABLE IF EXISTS original_mv;
DROP TABLE IF EXISTS new_mv;
CREATE TABLE src (x UInt8) ENGINE = Null;
CREATE TABLE dst (x UInt8) ENGINE = Memory;
CREATE MATERIALIZED VIEW original_mv TO dst AS SELECT * FROM src;
INSERT INTO src VALUES (1), (2);
SELECT * FROM original_mv ORDER BY x;
RENAME TABLE original_mv TO new_mv;
INSERT INTO src VALUES (3);
SELECT * FROM dst ORDER BY x;
SELECT * FROM new_mv ORDER BY x;
DROP TABLE IF EXISTS src;
DROP TABLE IF EXISTS dst;
DROP TABLE IF EXISTS original_mv;
DROP TABLE IF EXISTS new_mv;
