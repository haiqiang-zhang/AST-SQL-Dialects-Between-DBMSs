SELECT LEAD(6, 0)    OVER ();
SELECT LAG(6, 0)    OVER ();
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
PREPARE p FROM "SELECT id, sex, LEAD(id, ?) OVER () FROM t1";
PREPARE p FROM "SELECT id, sex, LEAD(id+?, ?, ?) RESPECT NULLS OVER () FROM t1";
DROP PREPARE p;
SELECT n, id, LEAD(id, 1, 3) OVER
    (ORDER BY id DESC, n ASC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
SELECT n, id,  LAG(id, 0, n*n) OVER
    (ORDER BY id DESC, n ASC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
SELECT n, id,  LAG(id, 1, n*n) OVER
    (ORDER BY id DESC, n ASC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
SELECT n, id,  LEAD(id, 1, n*n) OVER
    (ORDER BY id DESC, n ASC ROWS BETWEEN  CURRENT ROW AND 2 FOLLOWING) L FROM t1;
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
SELECT c1, c2, LEAD(c1, 0, c2) OVER () l0 FROM t;
SELECT c1, c2, LEAD(c1, 1, c2) OVER () l1 FROM t;
SELECT c1, c2, LEAD(c2, 1, c1) OVER () l1 FROM t;
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
SELECT LEAD(c1, 100, j1) OVER () lcj, IFNULL(c1, j1) ifn_cj FROM t;
SELECT LEAD(j1, 100, j1) OVER () lcj, IFNULL(c1, j1) ifn_cj FROM t;
SELECT HEX(LEAD(c1, 100, g1) OVER ()) lcg, IFNULL(c1, g1) ifn_cg FROM t;
SELECT LEAD(c1, 100, i1) OVER () lci, IFNULL(c1, i1) ifn_ci FROM t;
SELECT LEAD(c1, 100, b1) OVER () lcb, IFNULL(c1, b1) ifn_cb FROM t;
SELECT LEAD(c1, 100, d1) OVER () lcd, IFNULL(c1, d1) ifn_cd FROM t;
SELECT LEAD(c1, 100, e1) OVER () lce1, IFNULL(c1, e1) ifn_ce1 FROM t;
SELECT LEAD(c1, 100, e2) OVER () lce2, IFNULL(c1, e2) ifn_ce2 FROM t;
SELECT LEAD(j1, 100, c1) OVER () ljc, IFNULL(j1, c1) ifn_jc FROM t;
SELECT HEX(LEAD(j1, 100, g1) OVER ()) ljg, IFNULL(j1, g1) ifn_jg FROM t;
SELECT LEAD(j1, 100, i1) OVER () lji, IFNULL(j1, i1) ifn_ji FROM t;
SELECT LEAD(j1, 100, b1) OVER () ljb, IFNULL(j1, b1) ifn_jb FROM t;
SELECT LEAD(j1, 100, d1) OVER () ljd, IFNULL(j1, d1) ifn_jd FROM t;
SELECT LEAD(j1, 100, e1) OVER () lje1, IFNULL(j1, e1) ifn_je1 FROM t;
SELECT LEAD(j1, 100, e2) OVER () lje2, IFNULL(j1, e2) ifn_je2 FROM t;
SELECT HEX(LEAD(g1, 100, c1) OVER ()) lgc, IFNULL(g1, c1) ifn_gc FROM t;
SELECT HEX(LEAD(g1, 100, j1) OVER ()) lgj, IFNULL(g1, j1) ifn_gj FROM t;
SELECT HEX(LEAD(g1, 100, i1) OVER ()) lgi, IFNULL(g1, i1) ifn_gi FROM t;
SELECT HEX(LEAD(g1, 100, b1) OVER ()) lgb, IFNULL(g1, b1) ifn_gb FROM t;
SELECT HEX(LEAD(g1, 100, d1) OVER ()) lgd, IFNULL(g1, d1) ifn_gd FROM t;
SELECT HEX(LEAD(g1, 100, e1) OVER ()) lge1, IFNULL(g1, e1) ifn_ge1 FROM t;
SELECT HEX(LEAD(g1, 100, e2) OVER ()) lge2, IFNULL(g1, e2) ifn_ge2 FROM t;
SELECT LEAD(i1, 100, c1) OVER () lic, IFNULL(i1, c1) ifn_ic FROM t;
SELECT LEAD(i1, 100, j1) OVER () lij, IFNULL(i1, j1) ifn_ij FROM t;
SELECT HEX(LEAD(i1, 100, g1) OVER ()) lig, IFNULL(i1, g1) ifn_ig FROM t;
SELECT LEAD(i1, 100, b1) OVER () lib, IFNULL(i1, b1) ifn_ib FROM t;
SELECT LEAD(i1, 100, d1) OVER () lid, IFNULL(i1, d1) ifn_id FROM t;
SELECT LEAD(i1, 100, e1) OVER () lie1, IFNULL(i1, e1) ifn_ie1 FROM t;
SELECT LEAD(i1, 100, e2) OVER () lie2, IFNULL(i1, e2) ifn_ie2 FROM t;
SELECT LEAD(b1, 100, c1) OVER () lbc, IFNULL(b1, c1) ifn_bc FROM t;
SELECT LEAD(b1, 100, j1) OVER () lbj, IFNULL(b1, j1) ifn_bj FROM t;
SELECT HEX(LEAD(b1, 100, g1) OVER ()) lbg, IFNULL(b1, g1) ifn_bg FROM t;
SELECT LEAD(b1, 100, i1) OVER () lbi, IFNULL(b1, i1) ifn_bi FROM t;
SELECT LEAD(b1, 100, d1) OVER () lbd, IFNULL(b1, d1) ifn_bd FROM t;
SELECT LEAD(b1, 100, e1) OVER () lbe1, IFNULL(b1, e1) ifn_be1 FROM t;
SELECT LEAD(b1, 100, e2) OVER () lbe2, IFNULL(b1, e2) ifn_be2 FROM t;
SELECT LEAD(d1, 100, c1) OVER () ldc, IFNULL(d1, c1) ifn_dc FROM t;
SELECT LEAD(d1, 100, j1) OVER () ldj, IFNULL(d1, j1) ifn_dj FROM t;
SELECT HEX(LEAD(d1, 100, g1) OVER ()) ldg, IFNULL(d1, g1) ifn_dg FROM t;
SELECT LEAD(d1, 100, i1) OVER () ldi, IFNULL(d1, i1) ifn_di FROM t;
SELECT LEAD(d1, 100, b1) OVER () ldd, IFNULL(d1, b1) ifn_db FROM t;
SELECT LEAD(d1, 100, e1) OVER () lde1, IFNULL(d1, e1) ifn_de1 FROM t;
SELECT LEAD(d1, 100, e2) OVER () lde2, IFNULL(d1, e2) ifn_de2 FROM t;
SELECT LEAD(e1, 100, c1) OVER () le1c, IFNULL(e1, c1) ifn_e1c FROM t;
SELECT LEAD(e1, 100, j1) OVER () le1j, IFNULL(e1, j1) ifn_e1j FROM t;
SELECT HEX(LEAD(e1, 100, g1) OVER ()) le1g, IFNULL(e1, g1) ifn_e1g FROM t;
SELECT LEAD(e1, 100, i1) OVER () le1i, IFNULL(e1, i1) ifn_e1i FROM t;
SELECT LEAD(e1, 100, b1) OVER () le1d, IFNULL(e1, b1) ifn_e1d FROM t;
SELECT LEAD(e1, 100, d1) OVER () le1d, IFNULL(e1, d1) ifn_e1d FROM t;
SELECT LEAD(e1, 100, e2) OVER () le1e2, IFNULL(e1, e2) ifn_e1e2 FROM t;
SELECT LEAD(e2, 100, c1) OVER () le2c, IFNULL(e2, c1) ifn_e2c FROM t;
SELECT LEAD(e2, 100, j1) OVER () le2j, IFNULL(e2, j1) ifn_e2j FROM t;
SELECT HEX(LEAD(e2, 100, g1) OVER ()) le2g, IFNULL(e2, g1) ifn_e2g FROM t;
SELECT LEAD(e2, 100, i1) OVER () le2i, IFNULL(e2, i1) ifn_e2i FROM t;
SELECT LEAD(e2, 100, b1) OVER () le2d, IFNULL(e2, b1) ifn_e2d FROM t;
SELECT LEAD(e2, 100, d1) OVER () le2d, IFNULL(e2, d1) ifn_e2d FROM t;
SELECT LEAD(e2, 100, e1) OVER () le2e1, IFNULL(e2, e1) ifn_e2e1 FROM t;
DROP TABLE t;
SELECT id, sex, COUNT(*) OVER w cnt, NTILE(3) OVER w `ntile`,
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY id);
SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth,
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY sex ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth,
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY id ORDER BY sex ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
SELECT id, sex, COUNT(*) OVER w cnt,
       LEAD(id, 1) OVER w le1,
       LAG(id, 1) OVER w la1,
       LEAD(id, 100) OVER w le100,
       LAG(id, 2, 777) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY ID ROWS UNBOUNDED PRECEDING);
SELECT id, sex, COUNT(*) OVER w cnt, NTH_VALUE(id, 2) OVER w nth,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY ID RANGE UNBOUNDED PRECEDING);
SELECT d, SUM(d) OVER w `sum`, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d ROWS 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d RANGE 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ROWS 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d DESC ROWS 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY d DESC RANGE 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE 2 PRECEDING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY d DESC RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, sex, COUNT(*) OVER w cnt, NTILE(3) OVER w `ntile`,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1 WINDOW w as (ORDER BY id);
SELECT id, SUM(id) OVER w `sum`, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id ROWS 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id RANGE 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ROWS 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id ASC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id DESC ROWS 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (PARTITION BY SEX ORDER BY id DESC RANGE 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE 2 PRECEDING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING);
SELECT id, SUM(id) OVER w `sum`, COUNT(*) OVER w cnt, sex,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w as (ORDER BY id DESC RANGE BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(d, 3) OVER w le3,
       FIRST_VALUE(d) OVER w fv,
       LEAD(d, 1) OVER w le1,
       LEAD(d, 2) OVER w le2,
       LAG(d, 2) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY d ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
SELECT id, SUM(d) OVER w `sum`, COUNT(*) OVER w cnt,
       LEAD(id, 3) OVER w le3,
       FIRST_VALUE(id) OVER w fv,
       LEAD(id, 1) OVER w le1,
       LEAD(id, 2) OVER w le2,
       LAG(id, 2) OVER w la2 FROM t1
       WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
DROP TABLE t1;
CREATE TABLE t(i INT);
INSERT INTO t VALUES (NULL), (1), (2), (3), (3), (4), (5), (6), (6), (7), (8), (9), (10);
SELECT i, PERCENT_RANK() OVER w cd
       FROM t WINDOW w AS (ORDER BY i);
SELECT i, PERCENT_RANK() OVER w cd FROM t
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
SELECT i, PERCENT_RANK() OVER w cd, NTILE(3) OVER w `ntile`, COUNT(*) OVER w cnt, SUM(i) OVER W `sum` FROM t
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
SELECT i, PERCENT_RANK() OVER w cd, NTILE(3) OVER w `ntile`, COUNT(*) OVER w cnt, SUM(i) OVER W `sum`,
       LEAD(i,2) OVER w le2,
       LAG(i) OVER w la FROM t
       WINDOW w AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);
