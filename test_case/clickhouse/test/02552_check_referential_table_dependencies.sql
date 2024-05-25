DROP TABLE IF EXISTS mv;
DROP TABLE IF EXISTS src;
DROP TABLE IF EXISTS dst;
CREATE TABLE src (x UInt8) ENGINE = Memory;
CREATE TABLE dst (x UInt8) ENGINE = Memory;
CREATE MATERIALIZED VIEW mv TO dst AS SELECT x FROM src;
SET check_referential_table_dependencies = 1;
-- Ok to drop in the correct order
DROP TABLE mv;
CREATE MATERIALIZED VIEW mv TO dst AS SELECT x FROM src;
SET check_referential_table_dependencies = 0;
DROP TABLE src;
DROP TABLE dst;
DROP TABLE mv;
