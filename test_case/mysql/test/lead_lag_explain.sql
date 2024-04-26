
SET NAMES utf8mb4;

CREATE TABLE t1 (d DOUBLE, id INT, sex CHAR(1), n INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(n));
INSERT INTO t1(d, id, sex) VALUES (1.0, 1, 'M'),
                      (2.0, 2, 'F'),
                      (3.0, 3, 'F'),
                      (4.0, 4, 'F'),
                      (5.0, 5, 'M'),
                      (NULL, NULL, 'M'),
                      (10.0, 10, NULL),
                      (10.0, 10, NULL),
                      (11.0, 11, NULL);
    (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
    (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
    (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
    (ORDER BY id DESC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
CREATE TABLE t (c1 CHAR(10) CHARACTER SET big5,
                i INT,
                c2 VARCHAR(10) CHARACTER SET euckr);

DROP TABLE t;
CREATE TABLE t (c1 CHAR(10) CHARACTER SET utf8mb4,
                i INT,
                c2 VARCHAR(10) CHARACTER SET latin1);

INSERT INTO t VALUES('A', 1, '1');
INSERT INTO t VALUES('A', 3, '3');
INSERT INTO t VALUES(x'F09F90AC' /* dolphin */, 5, null);
INSERT INTO t VALUES('A', 5, null);
INSERT INTO t VALUES(null, 10, '0');
CREATE TABLE tt AS SELECT LEAD(c1, 0, c2) OVER () c FROM t;
CREATE TABLE ts AS SELECT LEAD(c2, 1, c1) OVER () c FROM t;
DROP TABLE t, tt, ts;

CREATE TABLE t (c1 VARCHAR(10),
                j1 JSON,
                g1 POINT,
                i1 INT,
                b1 BLOB,
                d1 DOUBLE,
                e1 DECIMAL(5,4),
                e2 DECIMAL(5,2));

INSERT INTO t VALUES (null, '[6]', ST_POINTFROMTEXT('POINT(6 6)'), 6, '6', 6.0, 10.0/3, 20.0/3),
                     ('7', null ,   ST_POINTFROMTEXT('POINT(7 7)'), 7, '7', 7.0, 10.0/3, 20.0/3),
                     ('8', '[8]' ,  null,                           7, '8', 8.0, 10.0/3, 20.0/3),
                     ('9', '[9]' , ST_POINTFROMTEXT('POINT(9 9)'), null, '9', 9.0, 10.0/3, 20.0/3),
                     ('0', '[0]' , ST_POINTFROMTEXT('POINT(0 0)'), 0, null, 0.0, 10.0/3, 20.0/3),
                     ('1', '[1]' , ST_POINTFROMTEXT('POINT(1 1)'), 1, '1', null, 10.0/3, 20.0/3),
                     ('2', '[2]' , ST_POINTFROMTEXT('POINT(2 2)'), 2, '2', 2.0, null, 20.0/3),
                     ('3', '[3]' , ST_POINTFROMTEXT('POINT(3 3)'), 3, '3', 3.0, 10.0/3, null);

DROP TABLE t;
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY id);
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY sex);
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY id);
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY ID ROWS UNBOUNDED PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY ID RANGE UNBOUNDED PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d ROWS 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d RANGE 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ROWS 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d DESC ROWS 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d DESC RANGE 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE 2 PRECEDING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id ROWS 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id RANGE 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ROWS 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id DESC ROWS 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id DESC RANGE 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE 2 PRECEDING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       LEAD(d, 3) OVER w le3,
       FIRST_VALUE(d) OVER w fv,
       LEAD(d, 1) OVER w le1,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY d ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
       LEAD(id, 3) OVER w le3,
       FIRST_VALUE(id) OVER w fv,
       LEAD(id, 1) OVER w le1,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);

DROP TABLE t1;

CREATE TABLE t(i INT);
INSERT INTO t VALUES (NULL), (1), (2), (3), (3), (4), (5), (6), (6), (7), (8), (9), (10);
       FROM t WINDOW w AS (ORDER BY i);
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
       LEAD(i,2) OVER w le2,
       LAG(i) OVER w la FROM t
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);

DROP TABLE t;
