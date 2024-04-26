
SET NAMES utf8mb3;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,1), (1,4), (1,2), (1,4);
let $query=
SELECT i, j, SUM(i+j) OVER (ROWS UNBOUNDED PRECEDING) foo FROM t;

let $query=
SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t;
CREATE VIEW v AS
SELECT i, j, SUM(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) foo FROM t;
DROP VIEW v;
INSERT INTO t VALUES (999961560, DEFAULT), (44721, DEFAULT);

DROP TABLE t;

CREATE TABLE t(i INT, j INT, k INT);
INSERT INTO t VALUES (1,1,1), (1,4,1), (1,2,1), (1,4,1);
INSERT INTO t VALUES (1,1,2), (1,4,2), (1,2,2), (1,4,2);
INSERT INTO t VALUES (1,1,3), (1,4,3), (1,2,3), (1,4,3);
INSERT INTO t VALUES (1,1,4), (1,4,4), (1,2,4), (1,4,4);


DROP TABLE t;
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M'),
                      (2, 'F'),
                      (3, 'F'),
                      (4, 'F'),
                      (5, 'M');
CREATE TABLE t2 (user_id INTEGER NOT NULL, date DATE);
INSERT INTO t2 VALUES (1, '2002-06-09'),
                      (2, '2002-06-09'),
                      (1, '2002-06-09'),
                      (3, '2002-06-09'),
                      (4, '2002-06-09'),
                      (4, '2002-06-09'),
                      (5, '2002-06-09');
let $query=
SELECT  sex, AVG(id) AS uids, RANK() OVER w `rank` FROM t1 u, t2
   WHERE t2.user_id = u.id GROUP BY sex
   WINDOW w AS (ORDER BY AVG(id) DESC)
   ORDER BY `rank` DESC;
INSERT INTO t1 VALUES (10, NULL), (11, NULL);
       SUM(id) OVER (ROWS UNBOUNDED PRECEDING)
       FROM t1 u, t2 WHERE t2.user_id = u.id;
       SUM(AVG(id)) OVER (ROWS UNBOUNDED PRECEDING)
       FROM t1 u, t2 WHERE t2.user_id = u.id GROUP BY sex;
       WINDOW w AS (PARTITION BY sex ORDER BY id ASC ROWS UNBOUNDED PRECEDING);
       WINDOW w AS (PARTITION BY sex ORDER BY id ASC ROWS UNBOUNDED PRECEDING) ORDER BY summ;

CREATE TABLE t(d decimal(10,2), date DATE);

INSERT INTO t values  (10.4, '2002-06-09'),
                      (20.5, '2002-06-09'),
                      (10.4, '2002-06-10'),
                      (3,    '2002-06-09'),
                      (40.2, '2015-08-01'),
                      (40.2, '2002-06-09'),
                      (5,    '2015-08-01');
DROP TABLE t;

CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,NULL),
                     (1,NULL),
                     (1,1),
                     (1,NULL),
                     (1,2),
                     (2,1),
                     (2,2),
                     (2,NULL),
                     (2,NULL);
       WHERE t1.id=t2.user_id
       WINDOW w AS (PARTITION BY id ORDER BY sex);
       WHERE t1.id=t2.user_id
       WINDOW w AS (PARTITION BY date ORDER BY id);
               EXPLAIN FORMAT=JSON SELECT  date,id, RANK() OVER w AS `rank` FROM t1,t2 WINDOW w AS (PARTITION BY date ORDER BY id);
       WHERE t1.id=t2.user_id
       WINDOW w AS (PARTITION BY date ORDER BY id)
   ) AS t;
             RANK() OVER (ORDER BY sex,id),
             ROW_NUMBER() OVER (ORDER BY sex,id)
             FROM t1;
   SELECT t1.*,
       RANK() OVER (ORDER BY sex) AS r00,
       RANK() OVER (ORDER BY sex DESC) AS r01,
       RANK() OVER (ORDER BY sex, id DESC) AS r02,
       RANK() OVER (PARTITION BY id ORDER BY sex) AS r03,
       RANK() OVER (ORDER BY sex) AS r04,
       RANK() OVER (ORDER BY sex) AS r05,
       RANK() OVER (ORDER BY sex) AS r06,
       RANK() OVER (ORDER BY sex) AS r07,
       RANK() OVER (ORDER BY sex) AS r08,
       RANK() OVER (ORDER BY sex) AS r09,
       RANK() OVER (ORDER BY sex) AS r10,
       RANK() OVER (ORDER BY sex) AS r11,
       RANK() OVER (ORDER BY sex) AS r12,
       RANK() OVER (ORDER BY sex) AS r13,
       RANK() OVER (ORDER BY sex) AS r14
       FROM t1) t;
   SELECT t1.*,
       RANK() OVER (ORDER BY sex) AS r00,
       RANK() OVER (ORDER BY sex DESC) AS r01,
       RANK() OVER (ORDER BY sex, id DESC) AS r02,
       RANK() OVER (PARTITION BY id ORDER BY sex) AS r03,
       RANK() OVER (ORDER BY sex) AS r04,
       RANK() OVER (ORDER BY sex) AS r05,
       RANK() OVER (ORDER BY sex) AS r06,
       RANK() OVER (ORDER BY sex) AS r07,
       RANK() OVER (ORDER BY sex) AS r08,
       RANK() OVER (ORDER BY sex) AS r09,
       RANK() OVER (ORDER BY sex) AS r10,
       RANK() OVER (ORDER BY sex) AS r11,
       RANK() OVER (ORDER BY sex) AS r12,
       RANK() OVER (ORDER BY sex) AS r13,
       RANK() OVER (ORDER BY sex) AS r14
       FROM t1 LIMIT 4) t;
       WINDOW w AS (PARTITION BY sex);
