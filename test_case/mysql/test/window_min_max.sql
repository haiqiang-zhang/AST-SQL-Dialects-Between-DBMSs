SELECT i, j, MIN(i) OVER (ROWS UNBOUNDED PRECEDING) min,
      MAX(j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT i, j, MIN(i) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) min,
       MAX(j) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) max FROM t;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j;
SELECT i, j, MAX(i+j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min,
      MAX(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT i, j, MIN(j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min,
       MAX(i) OVER (ORDER BY i ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j;
SELECT i, j, MIN(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ORDER BY j ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC;
SELECT i, j, MAX(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) max FROM t ORDER BY j DESC;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY NULL DESC;
SELECT i, j, MIN(i+j) OVER (ROWS UNBOUNDED PRECEDING) min FROM t ORDER BY j DESC LIMIT 3;
CREATE VIEW v AS
SELECT i, j, MIN(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) min,
      MAX(i+j) OVER (ORDER BY j DESC ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT * FROM v;
DROP VIEW v;
INSERT INTO t VALUES (999961560, DEFAULT);
INSERT INTO t VALUES (44721, DEFAULT);
SELECT MIN(i) OVER () FROM t;
SELECT MAX(i) OVER () FROM t;
DROP TABLE t;
CREATE TABLE t(i INT, j INT, k INT);
INSERT INTO t VALUES (1,1,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,2,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,4,1);
INSERT INTO t VALUES (1,1,2);
INSERT INTO t VALUES (1,4,2);
INSERT INTO t VALUES (1,2,2);
INSERT INTO t VALUES (1,4,2);
INSERT INTO t VALUES (1,1,3);
INSERT INTO t VALUES (1,4,3);
INSERT INTO t VALUES (1,2,3);
INSERT INTO t VALUES (1,4,3);
INSERT INTO t VALUES (1,1,4);
INSERT INTO t VALUES (1,4,4);
INSERT INTO t VALUES (1,2,4);
INSERT INTO t VALUES (1,4,4);
SELECT k, MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min,
      MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k);
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t GROUP BY (k);
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t GROUP BY (k) ORDER BY min_wf DESC;
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t GROUP BY (k) ORDER BY max_wf DESC;
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min,
      MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, AVG(DISTINCT j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min,
      MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k+1) OVER (ROWS UNBOUNDED PRECEDING) min FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MAX(k+1) OVER (ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MIN(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) min FROM t GROUP BY (k);
SELECT k, GROUP_CONCAT(j ORDER BY j), MAX(k+1) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) max FROM t GROUP BY (k);
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M');
INSERT INTO t1 VALUES (2, 'F');
INSERT INTO t1 VALUES (3, 'F');
INSERT INTO t1 VALUES (4, 'F');
INSERT INTO t1 VALUES (5, 'M');
INSERT INTO t1 VALUES (10, NULL);
INSERT INTO t1 VALUES (11, NULL);
CREATE TABLE ss(c CHAR(1));
INSERT INTO ss VALUES ('M');
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max FROM t1
    GROUP BY sex HAVING sex='M' OR sex='F' OR sex IS NULL
    WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max FROM t1
    GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL
    WINDOW w AS (ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1
    GROUP BY sex
    WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, AVG(id), MIN(AVG(id)) OVER w min, MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1
    GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL
    WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC;
SELECT sex, NTILE(2) OVER w , MIN(ASCII(sex)) OVER w min,
MAX(ASCII(sex)) OVER w max FROM t1
HAVING sex=(SELECT c FROM ss LIMIT 1)
  WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING);
PREPARE p FROM "SELECT sex, AVG(id), MIN(AVG(id)) OVER w min,
        MAX(AVG(id)) OVER w max, NTILE(2) OVER w FROM t1
    GROUP BY sex HAVING sex=(SELECT c FROM ss LIMIT 1) OR sex='F' OR sex IS NULL
    WINDOW w AS (ORDER BY sex ROWS UNBOUNDED PRECEDING) ORDER BY sex DESC";
DROP PREPARE p;
DROP TABLE t1,ss;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t
GROUP BY (k) WITH ROLLUP;
SELECT k, MIN(i), SUM(j), MAX(k) OVER (ROWS UNBOUNDED PRECEDING) max_wf FROM t
GROUP BY (k) WITH ROLLUP;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ORDER BY k DESC ROWS UNBOUNDED PRECEDING) min_wf FROM t
GROUP BY (k) WITH ROLLUP ORDER BY k DESC;
SELECT k, MIN(i), SUM(j), MIN(k) OVER (ROWS UNBOUNDED PRECEDING) min_wf FROM t
GROUP BY k,j WITH ROLLUP;
DROP TABLE t;
CREATE TABLE t3(t3_id INT, k INT);
INSERT INTO t3 VALUES (0, 0);
INSERT INTO t3 VALUES (0, 0);
INSERT INTO t3 VALUES (2, 0);
INSERT INTO t3 VALUES (2, 0);
INSERT INTO t3 VALUES (4, 0);
INSERT INTO t3 VALUES (4, 0);
INSERT INTO t3 VALUES (6, 0);
INSERT INTO t3 VALUES (6, 0);
INSERT INTO t3 VALUES (8, 0);
INSERT INTO t3 VALUES (8, 0);
INSERT INTO t3 VALUES (1, 1);
INSERT INTO t3 VALUES (1, 1);
INSERT INTO t3 VALUES (3, 1);
INSERT INTO t3 VALUES (3, 1);
INSERT INTO t3 VALUES (5, 1);
INSERT INTO t3 VALUES (5, 1);
INSERT INTO t3 VALUES (7, 1);
INSERT INTO t3 VALUES (7, 1);
INSERT INTO t3 VALUES (9, 1);
INSERT INTO t3 VALUES (9, 1);
SELECT t3_id, MIN(t3_id) OVER w min,
              MAX(t3_id) OVER w max,
              CUME_DIST() OVER w c_dist,
              LEAD(t3_id, 2) OVER w lead2,
              NTH_VALUE(t3_id, 3) OVER w nth,
              k FROM t3
       WINDOW w AS (PARTITION BY k ORDER BY t3_id);
SELECT t3_id, MIN(t3_id) OVER w min,
              MAX(t3_id) OVER w max,
              CUME_DIST() OVER w c_dist,
              LEAD(t3_id, 2) OVER w lead2,
              NTH_VALUE(t3_id, 3) OVER w nth,
              k FROM t3
       WINDOW w AS (PARTITION BY k ORDER BY t3_id RANGE UNBOUNDED PRECEDING);
DROP TABLE t3;
CREATE TABLE t(i INT, j INT);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,1);
INSERT INTO t VALUES (1,NULL);
INSERT INTO t VALUES (1,2);
INSERT INTO t VALUES (2,1);
INSERT INTO t VALUES (2,2);
INSERT INTO t VALUES (2,NULL);
INSERT INTO t VALUES (2,NULL);
CREATE TABLE t1 (id INTEGER, sex CHAR(1));
INSERT INTO t1 VALUES (1, 'M');
INSERT INTO t1 VALUES (2, 'F');
INSERT INTO t1 VALUES (3, 'F');
INSERT INTO t1 VALUES (4, 'F');
INSERT INTO t1 VALUES (5, 'M');
CREATE TABLE t2 (user_id INTEGER NOT NULL, date DATE);
INSERT INTO t2 VALUES (1, '2002-06-09');
INSERT INTO t2 VALUES (2, '2002-06-09');
INSERT INTO t2 VALUES (1, '2002-06-09');
INSERT INTO t2 VALUES (3, '2002-06-09');
INSERT INTO t2 VALUES (4, '2002-06-09');
INSERT INTO t2 VALUES (4, '2002-06-09');
INSERT INTO t2 VALUES (5, '2002-06-09');
SELECT t.*, MIN(t.rank) OVER (ROWS UNBOUNDED PRECEDING) min,
       MAX(t.rank) OVER (ROWS UNBOUNDED PRECEDING) max FROM
       (SELECT sex, id, date, ROW_NUMBER() OVER w AS row_no, RANK() OVER w AS `rank` FROM t1,t2
        WHERE t1.id=t2.user_id
        WINDOW w AS (PARTITION BY date ORDER BY id)
       ) AS t;
SELECT t1.*, RANK() OVER (ORDER BY sex) `rank`, MIN(id) OVER (ORDER BY sex,id ROWS UNBOUNDED PRECEDING) min FROM t1;
SELECT t1.*, PERCENT_RANK() OVER (ORDER BY sex) p_rank, MAX(id) OVER (ORDER BY sex,id ROWS UNBOUNDED PRECEDING) max FROM t1;
SELECT t1.*, CUME_DIST() OVER (ORDER BY sex) c_dist, MIN(id) OVER (ORDER BY sex,id ROWS UNBOUNDED PRECEDING) min FROM t1;
SELECT * from (SELECT t1.*, MIN(id) OVER (ROWS UNBOUNDED PRECEDING) min, RANK() OVER (ORDER BY sex) `rank` FROM t1) alias ORDER BY id;
SELECT * from (SELECT t1.*, MAX(id) OVER (ROWS UNBOUNDED PRECEDING) max, PERCENT_RANK() OVER (ORDER BY sex) p_rank FROM t1) alias ORDER BY id;
SELECT * from (SELECT t1.*, MAX(id) OVER (ROWS UNBOUNDED PRECEDING) max, CUME_DIST() OVER (ORDER BY sex) c_dist FROM t1) alias ORDER BY id;
SELECT t1.*, MIN(id) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) min,
       MAX(id) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) max,
       RANK() OVER (ORDER BY sex,id) `rank`,
       ROW_NUMBER() OVER (ORDER BY sex,id) row_num
  FROM t1;
SELECT t.*, MIN(id + r00 + r01) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) AS min,
            MAX(id + r00 + r01) OVER (ORDER BY id ROWS UNBOUNDED PRECEDING) AS max FROM (
   SELECT t1.*,
       RANK() OVER (ORDER BY sex, id) AS r00,
       RANK() OVER (ORDER BY sex, id DESC) AS r01,
       RANK() OVER (ORDER BY sex, id DESC) AS r02,
       RANK() OVER (PARTITION BY id ORDER BY sex) AS r03,
       RANK() OVER (ORDER BY sex,id) AS r04,
       RANK() OVER (ORDER BY sex,id) AS r05,
       RANK() OVER (ORDER BY sex, id) AS r06,
       RANK() OVER (ORDER BY sex, id) AS r07,
       RANK() OVER (ORDER BY sex, id) AS r08,
       RANK() OVER (ORDER BY sex, id) AS r09,
       RANK() OVER (ORDER BY sex, id) AS r10,
       RANK() OVER (ORDER BY sex, id) AS r11,
       RANK() OVER (ORDER BY sex, id) AS r12,
       RANK() OVER (ORDER BY sex, id) AS r13,
       RANK() OVER (ORDER BY sex, id) AS r14
       FROM t1) t;
