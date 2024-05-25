CREATE TABLE 03006_buffer_overflow_l (`a` String, `b` Tuple(String, String)) ENGINE = Memory;
INSERT INTO 03006_buffer_overflow_l SELECT * FROM generateRandom() limit 1000;
CREATE TABLE 03006_buffer_overflow_r (`a` LowCardinality(Nullable(String)), `c` Tuple(LowCardinality(String), LowCardinality(String))) ENGINE = Memory;
INSERT INTO 03006_buffer_overflow_r SELECT * FROM generateRandom() limit 1000;