DROP TABLE t;
CREATE TABLE t(i INT NOT NULL);
INSERT INTO t VALUES (1), (2), (3), (3), (4), (5), (6);
DROP TABLE t;
CREATE TABLE `test`(
  `pk` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `dt` DATETIME DEFAULT NULL,
  `ge` GEOMETRY DEFAULT NULL
);
SELECT dt, LEAD(dt, 1) OVER w1 `lead`,
       CAST(LEAD(ge, 1) OVER w1 AS JSON) geo
   FROM test WHERE `pk` = 2 WINDOW w1 AS ();
SELECT dt, LAG(dt) OVER w1 `lag`,
       CAST(LAG(ge) OVER w1 AS JSON) geo
   FROM test WHERE `pk` > 3 WINDOW w1 AS ();
DROP TABLE `test`;
CREATE TABLE t(a INT, b INT, c INT, d INT);
INSERT INTO t VALUES (1,1,1,1), (2,2,4,2), (3,3,9,3);
SELECT SUM(c/d), LEAD(SUM(c/d), 1) OVER (ORDER BY a)  FROM t GROUP BY a,b;
SELECT SUM(c/d), LAG(SUM(c/d), 1) OVER (ORDER BY a)  FROM t GROUP BY a,b;
SELECT 1+LEAD(SUM(c/d), 1) OVER (ORDER BY a)  FROM t GROUP BY a,b;
SELECT ROW_NUMBER() OVER () rn,
       1 + LEAD(SUM(c/d), 1) OVER (ORDER BY a) le1,
       1 + LAG(SUM(c/d), 1) OVER (ORDER BY a) la1,
       1 + LEAD(SUM(c/d), 2) OVER (ORDER BY a) le2,
       1 + LAG(SUM(c/d), 2) OVER (ORDER BY a) la2,
       1 + LEAD(SUM(c/d), 1, SUM(c/d)) OVER (ORDER BY a) le1d,
       1 + LAG(SUM(c/d), 1, SUM(c/d)) OVER (ORDER BY a) la1d,
       1 + LEAD(SUM(c/d), 2, SUM(c/d)) OVER (ORDER BY a) le2d,
       1 + LAG(SUM(c/d), 2, SUM(c/d)) OVER (ORDER BY a) la2d,
       1 + LEAD(SUM(c/d), 1, 1 + SUM(c/d)) OVER (ORDER BY a) le1dp,
       1 + LAG(SUM(c/d), 1, 1 + SUM(c/d)) OVER (ORDER BY a) la1dp,
       1 + LEAD(SUM(c/d), 2, 1 + SUM(c/d)) OVER (ORDER BY a) le2dp,
       1 + LAG(SUM(c/d), 2, 1 + SUM(c/d)) OVER (ORDER BY a) la2dp
       FROM t GROUP BY a,b;