DROP TABLE t;
SELECT AVG(id) OVER w, MIN(id) OVER w min, MAX(id) OVER w max FROM t1
       WINDOW w AS (PARTITION BY sex);
SELECT * FROM (
SELECT id, SUM(id) OVER w, MIN(id) OVER w min, MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex)
       ) alias ORDER BY id;
SELECT MIN(id) OVER w min FROM t1 WINDOW w AS (PARTITION BY sex);
SELECT MAX(id) OVER w max FROM t1 WINDOW w AS (PARTITION BY sex);
SELECT id, MIN(id) OVER w min, MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
CREATE VIEW v AS
SELECT id, SUM(id) OVER w, MIN(id) OVER w min, MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT * FROM v;
DROP VIEW v;
SELECT SUM(id) OVER w, MIN(id) OVER w min,
       MAX(id) OVER w max FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT id, SUM(id) OVER w, MIN(id) OVER w min,
       MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT SUM(id) OVER w, COUNT(*) OVER w, MIN(id) OVER w min,
      MAX(id) OVER w max FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, AVG(id) OVER (ROWS UNBOUNDED PRECEDING) avg,
       MIN(id) OVER (ROWS UNBOUNDED PRECEDING) min FROM t1;
SELECT id, AVG(id) OVER (ROWS UNBOUNDED PRECEDING),
       MAX(id) OVER (ROWS UNBOUNDED PRECEDING) max FROM t1;