SELECT id, SUM(id) OVER w, COUNT(*) OVER w, sex FROM t1
       WINDOW w AS (PARTITION BY sex)
       ) alias ORDER BY id;
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
CREATE VIEW v AS
SELECT id, SUM(id) OVER w, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
DROP VIEW v;
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
       WINDOW w AS (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
CREATE TABLE td(d DOUBLE);
INSERT INTO td VALUES (2),(2),(3),(1),(1.2),(NULL);
INSERT INTO td VALUES (1.7976931348623157E+307), (1);
SET SESSION windowing_use_high_precision=FALSE;
SET SESSION windowing_use_high_precision=TRUE;
INSERT INTO td VALUES (10),(1),(2),(3),(4),(5),(6),(7),(8),(9);
SET SESSION windowing_use_high_precision=FALSE;
SET SESSION windowing_use_high_precision=TRUE;

INSERT INTO td SELECT * FROM td;
SET SESSION windowing_use_high_precision=FALSE;
SET SESSION windowing_use_high_precision=TRUE;

DROP TABLE td;
    WINDOW w AS (ORDER BY id ROWS 1 PRECEDING);
DELETE FROM t1 WHERE id=11;
INSERT INTO t1 VALUES (11, NULL);
    FROM t1 WINDOW w1 AS (ORDER BY id ASC),
                   w2 AS ();
        COUNT(*) OVER w3
    FROM t1 WINDOW w1 AS (ORDER BY id ASC),
                   w2 AS (), w3 AS ();
    WINDOW w AS (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND 2 PRECEDING);
       WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);

INSERT INTO t1 VALUES (10, NULL);
       WINDOW w AS (PARTITION BY sex ORDER BY id);
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
                ROW_NUMBER() OVER w,
                RANK() OVER w  FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
INSERT INTO t1 VALUES (NULL, 'M');
select id, FIRST_VALUE(id) OVER (ROWS UNBOUNDED PRECEDING) FROM t1;

