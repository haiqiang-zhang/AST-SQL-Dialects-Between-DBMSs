CREATE TABLE t1(f1 INT, f2 INT);
INSERT INTO t1 VALUES
(1,1),(2,2),(3,3);
CREATE TABLE t2(f1 INT NOT NULL, f2 INT NOT NULL, f3 CHAR(200), KEY(f1, f2));
INSERT INTO t2 VALUES
(1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'),
(2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'),
(3,1, 'qwerty'),(3,4, 'qwerty'),
(4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty'),
(1,1, 'qwerty'),(1,2, 'qwerty'),(1,3, 'qwerty'),
(2,1, 'qwerty'),(2,2, 'qwerty'),(2,3, 'qwerty'), (2,4, 'qwerty'),(2,5, 'qwerty'),
(3,1, 'qwerty'),(3,4, 'qwerty'),
(4,1, 'qwerty'),(4,2, 'qwerty'),(4,3, 'qwerty'), (4,4, 'qwerty');
CREATE TABLE t3 (f1 INT NOT NULL, f2 INT, f3 VARCHAR(32),
                 PRIMARY KEY(f1), KEY f2_idx(f1), KEY f3_idx(f3));
INSERT INTO t3 VALUES
(1, 1, 'qwerty'), (2, 1, 'ytrewq'),
(3, 2, 'uiop'), (4, 2, 'poiu'), (5, 2, 'lkjh'),
(6, 2, 'uiop'), (7, 2, 'poiu'), (8, 2, 'lkjh'),
(9, 2, 'uiop'), (10, 2, 'poiu'), (11, 2, 'lkjh'),
(12, 2, 'uiop'), (13, 2, 'poiu'), (14, 2, 'lkjh');
INSERT INTO t3 SELECT f1 + 20, f2, f3 FROM t3;
INSERT INTO t3 SELECT f1 + 40, f2, f3 FROM t3;
