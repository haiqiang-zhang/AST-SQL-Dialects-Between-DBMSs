
let $MYSQLD_DATADIR= `select @@datadir`;
SET GLOBAL delay_key_write=ALL;
CREATE TABLE t1(a INT, 
                b INT, 
                PRIMARY KEY(a , b), 
                KEY(b)) ENGINE=MyISAM DELAY_KEY_WRITE = 1;
INSERT INTO t1 VALUES (1,2),(2,3),(3,4),(4,5),(5,6);
SET SESSION debug="d,crash_before_flush_keys";

-- Must report that the table wasn't closed properly
CHECK TABLE t1;
DROP TABLE t1;
