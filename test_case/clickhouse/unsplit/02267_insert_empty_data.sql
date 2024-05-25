DROP TABLE IF EXISTS t;
CREATE TABLE t (n UInt32) ENGINE=Memory;
set throw_if_no_data_to_insert = 0;
DROP TABLE t;
