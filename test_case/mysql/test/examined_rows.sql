SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM t2 UNION SELECT * FROM t3;
SELECT sleep(0.5) FROM t17059925 UNION ALL SELECT * FROM t2 UNION ALL SELECT * FROM t3;
SELECT 1 FROM dual WHERE 1= 0 UNION SELECT sleep(0.5);
SELECT sleep(0.5) FROM t17059925 UNION SELECT 1 FROM dual WHERE 1= 0 UNION SELECT * FROM t2;
SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION SELECT sleep(0.5);
SELECT * FROM t17059925 WHERE a= 10 UNION SELECT sleep(0.5);
SELECT * FROM (SELECT * FROM t17059925 WHERE a= 10) t WHERE a = 10 UNION SELECT sleep(0.5);
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION SELECT * FROM t2;
SELECT sleep(0.5) FROM t17059925 UNION ALL SELECT * FROM t17059925 WHERE a= 10 AND a= 20 UNION ALL SELECT * FROM t2;
SELECT sleep(0.5) FROM t17059925 UNION SELECT * FROM (SELECT * FROM t17059925 WHERE a= 10) t WHERE a = 10 UNION SELECT * from t2;
DROP TABLE t17059925, t2, t3;
CREATE TABLE tbl_18335504(a INT, b INT, KEY i1(a));
INSERT INTO tbl_18335504 VALUES( 30, 1);
INSERT INTO tbl_18335504 VALUES( 20, 2);
INSERT INTO tbl_18335504 VALUES( 10, 3);
DROP TABLE tbl_18335504;
