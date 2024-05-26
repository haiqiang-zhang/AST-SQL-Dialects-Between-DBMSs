SELECT NTH_VALUE(6,1)    OVER ();
CREATE TABLE t1 (d DOUBLE, id INT, sex CHAR(1));
INSERT INTO t1 VALUES (1.0, 1, 'M'),
                      (2.0, 2, 'F'),
                      (3.0, 3, 'F'),
                      (4.0, 4, 'F'),
                      (5.0, 5, 'M'),
                      (NULL, NULL, 'M'),
                      (10.0, 10, NULL),
                      (10.0, 10, NULL),
                      (11.0, 11, NULL);
PREPARE p FROM "SELECT id, sex, NTH_VALUE(id, ?) OVER () FROM t1";
DROP PREPARE p;
SELECT d, SUM(d) OVER w, sex, NTH_VALUE(d, 2) OVER w FROM t1 WINDOW w as (PARTITION BY SEX ORDER BY D ROWS 2 PRECEDING);
SELECT d, SUM(d) OVER w, COUNT(*) OVER w, NTH_VALUE(d, 2) OVER w FROM t1 WINDOW w as (ORDER BY D ROWS 2 PRECEDING);
SELECT id, COUNT(*) OVER w, NTH_VALUE(id, 2) OVER w FROM t1 WINDOW w as (ORDER BY ID ROWS 2 PRECEDING);
SELECT id, COUNT(*) OVER w,
       NTH_VALUE(id, 3) OVER w,
       FIRST_VALUE(id) OVER w,
       NTH_VALUE(id, 1) OVER w,
       NTH_VALUE(id, 2) OVER w FROM t1
  WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
SELECT id, SUM(d) OVER w, COUNT(*) OVER w,
       NTH_VALUE(id, 3) OVER w,
       FIRST_VALUE(id) OVER w,
       NTH_VALUE(id, 1) OVER w,
       NTH_VALUE(id, 2) OVER w FROM t1
  WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
DROP TABLE t1;
CREATE TABLE `test`(
  `pk` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `dt` DATETIME DEFAULT NULL,
  `ge` GEOMETRY DEFAULT NULL
);
SELECT dt, NTH_VALUE(dt, 3) OVER w1 nth,
           CAST(NTH_VALUE(ge, 3) OVER w1 AS JSON) ge
    FROM test WHERE `pk` = 2 WINDOW w1 AS ();
SELECT dt, NTH_VALUE(dt, 3) OVER w1 nth,
           CAST(NTH_VALUE(ge, 3) OVER w1 AS JSON) ge
    FROM test WHERE `pk` > 3 WINDOW w1 AS ();
DROP TABLE `test`;
CREATE TABLE t(a INT, b INT, c INT, d INT);
INSERT INTO t VALUES (1,1,1,1), (2,2,4,2), (3,3,9,3);
SELECT 1+NTH_VALUE(SUM(c/d), 1) OVER (ORDER BY a)  FROM t GROUP BY a,b;
SELECT ROW_NUMBER() OVER () rn,
       1+NTH_VALUE(SUM(c/d), 1) OVER (ORDER BY a) plus_fv,
       1+NTH_VALUE(SUM(c/d), 2) OVER (ORDER BY a) plus_lv FROM t GROUP BY a,b;
DROP TABLE t;
SELECT ((MAKETIME(((QUARTER('| !*c>*{/'))<=>
               (NTH_VALUE(JSON_OBJECTAGG('key4',0x067c13d0d0d7d8c8d768aef7)
                    ,1)OVER())),'9236-05-27',0xe2a7d4))^(0x1109));
SELECT ((NTH_VALUE(JSON_MERGE_PATCH(1.755913e+308,'{ }'),246)OVER())<=(1));
SELECT ((QUOTE(JSON_KEYS(NTH_VALUE(JSON_KEYS(EXP(-15676),ABS('d0')),
                          162)OVER())))>=(CONNECTION_ID()));
SELECT JSON_LENGTH(NTH_VALUE(JSON_OBJECTAGG('key2','*B'),172)OVER());