CREATE VIEW v AS
SELECT id, FIRST_VALUE(id) OVER w FROM t1 WINDOW w AS (ORDER BY id RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
DROP VIEW v;

CREATE TABLE td1 (id DOUBLE, sex CHAR(1));
INSERT INTO td1 SELECT * FROM t1;

DROP TABLE td1;

CREATE TABLE td_dec (id DECIMAL(10,2), sex CHAR(1));
INSERT INTO td_dec SELECT * FROM t1;
DROP TABLE td_dec;

CREATE TABLE td_str (id VARCHAR(20), sex CHAR(1));
INSERT INTO td_str SELECT * FROM t1;
DROP TABLE td_str;

CREATE TABLE t_date(id DATE);
INSERT INTO t_date VALUES ('2002-06-09'),
                          ('2002-06-09'),
                          ('2002-06-10'),
                          ('2002-06-09'),
                          ('2015-08-01'),
                          ('2002-06-09'),
                          ('2015-08-01');

CREATE VIEW v AS
SELECT id, FIRST_VALUE(id) OVER w FROM t_date WINDOW w AS (ORDER BY id RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
DROP VIEW v;

CREATE VIEW v AS
SELECT id, FIRST_VALUE(id) OVER w FROM t_date WINDOW w AS (ORDER BY id RANGE BETWEEN INTERVAL 2 DAY FOLLOWING AND INTERVAL 3 DAY FOLLOWING);
DROP VIEW v;

DROP TABLE t_date;

CREATE TABLE t_time(t TIME, ts TIMESTAMP);
INSERT INTO t_time VALUES ('12:30', '2016-07-05 08:30:42');
INSERT INTO t_time VALUES ('22:30', '2015-07-05 08:30:43');
INSERT INTO t_time VALUES ('13:30', '2014-07-05 08:30:44');
INSERT INTO t_time VALUES ('01:30', '2013-07-05 08:30:45');
INSERT INTO t_time VALUES ('15:30', '2016-08-05 08:31:42');
INSERT INTO t_time VALUES ('20:30', '2016-09-05 08:32:42');
INSERT INTO t_time VALUES ('04:30', '2016-10-05 08:33:42');
INSERT INTO t_time VALUES ('06:30', '2016-11-05 08:34:42');
INSERT INTO t_time VALUES ('18:30', '2016-07-05 09:30:42');
INSERT INTO t_time VALUES ('21:30', '2016-07-06 10:30:42');
INSERT INTO t_time VALUES ('00:30', '2016-07-07 11:30:42');
INSERT INTO t_time VALUES ('00:31', '2016-07-08 12:30:42');

CREATE TABLE t_time2(t TIME, ts TIMESTAMP, p INTEGER DEFAULT 1);
INSERT INTO t_time2(t, ts) SELECT * FROM t_time;
UPDATE t_time2 SET p=p+1;
INSERT INTO t_time2(t, ts) SELECT * FROM t_time;

-- --sorted_result
-- SELECT p, t, FIRST_VALUE(t) OVER w FROM t_time2 WINDOW w AS (PARTITION by p );

DROP TABLE t_time, t_time2;
CREATE TABLE t11 (id INTEGER, sex CHAR(1), p INTEGER DEFAULT 1);
INSERT INTO t11(id, sex) SELECT * FROM t1;
UPDATE t11 SET p=p+1;
INSERT INTO t11(id, sex) SELECT * FROM t1;
CREATE TABLE t22 (user_id INTEGER NOT NULL, date DATE, p INTEGER DEFAULT 1);
INSERT INTO t22(user_id, date) SELECT * FROM t2;
UPDATE t22 SET p=p+1;
INSERT INTO t22(user_id, date) SELECT * FROM t2;
    WINDOW w AS (ORDER BY user_id), w1 AS (ORDER BY user_id);
    WINDOW w AS (ORDER BY id DESC RANGE 2 PRECEDING);
    WINDOW w AS (PARTITION BY p ORDER BY id DESC RANGE 2 PRECEDING);

update t2 set date=date + user_id;

CREATE TABLE t3(d DOUBLE);
INSERT INTO t3
  VALUES (1.1),(1.9),(4.0),(8.3),(16.0),(24.0),(20.1),(22.0),(23.0);

CREATE TABLE tj(j JSON, i INT DEFAULT 7);
INSERT INTO tj(j) VALUES ('1'), ('2'), ('3'), ('4'), ('5'), (NULL);
INSERT INTO tj(j) VALUES ('3.14');
INSERT INTO tj(j) VALUES ('[1,2,3]');

UPDATE tj SET i=i+CASE WHEN JSON_TYPE(j) = 'ARRAY' THEN 1 ELSE j END;
UPDATE tj SET i=7 where i=8 AND JSON_TYPE(j) != 'ARRAY';

CREATE TABLE tj2 AS SELECT * FROM tj;
UPDATE tj2 SET i=MOD(i,3);

DROP TABLE tj2;
    WINDOW w AS (PARTITION BY i ORDER BY CAST(j AS UNSIGNED) RANGE UNBOUNDED PRECEDING);


DROP TABLE tj;
CREATE TABLE tj(j JSON);
INSERT INTO tj VALUES ('1'), ('2'), ('3'), ('4'), ('5'), (NULL);
INSERT INTO tj VALUES ('3.14');
INSERT INTO tj VALUES ('[1,2,3]');
       JSON_TYPE(j),
       SUM(CASE WHEN JSON_TYPE(j) = 'ARRAY' THEN j->"$[0]" ELSE j END)
         OVER (ORDER BY j ROWS 3 PRECEDING)
  FROM tj;


CREATE TABLE t5(b BIGINT UNSIGNED);
INSERT INTO t5 VALUES (1), (2), (3), (4), (5), (6), (7);

CREATE TABLE t6(t TIME, ts TIMESTAMP);
INSERT INTO t6 VALUES ('12:30', '2016-07-05 08:30:42');
INSERT INTO t6 VALUES ('22:30', '2015-07-05 08:30:43');
INSERT INTO t6 VALUES ('13:30', '2014-07-05 08:30:44');
INSERT INTO t6 VALUES ('01:30', '2013-07-05 08:30:45');
INSERT INTO t6 VALUES ('15:30', '2016-08-05 08:31:42');
INSERT INTO t6 VALUES ('20:30', '2016-09-05 08:32:42');
INSERT INTO t6 VALUES ('04:30', '2016-10-05 08:33:42');
INSERT INTO t6 VALUES ('06:30', '2016-11-05 08:34:42');
INSERT INTO t6 VALUES ('18:30', '2016-07-05 09:30:42');
INSERT INTO t6 VALUES ('21:30', '2016-07-06 10:30:42');
INSERT INTO t6 VALUES ('00:30', '2016-07-07 11:30:42');
INSERT INTO t6 VALUES ('00:31', '2016-07-08 12:30:42');
       COUNT(*) OVER w,
       COUNT(*) OVER w1 FROM t6
   WINDOW w0 AS (),
   w AS (w0 ORDER BY t),
   w1 AS (w RANGE BETWEEN INTERVAL 24 HOUR  PRECEDING AND INTERVAL '2:2' MINUTE_SECOND FOLLOWING);

CREATE VIEW v AS
SELECT COUNT(*) OVER w0,
       COUNT(*) OVER w,
       COUNT(*) OVER w1 FROM t6
   WINDOW w0 AS (),
   w AS (w0 ORDER BY t),
   w1 AS (w RANGE BETWEEN INTERVAL 24 HOUR  PRECEDING AND INTERVAL '2:2' MINUTE_SECOND FOLLOWING);
DROP VIEW v;
           AVG(id) OVER (PARTITION BY id) summ2 FROM t1;
           AVG(id) OVER (PARTITION BY id) summ2 FROM t1;
INSERT INTO t1 VALUES (NULL, 'F');

CREATE TABLE ss(c CHAR(1));
INSERT INTO ss VALUES ('M');
    HAVING sex=(SELECT c FROM ss LIMIT 1)
    WINDOW w AS (ORDER BY id ROWS UNBOUNDED PRECEDING);



DROP TABLE t, t1, t11, t2, t22, t3, t5, t6, tj, ss;

CREATE TABLE t(i INT, j INT, k INT);
INSERT INTO t VALUES (1,1,1),
                     (1,1,2),
                     (1,1,2),
                     (1,2,1),
                     (1,2,2),
                     (2,1,1),
                     (2,1,1),
                     (2,1,2),
                     (2,2,1),
                     (2,2,2);
          RANK() OVER (ORDER BY j) AS O_J,
          RANK() OVER (ORDER BY k,j) AS O_KJ FROM t ORDER BY i,j,k;

DROP TABLE t;

CREATE TABLE t1 (s1 INT, s2 CHAR(5));
INSERT INTO t1 VALUES (1, 'a');
INSERT INTO t1 VALUES (NULL, NULL);
INSERT INTO t1 VALUES (1, NULL);
INSERT INTO t1 VALUES (NULL, 'a');
INSERT INTO t1 VALUES (2, 'b');
INSERT INTO t1 VALUES (-1, '');
  SELECT *,DENSE_RANK() OVER (ORDER BY s2 DESC),
           DENSE_RANK() OVER (ORDER BY s2) FROM t1
           ) alias ORDER BY s1,s2;
  SELECT *, SUM(s1) OVER (ORDER BY s1) FROM t1 ORDER BY s1
         ) alias ORDER BY s1,s2;