SELECT id, AVG(id) OVER w avg, COUNT(id) OVER w count, MIN(id) OVER w min,
       MAX(id) OVER w max FROM t1
       WINDOW w AS (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING);
CREATE TABLE td(d DOUBLE);
INSERT INTO td VALUES (2);
INSERT INTO td VALUES (2);
INSERT INTO td VALUES (3);
INSERT INTO td VALUES (1);
INSERT INTO td VALUES (1.2);
INSERT INTO td VALUES (NULL);
SELECT d, MIN(d) OVER (ORDER BY d) min, MAX(d) OVER (ORDER BY d) max FROM td;
SELECT d, MIN(d) OVER () min, MAX(d) OVER () max FROM td;
SELECT d, MIN(d) OVER (ORDER BY d ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) min FROM td;
SELECT d, MAX(d) OVER (ORDER BY d ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING) max FROM td;
INSERT INTO td VALUES (10);
INSERT INTO td VALUES (1);
INSERT INTO td VALUES (2);
INSERT INTO td VALUES (3);
INSERT INTO td VALUES (4);
INSERT INTO td VALUES (5);
INSERT INTO td VALUES (6);
INSERT INTO td VALUES (7);
INSERT INTO td VALUES (8);
INSERT INTO td VALUES (9);
SELECT d, MIN(d) OVER w min, MAX(d) OVER w max FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN 2 PRECEDING AND CURRENT ROW);
SELECT d, SUM(d) OVER w sum, MIN(d) OVER w min, MAX(d) OVER w max FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w sum, MIN(d) OVER w min, MAX(d) OVER w max FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING);
INSERT INTO td SELECT * FROM td;
SELECT d, SUM(d) OVER w sum, MAX(d) OVER w max, MIN(d) OVER w min FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN 2 PRECEDING AND CURRENT ROW);
SELECT d, SUM(d) OVER w sum, MAX(d) OVER w max, MIN(d) OVER w min FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN 2 PRECEDING AND 2 FOLLOWING);
SELECT d, SUM(d) OVER w sum, MAX(d) OVER w max, MIN(d) OVER w min FROM td
  WINDOW w AS (ORDER BY d RANGE BETWEEN CURRENT ROW AND 2 FOLLOWING);