DROP TABLE t;
CREATE TABLE t1 (a int, b char(1), c varchar(1));
INSERT INTO t1 VALUES (1,'s','k'),(NULL,'e','t'),(NULL,'w','i'),(2,'i','k');
SELECT  LEAD(a, 7,'abc') OVER w1, LAG(a) OVER w1 FROM t1 WINDOW w1 AS (PARTITION BY a);
DROP TABLE t1;
SELECT ADDTIME(LEAD(time'18:00:00', 0) OVER (ORDER BY NULL), '01:00:00');
SELECT ADDDATE(LEAD(NULL, 1, date'1955-05-15') OVER (ORDER BY NULL), 1);
CREATE VIEW v AS
SELECT LEAD(d, 2) OVER () FROM
 (SELECT 1 AS d UNION SELECT 2 UNION SELECT 3) dt;
SELECT * FROM v;
DROP VIEW v;
CREATE TABLE t1e(a int);
INSERT INTO t1e VALUES(1),(2),(3),(3),(NULL);
DROP TABLE t1e;
SELECT ((MAKETIME(((QUARTER('| !*c>*{/'))<=>
               (LAG(JSON_OBJECTAGG('key4',0x067c13d0d0d7d8c8d768aef7)
                    ,7)OVER())),'9236-05-27',0xe2a7d4))^(0x1109));
SELECT ((LAG(JSON_MERGE_PATCH(1.755913e+308,'{ }'),246)OVER())<=(1));
SELECT ((QUOTE(JSON_KEYS(LEAD(JSON_KEYS(EXP(-15676),ABS('d0')),
                          162)OVER())))>=(CONNECTION_ID()));
SELECT JSON_LENGTH(LEAD(JSON_OBJECTAGG('key2','*B'),172)OVER());
