CREATE TABLE t1(a INT, 
                b INT, 
                PRIMARY KEY(a , b), 
                KEY(b)) ENGINE=MyISAM DELAY_KEY_WRITE = 1;
INSERT INTO t1 VALUES (1,2),(2,3),(3,4),(4,5),(5,6);
DROP TABLE t1;