DROP TABLE td;
SELECT ROW_NUMBER() OVER w `row_number`, id, MIN(id) OVER w min, MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);
SELECT ROW_NUMBER() OVER w `row_number`, MIN(id) OVER w min,
      MAX(id) OVER w max FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
INSERT INTO t1 VALUES (10, NULL);
SELECT RANK() OVER w `rank`, id, MIN(id) OVER w min, MAX(id) OVER w max, sex FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id);
SELECT RANK() OVER w `rank`, MIN(id) OVER w min,
       MAX(id) OVER w max FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id
                    ROWS BETWEEN 1 FOLLOWING AND 2 FOLLOWING);
SELECT id, sex, MIN(id) OVER w min,
                MAX(id) OVER w max,
                ROW_NUMBER() OVER w `row_number`,
                RANK() OVER w  `rank` FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
SELECT id, sex, MIN(id) OVER w min,
                MAX(id) OVER w max,
                ROW_NUMBER() OVER w `row_number`,
                CUME_DIST() OVER w  `cume_dist` FROM t1
       WINDOW w AS (PARTITION BY sex ORDER BY id ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING);
CREATE TABLE t11 (id INTEGER, sex CHAR(1), p INTEGER DEFAULT 1);
INSERT INTO t11(id, sex) SELECT * FROM t1;
UPDATE t11 SET p=p+1;
INSERT INTO t11(id, sex) SELECT * FROM t1;
CREATE TABLE t22 (user_id INTEGER NOT NULL, date DATE, p INTEGER DEFAULT 1);
INSERT INTO t22(user_id, date) SELECT * FROM t2;
UPDATE t22 SET p=p+1;
INSERT INTO t22(user_id, date) SELECT * FROM t2;
SELECT id, MIN(id) OVER (ORDER BY id RANGE 2 PRECEDING) min FROM t1 ORDER BY id;
SELECT id, MIN(id) OVER (ORDER BY id RANGE 2 PRECEDING) max FROM t1 ORDER BY id;
SELECT id, MIN(id) OVER (ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) min FROM t1 ORDER BY id;
SELECT id, MAX(id) OVER (ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) max FROM t1 ORDER BY id;
SELECT id, MIN(id) OVER (ORDER BY id RANGE UNBOUNDED PRECEDING) min FROM t1 ORDER BY id;
SELECT id, MAX(id) OVER (ORDER BY id RANGE UNBOUNDED PRECEDING) max FROM t1 ORDER BY id;
SELECT p, id, MIN(id) OVER (PARTITION BY p ORDER BY id RANGE 2 PRECEDING) min FROM t11 ORDER BY p,id;
SELECT p, id, MAX(id) OVER (PARTITION BY p ORDER BY id RANGE 2 PRECEDING) max FROM t11 ORDER BY p,id;
SELECT p, id, MIN(id) OVER (PARTITION BY p ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) min FROM t11 ORDER BY p,id;
SELECT p, id, MAX(id) OVER (PARTITION BY p ORDER BY id RANGE BETWEEN 1 PRECEDING AND 1 FOLLOWING) max FROM t11 ORDER BY p,id;
SELECT p, id, MIN(id) OVER (PARTITION BY p ORDER BY id RANGE UNBOUNDED PRECEDING) min FROM t11 ORDER BY p,id;
SELECT p, id, MAX(id) OVER (PARTITION BY p ORDER BY id RANGE UNBOUNDED PRECEDING) max FROM t11 ORDER BY p,id;
SELECT user_id, MIN(user_id) OVER w, MAX(user_id) OVER w FROM t2 WINDOW w AS (ORDER BY user_id);
SELECT p, user_id, MIN(user_id) OVER w, MAX(user_id) OVER w FROM t22 WINDOW w AS (PARTITION BY p ORDER BY user_id) ORDER BY p;
SELECT user_id, MIN(user_id) OVER w, MAX(user_id) OVER w1 FROM t2
    WINDOW w AS (ORDER BY user_id), w1 AS (ORDER BY user_id);
