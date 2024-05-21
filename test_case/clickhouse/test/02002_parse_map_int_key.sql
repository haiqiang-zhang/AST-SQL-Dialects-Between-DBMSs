SET allow_experimental_map_type = 1;
DROP TABLE IF EXISTS t_map_int_key;
CREATE TABLE t_map_int_key (m1 Map(UInt32, UInt32), m2 Map(Date, UInt32)) ENGINE = Memory;
SELECT m1, m2 FROM t_map_int_key;
DROP TABLE t_map_int_key;