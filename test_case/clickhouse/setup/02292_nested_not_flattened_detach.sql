DROP TABLE IF EXISTS t_nested_detach;
SET flatten_nested = 0;
CREATE TABLE t_nested_detach (n Nested(u UInt32, s String)) ENGINE = Log;