SELECT NTILE(5) OVER w, ROW_NUMBER() OVER w, id, MIN(id) OVER w FROM t1
    WINDOW w AS (ORDER BY id DESC RANGE 2 PRECEDING);
SELECT p, NTILE(5) OVER w, ROW_NUMBER() OVER w, id, MAX(id) OVER w FROM t11
    WINDOW w AS (PARTITION BY p ORDER BY id DESC RANGE 2 PRECEDING);
DROP TABLE t11,t22,t1,t2;
CREATE TABLE t3(d DOUBLE);
INSERT INTO t3 VALUES (1.1);
INSERT INTO t3 VALUES (1.9);
INSERT INTO t3 VALUES (4.0);
INSERT INTO t3 VALUES (8.3);
INSERT INTO t3 VALUES (16.0);
INSERT INTO t3 VALUES (24.0);
INSERT INTO t3 VALUES (20.1);
INSERT INTO t3 VALUES (22.0);
INSERT INTO t3 VALUES (23.0);
SELECT d, MIN(d) OVER w min, MAX(d) OVER w max, COUNT(*) OVER w
FROM t3 WINDOW w AS (ORDER BY d RANGE BETWEEN 2.1 PRECEDING AND 1.1 FOLLOWING);
DROP TABLE t3;
CREATE TABLE tj(j JSON, i INT DEFAULT 7);
INSERT INTO tj(j) VALUES ('1');
INSERT INTO tj(j) VALUES ('2');
INSERT INTO tj(j) VALUES ('3');
INSERT INTO tj(j) VALUES ('4');
INSERT INTO tj(j) VALUES ('5');
INSERT INTO tj(j) VALUES (NULL);
INSERT INTO tj(j) VALUES ('3.14');
INSERT INTO tj(j) VALUES ('[1,2,3]');
INSERT INTO tj(j) VALUES (NULL);
SELECT MIN(j) OVER () AS JSON FROM tj;
SELECT j, JSON_TYPE(j), MIN(j) OVER (ORDER BY j ROWS 3 PRECEDING) FROM tj;
SELECT j, JSON_TYPE(j), MAX(j) OVER (ORDER BY j ROWS 3 PRECEDING) FROM tj;
INSERT INTO tj(j) VALUES ('3.14');
SELECT j, JSON_TYPE(j), JSON_TYPE(MAX(j) OVER (ORDER BY j ROWS 3 PRECEDING)) FROM tj;
INSERT INTO tj(j) VALUES ('[1,2,3]');
SELECT j,
       JSON_TYPE(j),
       MIN(CASE WHEN JSON_TYPE(j) = 'ARRAY' THEN j->"$[0]" ELSE j END)
         OVER (ORDER BY j ROWS 3 PRECEDING)
  FROM tj;
