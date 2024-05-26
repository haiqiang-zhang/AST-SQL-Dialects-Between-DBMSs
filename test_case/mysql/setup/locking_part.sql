CREATE TABLE t1 (
a char(2) NOT NULL,
b char(2) NOT NULL,
c int(10) unsigned NOT NULL,
d varchar(255) DEFAULT NULL,
e varchar(1000) DEFAULT NULL,
PRIMARY KEY (a, b, c),
KEY (a),
KEY (a, b)
) charset latin1 PARTITION BY KEY (a) PARTITIONS 20;
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
CREATE TABLE t2 (a int, name VARCHAR(50), purchased DATE)
PARTITION BY RANGE (a)
(PARTITION p0 VALUES LESS THAN (3),
 PARTITION p1 VALUES LESS THAN (7),
 PARTITION p2 VALUES LESS THAN (9),
 PARTITION p3 VALUES LESS THAN (11));
INSERT INTO t2 VALUES
(1, 'desk organiser', '2003-10-15'),
(2, 'CD player', '1993-11-05'),
(3, 'TV set', '1996-03-10'),
(4, 'bookcase', '1982-01-10'),
(5, 'exercise bike', '2004-05-09'),
(6, 'sofa', '1987-06-05'),
(7, 'popcorn maker', '2001-11-22'),
(8, 'acquarium', '1992-08-04'),
(9, 'study desk', '1984-09-16'),
(10, 'lava lamp', '1998-12-25');
CREATE TABLE t3 SELECT * FROM t1;
ALTER TABLE t3 ADD PRIMARY KEY (d);
ALTER TABLE t3 ADD KEY (a);
ALTER TABLE t3 ADD KEY (a, b);