DROP TABLE t1;
CREATE TABLE t (a INT, b INT, c INT);
INSERT INTO t VALUES (1,1,1), (1,1,2), (1,1,3),
                     (1,2,1), (1,2,2), (1,2,3),
                     (1,3,1), (1,3,2), (1,3,3),
                     (2,1,1), (2,1,2), (2,1,3),
                     (2,2,1), (2,2,2), (2,2,3),
                     (2,3,1), (2,3,2), (2,3,3);
  SELECT a,b,c, RANK() OVER (ORDER BY 1*1) FROM t
  ) alias ORDER BY a,b,c;
CREATE TABLE u(d INT);
let $query=
SELECT AVG(a * (SELECT a*d FROM u)) OVER
 (PARTITION BY (SELECT a+d FROM u) ORDER BY (SELECT d FROM u)) FROM t;
DROP TABLE u;

DROP TABLE t;
CREATE TABLE t(a int, b int);
INSERT INTO t VALUES (1,1),(2,1),(3,2),(4,2),(5,3),(6,3);
DROP TABLE t;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (1,2),
                      (1,3);
             SUM(a) OVER w sum,
             AVG(a) over w average,
             LAST_VALUE(a) OVER w lastval FROM t1
   WINDOW w as (PARTITION BY a ORDER BY b ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);