SELECT DISTINCT i,NTILE(3) OVER (ORDER BY i), MAX(i) OVER (), COUNT(*) OVER () FROM tj ORDER BY NTILE(3) OVER (ORDER BY i);
UPDATE tj SET i=i+CASE WHEN JSON_TYPE(j) = 'ARRAY' THEN 1 ELSE j END;
UPDATE tj SET i=7 where i=8 AND JSON_TYPE(j) != 'ARRAY';
CREATE TABLE tj2 AS SELECT * FROM tj;
UPDATE tj2 SET i=MOD(i,3);
SELECT * FROM tj2;
SELECT          COUNT(*) OVER (), MOD(MIN(i),2) FROM tj2 GROUP BY i;
SELECT DISTINCT COUNT(*) OVER (), MOD(MAX(i),2) FROM tj2 GROUP BY i;
SELECT i, MIN(i) OVER (), MOD(MIN(i),2) FROM tj2 GROUP BY i;
SELECT i, MAX(MAX(i)) OVER (), MAX(i) OVER (ORDER BY i), MOD(MAX(i),2), MAX(i) FROM tj2 GROUP BY i;
SELECT i, MIN(i) OVER (ORDER BY i) FROM tj UNION ALL SELECT i, MIN(i) OVER (ORDER BY i) FROM tj;
SELECT j,CAST(MIN(j) OVER (PARTITION BY i) AS JSON), CAST(MAX(j) OVER () AS JSON) FROM tj;
SELECT j,CAST(MIN(j) OVER (PARTITION BY i ROWS UNBOUNDED PRECEDING) AS JSON), CAST(MAX(j) OVER (PARTITION BY i ROWS UNBOUNDED PRECEDING) AS JSON) FROM tj;
DROP TABLE tj,tj2;
CREATE TABLE t1 (i INTEGER, j INTEGER);
INSERT INTO t1 VALUES (NULL,3),(NULL,3),(NULL,30),(NULL,30),(4,3),
       (2,5),(3,7),(1,10),(5,20),(3,30);
SELECT i, j, MIN(i) OVER (PARTITION BY j ORDER BY i) FROM t1;
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES(1),(1),(1),(1),(NULL),(NULL),(NULL),(NULL);
SELECT a, MAX(a) OVER (ORDER BY a DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) FROM t1;
SELECT a, MAX(a) OVER (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM t1;
SELECT a, MIN(a) OVER (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) FROM t1;
INSERT INTO t1 VALUES (2), (1), (4), (3), (NULL), (NULL), (NULL), (NULL);
SELECT a, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, COUNT(a) OVER w, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, COUNT(a) OVER w, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, COUNT(a) OVER w, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, COUNT(a) OVER w, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, MIN(a) OVER w min, MAX(a) OVER w max FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW);
SELECT a, MIN(a) OVER w min, MAX(a) OVER w max FROM t1 WINDOW w AS (ORDER BY a RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
INSERT INTO t1 VALUES (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL), (NULL);
SELECT a, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, COUNT(a) OVER w, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, COUNT(a) OVER w, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC ROWS BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING);
SELECT a, COUNT(a) OVER w, MAX(a) OVER w, MIN(a) OVER w FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
SELECT a, COUNT(a) OVER w, MIN(a) OVER w                FROM t1 WINDOW w AS (ORDER BY a DESC RANGE BETWEEN 1 PRECEDING AND CURRENT ROW);
DROP TABLE t1;
SELECT MIN(DATE'2000-01-01') OVER () AS c1,
       MIN(TIME'12:00:00') OVER () AS c2,
       MIN(TIMESTAMP'2000-01-01 12:00:00') OVER () AS c3,
       JSON_ARRAY(MIN(CAST('123' AS JSON)) OVER ()) AS c4,
       MIN(DATE'2000-01-01') OVER () = DATE'2000-01-01' AS c5,
       MIN(TIME'12:00:00') OVER () = TIME '12:00:00' AS c6,
       MIN(TIMESTAMP'2000-01-01 12:00:00') OVER () =
         TIMESTAMP'2000-01-01 12:00:00' AS c7;
