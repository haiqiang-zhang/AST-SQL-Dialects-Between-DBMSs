drop table if exists t1, t2;
CREATE TABLE t1 (
       id MEDIUMINT NOT NULL AUTO_INCREMENT,
       dt DATE, st VARCHAR(255), uid INT,
       id2nd LONGBLOB, filler VARCHAR(255), PRIMARY KEY(id, dt)
);
INSERT INTO t1 (dt, st, uid, id2nd, filler) VALUES
   ('1991-03-14', 'Initial Insert', 200, 1234567, 'No Data'),
   ('1991-02-26', 'Initial Insert', 201, 1234567, 'No Data'),
   ('1992-03-16', 'Initial Insert', 234, 1234567, 'No Data'),
   ('1992-07-02', 'Initial Insert', 287, 1234567, 'No Data'),
   ('1991-05-26', 'Initial Insert', 256, 1234567, 'No Data'),
   ('1991-04-25', 'Initial Insert', 222, 1234567, 'No Data'),
   ('1993-03-12', 'Initial Insert', 267, 1234567, 'No Data'),
   ('1993-03-14', 'Initial Insert', 291, 1234567, 'No Data'),
   ('1991-12-20', 'Initial Insert', 298, 1234567, 'No Data'),
   ('1994-10-31', 'Initial Insert', 220, 1234567, 'No Data');
ALTER TABLE t1 PARTITION BY LIST (YEAR(dt)) (
    PARTITION d1 VALUES IN (1991, 1994),
    PARTITION d2 VALUES IN (1993),
    PARTITION d3 VALUES IN (1992, 1995, 1996)
);
INSERT INTO t1 (dt, st, uid, id2nd, filler) VALUES
   ('1991-07-14', 'After Partitioning Insert', 299, 1234567, 'Insert row');
UPDATE t1 SET filler='Updating the row' WHERE uid=298;
DROP TABLE t1;
CREATE TABLE t1 (
a char(2) NOT NULL,
b char(2) NOT NULL,
c int(10) unsigned NOT NULL,
d varchar(255) DEFAULT NULL,
e varchar(1000) DEFAULT NULL,
PRIMARY KEY (a, b, c),
KEY (a),
KEY (a, b)
);
INSERT INTO t1 (a, b, c, d, e) VALUES
('07', '03', 343, '1', '07_03_343'),
('01', '04', 343, '2', '01_04_343'),
('01', '06', 343, '3', '01_06_343'),
('01', '07', 343, '4', '01_07_343'),
('01', '08', 343, '5', '01_08_343'),
('01', '09', 343, '6', '01_09_343'),
('03', '03', 343, '7', '03_03_343'),
('03', '06', 343, '8', '03_06_343'),
('03', '07', 343, '9', '03_07_343'),
('04', '03', 343, '10', '04_03_343'),
('04', '06', 343, '11', '04_06_343'),
('05', '03', 343, '12', '05_03_343'),
('11', '03', 343, '13', '11_03_343'),
('11', '04', 343, '14', '11_04_343');
UPDATE t1 AS A,
(SELECT '03' AS a, '06' AS b, 343 AS c, 'last' AS d) AS B
SET A.e = B.d  
WHERE A.a = '03'  
AND A.b = '06' 
AND A.c = 343;
DROP TABLE t1;
CREATE TABLE t1 (a VARCHAR(51) CHARACTER SET latin1)
PARTITION BY KEY (a) PARTITIONS 1;
INSERT INTO t1 VALUES ('a'),('b'),('c');
DROP TABLE t1;
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL)
PARTITION BY KEY (a) PARTITIONS 2;
INSERT INTO t1 VALUES (0,1), (0,2);