INSERT INTO t1 VALUES (1,3);
             SUM(a) OVER w sum,
             AVG(a) OVER w average,
             LAST_VALUE(a) OVER w lastval FROM t1
   WINDOW w as (PARTITION BY a ORDER BY b ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
             SUM(a) OVER w sum,
             AVG(a) OVER w average,
             LAST_VALUE(a) OVER w lastval FROM t1
   WINDOW w as (PARTITION BY a ORDER BY b ROWS BETWEEN 1 PRECEDING AND 2 FOLLOWING);

DROP TABLE t1;
CREATE TABLE ta (a INT(11) DEFAULT NULL, b INT(11) DEFAULT NULL);
INSERT INTO  ta VALUES (1,1), (1,2), (1,3), (2,1), (2,2), (2,3);
DROP TABLE ta;
CREATE TABLE t(d DOUBLE);
INSERT INTO t VALUES (1.0), (2.0), (3.0);
DROP TABLE t;
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
SET windowing_use_high_precision= OFF;
SET windowing_use_high_precision= ON;
DROP TABLE t1;
CREATE TABLE t (i char(10), j int);
INSERT INTO t VALUES('A', 1);
INSERT INTO t VALUES('A', 3);
INSERT INTO t VALUES('A', 5);
INSERT INTO t VALUES('B', 1);
INSERT INTO t VALUES('B', 7);
       WINDOW w AS (PARTITION BY i ORDER BY j
                    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 FOLLOWING);

DROP TABLE t;

CREATE TABLE t1(a int,b int);
CREATE TABLE t2(a int,b int);
INSERT INTO t1 VALUES (0,1);
INSERT INTO t2 VALUES
(2,8),(81,0),(6,7),(8,1),(4,0),(0,2),(6,5),(5,4),(0,6),(9,3),
(5,0),(6,254),(6,0),(2,7),(8,73),(9,7),(3,5),(0,5),(7,75),(2,1);
   SELECT ROW_NUMBER() OVER () AS rn
   FROM ( t1 LEFT JOIN t2 ON (t2.a <= t1 . a ) )
   WHERE t1.a = 3
   GROUP BY t1.a;
DROP TABLE t1,t2;

CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES(1, 1);
let $query=
SELECT t1.a, SUM(t2.b) OVER(ORDER BY t1.a) FROM t1, t1 AS t2 ORDER BY t2.a;
DROP TABLE t1;
CREATE TABLE t(i INT);
INSERT INTO t VALUES
  (2), (3), (1), (5), (8), (4), (6), (2), (10), (16), (4), (6), (2),
  (10), (16), (8), (12), (4), (20), (32), (19), (29), (9), (49), (79),
  (39), (59), (19), (99), (159), (39), (59), (19), (99), (159), (79),
  (119), (39), (199), (319);
SET optimizer_trace="enabled=on";
SELECT ROW_NUMBER() OVER (PARTITION BY i), SUM(i) OVER (ORDER BY i DESC) FROM t GROUP BY i ORDER BY i;
SELECT REGEXP_SUBSTR(TRACE, 'join_optimization.*', 1, 1, 'n') FROM INFORMATION_SCHEMA.OPTIMIZER_TRACE;
SET optimizer_trace="enabled=off";

DROP TABLE t;
