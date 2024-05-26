SELECT t0.*, t1.* FROM t0 LEFT OUTER JOIN t1 ON t0.a != t1.a
WHERE t1.a > (SELECT COUNT(a) AS cnt FROM t2);
SELECT * FROM t0 LEFT OUTER JOIN t1 on t0.a = t1.a
WHERE t0.a > (SELECT COUNT(a) AS cnt FROM t2);
SELECT t0.*, t1.* FROM (t0 LEFT OUTER JOIN t1 ON t0.a != t1.a) LEFT OUTER JOIN
       (SELECT COUNT(a) AS cnt FROM t2) AS derived
ON TRUE
WHERE t1.a > derived.cnt;
SELECT (SELECT SUM(a) + (SELECT SUM(t1.a) FROM t1) + SUM(t3.a) FROM t2) FROM t3;
SELECT SUM(a), (SELECT SUM(b) FROM t3) scalar FROM t1 HAVING SUM(a) > scalar;
SELECT t1.a, t2.a, t3.a
FROM t1
     LEFT JOIN (SELECT MIN(a) FROM t1) derived_1
     ON TRUE
     LEFT JOIN ( t2
                 LEFT JOIN (SELECT COUNT(*) FROM t1) AS derived_2
                 ON TRUE
                 JOIN t3
                 ON t2.a = derived_2.`COUNT(*)` )
     ON t1.a + derived_1.`MIN(a)` = t3.b;
SELECT a + (SELECT SUM(a) FROM t1) FROM t1;
SELECT (t2.a + derived_1_0.sum_plus_cnt) AS cnt
FROM t2
     LEFT JOIN (SELECT (derived_2_0.tmp_aggr_1 + derived_2_1.count_a) AS sum_plus_cnt
                FROM (SELECT STRAIGHT_JOIN SUM(t1.a) AS tmp_aggr_1 from t1) derived_2_0
                LEFT JOIN (SELECT COUNT(t1.a) AS count_a from t1) derived_2_1
                ON TRUE) derived_1_0
     ON TRUE;
SELECT a + (SELECT SUM(a) + (SELECT COUNT(a) FROM t1)
    FROM (SELECT * from t1) t11) AS cnt FROM t2;
SELECT AVG(a) OVER () AS `avg`,
       a + (SELECT SUM(a) + (SELECT COUNT(a) FROM t1)
    FROM (SELECT * from t1) t11) AS cnt FROM t2;
DROP TABLE t0, t1, t2, t3;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 (a) VALUES (1), (2);
CREATE TABLE t2 SELECT * FROM t1;
SELECT (WITH RECURSIVE dt AS (SELECT t1.a AS a UNION
                              SELECT a+1 FROM dt WHERE a<10)
        SELECT t1.a * CONCAT(COUNT(*), '.', FLOOR(AVG(dt.a)))
        FROM dt) AS subq
FROM t1;
SELECT derived0.cnct AS subq
FROM t1
     LEFT JOIN LATERAL (WITH RECURSIVE dt AS (SELECT t1.a AS a UNION
                                              SELECT (dt.a + 1)
                                              FROM dt WHERE dt.a < 10)
                        SELECT t1.a * CONCAT(COUNT(0), '.', FLOOR(AVG(dt.a))) AS cnct
                        FROM dt) derived0
     ON TRUE;
DROP TABLE t1, t2;
CREATE TABLE t1(i INT);
CREATE TABLE t2(a INT);
CREATE TABLE t3(x INT);
SELECT (
   SELECT (SELECT COUNT(*) FROM t2) +
          (SELECT AVG(a)
           FROM t2
           WHERE t2.a = t3.x) AS aggs
   FROM t1
) AS bignest
FROM t3;
SELECT (
   SELECT (SELECT COUNT(*) FROM t2) AS aggs
   FROM t1
) AS bignest
FROM t3;
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a INT NOT NULL, b SMALLINT);
INSERT INTO t1 VALUES (12,12);
SELECT (SELECT COUNT(*)
        FROM t1
        WHERE a=11725) AS tot,
       IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1
WHERE false;
SELECT (SELECT COUNT(*)
        FROM t1
        WHERE a=11725) +
       IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1
WHERE false;
INSERT INTO t1 VALUES (13, 12);
SELECT DISTINCT (SELECT COUNT(*)
                 FROM t1) +
                IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1
WHERE a > 5
GROUP BY a;
SELECT (SELECT COUNT(*)
        FROM t1) +
       IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1
GROUP BY a LIMIT 1;
SELECT
  (SELECT (SELECT COUNT(*)
           FROM t1) +
          MAX(t1.b) + MIN(t1_outer.a) AS tot
   FROM t1) FROM t1 AS t1_outer;
SELECT (SELECT COUNT(*)
        FROM t1) +
       MAX(b) +
       (SELECT MIN(a) + AVG(top.a) FROM t1)
       AS tot
FROM t1 top;
SELECT (SELECT COUNT(*) + `outer`.a
        FROM t1) +
       IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1 AS `outer`
GROUP BY a;
SELECT (SELECT COUNT(*) + derived_1.d_1 FROM t1) +
        IFNULL(derived_1.`MAX(b)`,0) + 1 + 5 AS mx

FROM (SELECT STRAIGHT_JOIN MAX(outer_t.b) AS `MAX(b)`,
                           outer_t.a AS d_1
      FROM t1 outer_t
      GROUP BY outer_t.a) derived_1;
SELECT (derived_1.`COUNT(*) + outer_t.a` +
        IFNULL(derived_0.`MAX(b)`,0)) + 1 + 5 AS mx
FROM (SELECT STRAIGHT_JOIN MAX(outer_t.b) AS `MAX(b)`,
                           outer_t.a AS d_1
      FROM t1 outer_t
      GROUP BY outer_t.a) derived_0
     LEFT JOIN LATERAL (SELECT (COUNT(0) + derived_0.d_1)
                               AS `COUNT(*) + outer_t.a`
                        FROM t1) derived_1
     ON(true)
WHERE true;
SELECT (SELECT COUNT(*) + MAX(outer_t.b)
        FROM t1) +
       IFNULL(MAX(b),0)+1 + 5 AS mx
FROM t1 AS outer_t
GROUP BY a;
DROP TABLE t1;
CREATE TABLE t1 (
  school_name VARCHAR(45) NOT NULL,
  country     VARCHAR(45) NOT NULL,
  funds_requested FLOAT NOT NULL,
  schooltype  VARCHAR(45) NOT NULL
);
INSERT INTO t1 VALUES ("the school", "USA", 1200, "Human");
DROP TABLE t1;
CREATE TABLE cc (i INT);
INSERT INTO cc VALUES (1);
SELECT (SELECT COUNT(i) FROM cc AS cc_alias
        WHERE (cc.i IN (SELECT cc_alias.i FROM cc))) AS cnt
FROM cc
GROUP BY i;
DROP TABLE cc;
CREATE TABLE t (a INT);
INSERT INTO t VALUES (1);
DROP TABLE t;
CREATE TABLE t1 (a INT NOT NULL, b INT NOT NULL);
CREATE TABLE t2 (c INT NOT NULL, d INT NOT NULL);
CREATE TABLE t3 (e INT NOT NULL);
INSERT INTO t1 VALUES (1,10), (2,10), (1,20), (2,20), (3,20), (2,30), (4,40);
INSERT INTO t2 VALUES (2,10), (2,20), (4,10), (5,10), (3,20), (2,40);
INSERT INTO t3 VALUES (10), (30), (10), (20);
SELECT * FROM t1 AS ta
WHERE ta.a IN (SELECT c FROM t2 AS tb
               WHERE (SELECT MIN(e) FROM t3 as tc
                      WHERE tc.e IS NOT NULL) < SOME(SELECT e FROM t3 as tc
                                                     WHERE ta.b=tc.e));
SELECT SUM(t1.a) + (SELECT SUM(t2.c)
                    FROM t2),
       (SELECT COUNT(t3.e) FROM t3)
FROM t1;
DROP TABLE t1, t2, t3;
CREATE TABLE t1(
  pedcompralote INT NOT NULL,
  pedcompraseq SMALLINT
);
INSERT INTO t1 VALUES (12,12);
CREATE TABLE t2(
  cod INT NOT NULL,
  ped INT,
  PRIMARY KEY (cod),
  KEY ped (ped)
);
INSERT INTO t2 VALUES
  (11724,1779), (11725,1779), (11726,1779), (11727,1779),
  (11728,1779), (11729,1779), (11730,1779), (11731,1779);
SELECT (SELECT COUNT(*)
        FROM t1
        WHERE pedcompralote=11725) AS tot,
       IFNULL(MAX(pedcompraseq),0)+1 AS newcode
FROM t1
WHERE pedcompralote IN (SELECT cod FROM t2 WHERE ped=1779);
DROP TABLE t1, t2;
CREATE TABLE t(i INT DEFAULT 5);
INSERT INTO t VALUES (4);
SELECT ANY_VALUE(i) AS i1,
       (SELECT i FROM t) AS subquery,
       SUM(i) AS summ
FROM t;
SELECT ANY_VALUE(ANY_VALUE(i) + i) AS i1,
       (SELECT i FROM t) AS subquery,
       SUM(i) AS summ
FROM t;
SELECT ANY_VALUE(i) as i2, ANY_VALUE(i) AS i1,
       (SELECT i FROM t) AS subquery,
       SUM(i) AS summ
FROM t;
DROP TABLE t;
CREATE TABLE t1(i int, j int);
CREATE TABLE t2(i int);
INSERT INTO t1 VALUES (1, 10);
INSERT INTO t1 VALUES (1, 20);
INSERT INTO t1 VALUES (1, 30);
INSERT INTO t1 VALUES (2, 11);
INSERT INTO t1 VALUES (2, 20);
INSERT INTO t1 VALUES (2, 30);
INSERT INTO t2 VALUES (25);
SELECT j FROM t1
HAVING j > (SELECT MIN(t2.i) FROM t2);
SELECT i, j FROM t1
GROUP BY i, j
HAVING SUM(j) > (SELECT SUM(t2.i) FROM t2);
SELECT i, j FROM t1
GROUP BY i, j WITH ROLLUP
HAVING SUM(j) > (SELECT SUM(t2.i) FROM t2);
DROP TABLE t1, t2;
CREATE TABLE supplier (
  s_suppkey INT NOT NULL,
  s_nationkey BIGINT NOT NULL,
  PRIMARY KEY (s_suppkey)
);
CREATE TABLE nation (
  n_nationkey INT NOT NULL,
  n_name CHAR(25) DEFAULT NULL,
  PRIMARY KEY (n_nationkey)
);
CREATE TABLE partsupp (
  ps_partkey BIGINT NOT NULL,
  ps_suppkey BIGINT NOT NULL,
  ps_availqty INT DEFAULT NULL,
  ps_supplycost DECIMAL(10,0) DEFAULT NULL,
  PRIMARY KEY (ps_partkey, ps_suppkey)
);
INSERT INTO nation VALUES (1, 'germany'),
                          (2, 'norway'),
                          (3, 'u.k.');
INSERT INTO supplier VALUES (1, 1);
INSERT INTO partsupp VALUES
  (1, 1, 10, 555),
  (2, 1, 1, 2222),
  (3, 1, 300, 700),
  (4, 1, 259, 400),
  (5, 1, 20,  400),
  (6, 1, 1000, 300),
  (7, 1, 30, 700);
SELECT
    ps_partkey,
    SUM(ps_supplycost * ps_availqty) AS value
FROM
    partsupp,
    supplier,
    nation
WHERE
    ps_suppkey = s_suppkey AND
    s_nationkey = n_nationkey AND
    n_name = 'germany'
GROUP BY
    ps_partkey HAVING
        SUM(ps_supplycost * ps_availqty) > (
            SELECT
                SUM(ps_supplycost * ps_availqty) * 0.1
            FROM
                partsupp,
                supplier,
                nation
            WHERE
                ps_suppkey = s_suppkey AND
                s_nationkey = n_nationkey AND
                n_name = 'germany'
        )
ORDER BY value DESC;
DROP TABLE partsupp, nation, supplier;
CREATE TABLE tbl1 (
  login INT NOT NULL,
  numb DECIMAL(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (login),
  KEY numb (numb)
);
CREATE TABLE tbl2 (
  login INT NOT NULL,
  cmd TINYINT NOT NULL,
  nump DECIMAL(15,2) NOT NULL DEFAULT '0.00',
  KEY cmd (cmd),
  KEY login (login)
);
SELECT
t1.login AS tlogin,
  numb -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) as sp
FROM tbl1 t1, tbl2 t2
WHERE t1.login=t2.login
GROUP BY t1.login
LIMIT 5;
SELECT
t1.login AS tlogin,
  numb -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) as sp
FROM tbl1 t1, tbl2 t2
WHERE t1.login=t2.login
GROUP BY t1.login
ORDER BY sp
LIMIT 5;
SELECT
t1.login AS tlogin,
  numb -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) as sp
FROM tbl1 t1, tbl2 t2
WHERE t1.login=t2.login
GROUP BY t1.login
ORDER BY numb - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0)
              - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0)
LIMIT 5;
DROP TABLE tbl1, tbl2;
CREATE TABLE t2 (a INT, b INT);
CREATE TABLE t4 (a INT NOT NULL, b INT NOT NULL);
INSERT INTO t2 VALUES (1, 7), (2, 7), (2,10);
INSERT INTO t4 VALUES (4, 8), (3, 8), (5, 9), (12, 7), (1, 7),
                      (10, 9), (9, 6), (7, 6), (3, 9), (1, 10);
SELECT b, MAX(a) AS ma FROM t4
GROUP BY b HAVING ma < (SELECT MAX(t2.a) FROM t2 WHERE t2.b=t4.b);
DROP TABLE t2, t4;
CREATE TEMPORARY TABLE tmp_digests (
  schema_name VARCHAR(64) DEFAULT NULL,
  digest VARCHAR(64) DEFAULT NULL,
  digest_text LONGTEXT,
  count_star BIGINT UNSIGNED NOT NULL,
  sum_timer_wait BIGINT UNSIGNED NOT NULL,
  min_timer_wait BIGINT UNSIGNED NOT NULL,
  avg_timer_wait BIGINT UNSIGNED NOT NULL,
  max_timer_wait BIGINT UNSIGNED NOT NULL,
  sum_lock_time BIGINT UNSIGNED NOT NULL,
  sum_errors BIGINT UNSIGNED NOT NULL,
  sum_warnings BIGINT UNSIGNED NOT NULL,
  sum_rows_affected BIGINT UNSIGNED NOT NULL,
  sum_rows_sent BIGINT UNSIGNED NOT NULL,
  sum_rows_examined BIGINT UNSIGNED NOT NULL,
  sum_created_tmp_disk_tables BIGINT UNSIGNED NOT NULL,
  sum_created_tmp_tables BIGINT UNSIGNED NOT NULL,
  sum_select_full_join BIGINT UNSIGNED NOT NULL,
  sum_select_full_range_join BIGINT UNSIGNED NOT NULL,
  sum_select_range BIGINT UNSIGNED NOT NULL,
  sum_select_range_check BIGINT UNSIGNED NOT NULL,
  sum_select_scan BIGINT UNSIGNED NOT NULL,
  sum_sort_merge_passes BIGINT UNSIGNED NOT NULL,
  sum_sort_range BIGINT UNSIGNED NOT NULL,
  sum_sort_rows BIGINT UNSIGNED NOT NULL,
  sum_sort_scan BIGINT UNSIGNED NOT NULL,
  sum_no_index_used BIGINT UNSIGNED NOT NULL,
  sum_no_good_index_used BIGINT UNSIGNED NOT NULL,
  sum_cpu_time BIGINT UNSIGNED NOT NULL,
  max_controlled_memory BIGINT UNSIGNED NOT NULL,
  max_total_memory BIGINT UNSIGNED NOT NULL,
  count_secondary BIGINT UNSIGNED NOT NULL,
  first_seen TIMESTAMP NULL DEFAULT NULL,
  last_seen TIMESTAMP NULL DEFAULT NULL,
  quantile_95 BIGINT UNSIGNED NOT NULL,
  quantile_99 BIGINT UNSIGNED NOT NULL,
  quantile_999 BIGINT UNSIGNED NOT NULL,
  query_sample_text longtext,
  query_sample_seen TIMESTAMP NULL DEFAULT NULL,
  query_sample_timer_wait BIGINT UNSIGNED NOT NULL,
  INDEX (schema_name, digest)
) DEFAULT CHARSET=utf8mb4;
CREATE TEMPORARY TABLE tmp_digest_avg_latency_distribution1 (
              cnt BIGINT UNSIGNED NOT NULL,
              avg_us DECIMAL(21,0) NOT NULL,
              PRIMARY KEY (avg_us)
            ) ENGINE=InnoDB;
CREATE TEMPORARY TABLE tmp_digest_avg_latency_distribution2 (
              cnt BIGINT UNSIGNED NOT NULL,
              avg_us DECIMAL(21,0) NOT NULL,
              PRIMARY KEY (avg_us)
            ) ENGINE=InnoDB;
INSERT INTO tmp_digest_avg_latency_distribution1
SELECT COUNT(*) cnt,
       ROUND(avg_timer_wait/1000000) AS avg_us
  FROM tmp_digests
 GROUP BY avg_us;
INSERT INTO tmp_digest_avg_latency_distribution2 SELECT * FROM tmp_digest_avg_latency_distribution1;
CREATE TEMPORARY TABLE tmp_digest_95th_percentile_by_avg_us (
              avg_us decimal(21,0) NOT NULL,
              percentile decimal(46,4) NOT NULL,
              PRIMARY KEY (avg_us)
            ) ENGINE=InnoDB;
INSERT INTO tmp_digest_95th_percentile_by_avg_us
  SELECT s2.avg_us avg_us,
         IFNULL(SUM(s1.cnt)/
                NULLIF((SELECT COUNT(*) FROM tmp_digests), 0), 0) percentile
  FROM tmp_digest_avg_latency_distribution1 AS s1
       JOIN tmp_digest_avg_latency_distribution2 AS s2
       ON s1.avg_us <= s2.avg_us
  GROUP BY s2.avg_us
  HAVING percentile > 0.95
  ORDER BY percentile
  LIMIT 1;
SELECT * from tmp_digest_95th_percentile_by_avg_us;
DROP TEMPORARY TABLE tmp_digest_95th_percentile_by_avg_us;
DROP TEMPORARY TABLE tmp_digest_avg_latency_distribution2;
DROP TEMPORARY TABLE tmp_digest_avg_latency_distribution1;
DROP TEMPORARY TABLE tmp_digests;
CREATE TABLE t1 (col_int_key int, KEY col_int_key (col_int_key));
INSERT INTO t1 VALUES (0),(8),(1),(8);
CREATE TABLE where_subselect_20070
  SELECT table2 .col_int_key AS field1,
        ( SELECT COUNT( col_int_key )
          FROM t1
        )
  FROM t1 AS table1
       JOIN t1 AS table2
       ON table2.col_int_key = table1.col_int_key;
SELECT *
FROM where_subselect_20070
WHERE (field1, ( SELECT COUNT( col_int_key ) FROM t1 )) IN (
  SELECT table2 .col_int_key AS field1,
        ( SELECT COUNT( col_int_key )
          FROM t1
        )
  FROM t1 AS table1
       JOIN t1 AS table2
       ON table2.col_int_key = table1.col_int_key
);
DROP TABLE t1, where_subselect_20070;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1), (1,2), (1,3);
DROP TABLE t1;
CREATE TABLE t1(a DATETIME NOT NULL);
INSERT INTO t1 VALUES ('20060606155555');
PREPARE s FROM
  'SELECT a FROM t1 WHERE a=(SELECT MAX(a) FROM t1) AND (a="20060606155555")';
PREPARE s FROM
  'SELECT a FROM t1 WHERE a=(SELECT MAX(a) FROM t1) AND (a="20060606155555")';
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4);
SELECT (SELECT MIN(a) FROM t1) a, MAX(a) AS mx
FROM t1
WHERE FALSE
HAVING (SELECT MIN(a) FROM t1) > 0;
SELECT MAX(a) AS mx
FROM t1
WHERE FALSE
HAVING (SELECT MIN(a) FROM t1) > 0;
DROP TABLE t1;
CREATE TABLE tab1(pk int PRIMARY KEY);
SELECT *
FROM tab1 AS table1
     LEFT JOIN
     ( tab1 AS table2 JOIN
       tab1 AS table3
       ON 1 <= (SELECT COUNT(pk) FROM tab1) )
     ON 1
WHERE (SELECT MIN(pk) FROM tab1);
DROP TABLE tab1;
CREATE TABLE c2 (col_varchar_key VARCHAR(1));
SELECT alias1.col_varchar_key
FROM c2 AS alias1
HAVING   alias1.col_varchar_key > SOME (SELECT col_varchar_key FROM c2)
ORDER BY alias1.col_varchar_key;
DROP TABLE c2;
CREATE TABLE t1(col_int INT);
SELECT *
FROM ((t1 AS a2
       LEFT JOIN
       t1 AS a1
       ON  1 <= SOME (SELECT COUNT(*) FROM t1))
     LEFT JOIN
     t1
     ON true);
SELECT *
FROM ((t1 AS a2
       LEFT JOIN
       t1 AS a1
       ON  1 <= ALL (SELECT COUNT(*) FROM t1))
     LEFT JOIN
     t1
     ON true);
SELECT *
FROM (t1
      RIGHT JOIN
      (t1 AS a1
       RIGHT JOIN
       t1 AS a2
       ON  1 <= SOME (SELECT COUNT(*) FROM t1))
      ON true);
DROP TABLE t1;
CREATE TABLE t1(pk int PRIMARY KEY);
SELECT t1.pk
 FROM t1 LEFT JOIN ( SELECT t1.pk AS pk
                     FROM t1
                     WHERE (1 <= (SELECT MAX(t1.pk)
                                  FROM t1)) ) alias2
      ON true;
SELECT alias1.pk
FROM t1 AS alias1 LEFT JOIN
       t1 AS alias2 LEFT JOIN
         (SELECT *
          FROM t1
          WHERE 1 <= ANY (SELECT c_sq1_alias1.pk
                          FROM t1 AS c_sq1_alias1 JOIN t1 AS c_sq1_alias2
                               ON TRUE
                         )
         ) AS alias3
       ON TRUE
     ON TRUE;
DROP TABLE t1;
CREATE TABLE X (col_varchar_key VARCHAR(1));
PREPARE prep_stmt FROM
'SELECT col_varchar_key
 FROM (SELECT * FROM X
       WHERE X.col_varchar_key > (SELECT MIN(col_varchar_key)
                                  FROM X)) AS table1';
DROP TABLE X;
CREATE TABLE n(col_int INT);
INSERT INTO n VALUES (1), (2), (3);
SELECT alias2.col_int
FROM (SELECT * FROM n) AS alias1
     JOIN
       (SELECT * FROM n) AS alias2
       JOIN n
       ON alias2.col_int < (SELECT MAX(col_int) FROM n)
     ON TRUE;
DROP TABLE n;
CREATE TABLE x(col_int_key INT);
SELECT table1.col_int_key AS field1
FROM ((SELECT * FROM x
       WHERE col_int_key <= (SELECT SUM(col_int_key)
                             FROM x
                             WHERE col_int_key < @var1)) AS table1
      JOIN
      x AS table2);
SELECT table1.col_int_key AS field1
FROM ((SELECT * FROM x
       WHERE col_int_key <= (SELECT SUM(col_int_key)
                             FROM x
                             WHERE col_int_key < 1)) AS table1
      JOIN
      x AS table2);
DROP TABLE x;
CREATE TABLE t1(col_varchar VARCHAR(1));
SELECT (SELECT COUNT(*)
         FROM t1
         WHERE 1 <> table1.col_varchar)
 FROM ((SELECT a2.*
        FROM (t1 AS a1
              JOIN
              t1 AS a2
              ON (1 <> ( SELECT COUNT(*)
                         FROM t1)))) AS table1
        JOIN
        t1
        ON 1);
DROP TABLE t1;
CREATE TABLE a(i INT);
CREATE TABLE b(i INT);
CREATE TABLE c(i INT);
SELECT *
FROM b
WHERE EXISTS (SELECT *
              FROM (b
                    JOIN
                    (a AS sq1_alias2
                     JOIN
                     c
                     ON (sq1_alias2.i >= (SELECT MAX(i)
                                                FROM b)))
                    ON (6 IN (SELECT i
                              FROM b))));
DROP TABLE a, b, c;
CREATE TABLE n(i INT);
DROP TABLE n;
CREATE TABLE m(pk INT);
CREATE VIEW view_m AS SELECT * FROM m;
PREPARE prep_stmt FROM

'SELECT (SELECT t2.pk FROM (m AS t1
                            JOIN
                            (m AS t2
                             JOIN m AS t3))),
        (SELECT SUM(pk) FROM m),
        MIN(table1.pk)
 FROM (m AS table1 JOIN
       ((view_m AS table2
         JOIN
         m AS table3))
       ON (table3.pk = table2.pk))';
DROP VIEW view_m;
DROP TABLE m;
CREATE TABLE t1(field1 INT, field2 VARCHAR(1));
CREATE TABLE cc1(pk INT NOT NULL,
                 col_varchar_key VARCHAR(1) DEFAULT NULL,
                 PRIMARY KEY (pk));
SELECT COUNT(table1.pk),
       (SELECT MIN(col_varchar_key) FROM cc1 )
FROM (cc1 AS table1
      JOIN (cc1 JOIN
             cc1 AS table3
             ON true)
      ON true)
WHERE (1 <> (SELECT COUNT(*) FROM cc1));
SELECT * from t1;
CREATE TABLE a (
    pk INTEGER
  );
CREATE TABLE bb (
    col_varchar VARCHAR(1)
);
CREATE TABLE cc (
    pk INTEGER,
    col_int INTEGER,
    col_int_key INTEGER,
    col_time TIME,
    col_time_key TIME,
    col_datetime DATETIME,
    col_datetime_key DATETIME,
    col_varchar VARCHAR(1),
    col_varchar_key VARCHAR(1),
    PRIMARY KEY (pk)
);
CREATE INDEX idx_cc_col_varchar_key ON cc(col_varchar_key);
INSERT INTO cc VALUES (1,764578610,1400450503,'04:58:13','15:43:36',
                       '1977-07-20 14:44:30','1998-10-04 17:29:04','0','N');
INSERT INTO cc VALUES (2,-1430323290,761341340,'17:39:46','10:22:47',
                       '2027-06-26 01:50:30','1983-11-11 03:33:36','z','a');
SELECT
  AVG(cc.col_varchar_key),
  (
    SELECT SUM(cc.col_int_key)
    FROM cc,a
  )
FROM cc STRAIGHT_JOIN bb ON bb.col_varchar = cc.col_varchar_key
WHERE cc.col_varchar <> 'w';
DROP TABLE a, bb, cc;
CREATE TABLE n(i INT);
CREATE VIEW view_n AS SELECT * FROM n;
PREPARE p FROM
'SELECT (SELECT MAX(i) FROM n) AS field2,
        COUNT(table1.i) AS field3 ,
        (SELECT AVG(i) FROM n) AS field4
 FROM (n AS table1
       JOIN
       ( view_n AS table2
         JOIN
         n AS table3
         ON true )
       ON (table2.i = table2.i))';
DROP VIEW view_n;
DROP TABLE n;
CREATE TABLE cc (
  pk int NOT NULL AUTO_INCREMENT,
  col_int int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY idx_cc_col_int_key (col_int_key),
  KEY idx_cc_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO cc VALUES
  (1,   1375472775,   262188886, 'I', 'b'),
  (2,  -1851648474,   130471446, 'o', '7'),
  (3,    503688873,   259988235, 'L', 't'),
  (4,    995143874,   -60832670, 'Q', 'K'),
  (5,  -1440599261, -1669741488, 'k', '7'),
  (6,  -1534014276,  1760407196, 'c', 'Z'),
  (7,    808084535,   311457905, 'B', 'j'),
  (8,    731883185,  -571871645, 'd', 'm'),
  (9,   1445888442,  1903365311, 'w', 's'),
  (10,   222313615,  -404576744, 'n', 'V'),
  (11, -1320350569, -1496644593, 'y', 'o'),
  (12,  2033205532,  1376480867, 'x', '4'),
  (13,  -101883317,  -857422791, 'A', '7'),
  (14,   867688302,  1410896813, 'J', 'c'),
  (15, -1961088920, -2019664999, 'v', '1'),
  (16, -1850585486, -1872043099, '1', 'o'),
  (17,  -603486188,   901895823, 'G', 'q'),
  (18, -1381157785, -1613624643, 'Z', 'E'),
  (19,  -270976631,   288433409, 'r', 'Z'),
  (20,  2113722977,   409698731, 'n', 'd');
CREATE VIEW view_cc AS SELECT * FROM cc;
SELECT AVG(table2.col_int) AS field1 ,
       ( SELECT COUNT(subquery1_t1.col_varchar_key ) AS subquery1_field1
         FROM ( cc AS subquery1_t1
                LEFT OUTER JOIN
                ( cc AS subquery1_t2
                  INNER JOIN view_cc AS subquery1_t3
                  ON ( subquery1_t3.col_varchar = subquery1_t2.col_varchar_key ) )
                ON ( subquery1_t3.col_int_key = subquery1_t2.col_int  ) )
         WHERE subquery1_t1.col_varchar_key != subquery1_t2.col_varchar ) AS field2
FROM ( cc AS table1
       STRAIGHT_JOIN
       cc AS table2
       ON ( table1.col_varchar_key = table1.col_varchar_key ) )
WHERE ( table1.pk = 1 ) AND
      ( table1.col_varchar_key = 'D' OR
        table1.col_varchar_key = table1.col_varchar_key) OR
      table1.col_varchar_key < 'O'
ORDER BY table1.col_varchar ASC, field2, field1
LIMIT 1000 OFFSET 2;
DROP VIEW view_cc;
DROP TABLE cc;
CREATE TABLE m(col_int INT);
SELECT MIN(table1.col_int)           AS field1,
       ( SELECT COUNT(col_int )
         FROM m AS t1 )              AS field2,
       AVG(table1.col_int)           AS field4,
       ( SELECT MAX(t1.col_int)
         FROM ( m AS t1 JOIN
                     ( m AS t2
                       JOIN
                       m AS t3 ) ) ) AS field5
FROM ( m AS table1
       JOIN ( ( m AS table2
                JOIN
                ( SELECT COUNT(col_int) FROM m ) AS table3 ) ) );
DROP TABLE m;
CREATE TABLE n(col_int INT);
INSERT INTO n VALUES (1), (2), (3);
CREATE VIEW view_n AS SELECT * FROM n;
DROP VIEW view_n;
CREATE VIEW view_n(col_int2) AS SELECT col_int + 1 FROM n;
DROP VIEW view_n;
DROP TABLE n;
CREATE TABLE c (pk INTEGER AUTO_INCREMENT,
                col_int INT ,
                col_int_key INT ,
                col_varchar VARCHAR(1) ,
                col_varchar_key VARCHAR(1) ,
                PRIMARY KEY(pk));
CREATE INDEX idx_c_col_int_key ON c(col_int_key);
CREATE TABLE cc (pk INTEGER AUTO_INCREMENT,
                 col_int INT ,
                 col_int_key INT ,
                 col_varchar VARCHAR(1) ,
                 col_varchar_key VARCHAR(1) ,
                 PRIMARY KEY(pk));
INSERT INTO cc VALUES (DEFAULT,1750627978,-2052557260,'0','o');
INSERT INTO c values
    (DEFAULT,809266110,-169779076,'C','O'),
    (DEFAULT,3049998,1973362945,'2','O'),
    (DEFAULT,912437770,-1109570817,'W','G'),
    (DEFAULT,-1655291083,-1761323512,'q','9'),
    (DEFAULT,-1276272795,-591291338,'3','O'),
    (DEFAULT,-1297781203,-970713309,'q','r'),
    (DEFAULT,-261602165,-2083959767,'7','O'),
    (DEFAULT,357530836,-746109993,'6','i'),
    (DEFAULT,1553746652,-1607882572,'G','Y'),
    (DEFAULT,-1620551574,381511992,'5','n'),
    (DEFAULT,-1221888549,-1127778040,'l','U'),
    (DEFAULT,1048455957,-1830777487,'U','T'),
    (DEFAULT,-541641553,-1731661529,'A','Q'),
    (DEFAULT,1482963294,-1570976962,'0','s');
SELECT MIN( table2.col_int ) AS field1 ,
       SUM( table2.col_int ) AS field2 ,
       ( SELECT MAX( subquery1_t1.pk ) AS subquery1_field1
         FROM ( cc AS subquery1_t1
                INNER JOIN
                cc AS subquery1_t2
                ON ( subquery1_t2.col_varchar_key =
                     subquery1_t1.col_varchar_key ) ) ) AS field3
FROM ( c AS table1
       RIGHT JOIN
       ( ( cc AS table2
           STRAIGHT_JOIN
           c AS table3
           ON ( table2.pk = table2.col_int ) ) )
       ON ( table2.col_varchar_key = table2.col_varchar AND
            table1.col_int_key > ( SELECT 9 FROM cc ) ) )
WHERE ( EXISTS ( SELECT subquery3_t1.col_int AS subquery3_field1
                  FROM c AS subquery3_t1
                  WHERE subquery3_t1.col_int_key = table1.pk ) ) AND
      table1.col_varchar_key <> table2.col_varchar;
DROP TABLE c, cc;
CREATE TABLE b (
  pk int NOT NULL AUTO_INCREMENT,
  col_int int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY idx_b_col_int_key (col_int_key),
  KEY idx_b_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO b VALUES (1,-1155099828,-1879439976,'N','a');
CREATE TABLE c (
  pk int NOT NULL AUTO_INCREMENT,
  col_int int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY idx_c_col_int_key (col_int_key),
  KEY idx_c_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO c VALUES
  (1,     -3666739,   177583826, 'm', 'j'),
  (2,   1904347123,  1743248268, '2', 'P'),
  (3,   -469827848,  1376980829, 'i', 'A'),
  (4,   1433595053,  1819090851, 'L', 'M'),
  (5,    726547892,  1068584791, 'T', 'j'),
  (6,   1439902652, -1277159531, 'S', 'r'),
  (7,  -1897073668,  -282803609, 'x', '7'),
  (8,   1220936946,   170773463, '8', 'z'),
  (9,   2127527772,  1049703732, 'i', 'y'),
  (10,   673031799,   609105572, 'h', 'a'),
  (11,  -479585417,  1317141227, 'w', 'k'),
  (12,  -688521145,  -684371590, 'S', 'y'),
  (13,     2841986,  -721059140, 'E', 'I'),
  (14,    58615730,   496153244, '2', 'U'),
  (15,  1139572680,  1532132699, '2', 'n'),
  (16,  -842003748,  1189460625, 'I', 'P'),
  (17, -1177191130, -1717792127, 'y', 'n'),
  (18, -1108396995,   313282977, 'N', 'a'),
  (19,  -361562994,   419341930, 'd', 'C'),
  (20,   743792160,   984757597, 'e', '2');
CREATE TABLE cc (
  pk int NOT NULL AUTO_INCREMENT,
  col_int int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY idx_cc_col_int_key (col_int_key),
  KEY idx_cc_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO cc VALUES
  (1,  1375472775,   262188886, 'I', 'b'),
  (2, -1851648474,   130471446, 'o', '7'),
  (3,   503688873,   259988235, 'L', 't'),
  (4,   995143874,   -60832670, 'Q', 'K'),
  (5, -1440599261, -1669741488, 'k', '7'),
  (6, -1534014276,  1760407196, 'c', 'Z'),
  (7,   808084535,   311457905, 'B', 'j'),
  (8,   731883185,  -571871645, 'd', 'm'),
  (9,  1445888442,  1903365311, 'w', 's'),
  (10,  222313615,  -404576744, 'n', 'V'),
  (11,-1320350569, -1496644593, 'y', 'o'),
  (12, 2033205532,  1376480867, 'x', '4'),
  (13, -101883317,  -857422791, 'A', '7'),
  (14,  867688302,  1410896813, 'J', 'c'),
  (15,-1961088920, -2019664999, 'v', '1'),
  (16,-1850585486, -1872043099, '1', 'o'),
  (17, -603486188,   901895823, 'G', 'q'),
  (18,-1381157785, -1613624643, 'Z', 'E'),
  (19, -270976631,   288433409, 'r', 'Z'),
  (20, 2113722977,   409698731, 'n', 'd');
CREATE VIEW  view_cc AS
SELECT cc.col_int_key AS col_int_key,
       cc.col_varchar AS col_varchar,
       cc.col_varchar_key AS col_varchar_key from cc;
DROP VIEW view_cc;
DROP TABLES b, c, cc;
CREATE TABLE t2(a INTEGER);
INSERT INTO t2 VALUES (1), (2), (3), (4), (5), (NULL);
DROP TABLE t1, t2;
CREATE TABLE c (
  pk int NOT NULL AUTO_INCREMENT,
  col_int int DEFAULT NULL,
  col_int_key int DEFAULT NULL,
  col_date date DEFAULT NULL,
  col_date_key date DEFAULT NULL,
  col_time time DEFAULT NULL,
  col_time_key time DEFAULT NULL,
  col_datetime datetime DEFAULT NULL,
  col_datetime_key datetime DEFAULT NULL,
  col_varchar varchar(1) DEFAULT NULL,
  col_varchar_key varchar(1) DEFAULT NULL,
  PRIMARY KEY (pk),
  KEY idx_cc_col_int_key (col_int_key),
  KEY idx_cc_col_date_key (col_date_key),
  KEY idx_cc_col_time_key (col_time_key),
  KEY idx_cc_col_datetime_key (col_datetime_key),
  KEY idx_cc_col_varchar_key (col_varchar_key)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE VIEW view_c AS
SELECT alias1.col_int
FROM ( c AS alias1
       JOIN
       ( ( c AS alias2
           JOIN
           c AS alias3
           ON(1)) )
       ON ( alias2.col_int >= ( SELECT MIN( sq1_alias1.col_int ) AS sq1_field1
                                  FROM ( c AS sq1_alias1, c AS sq1_alias2 ) ) ) )
WHERE (  EXISTS ( ( SELECT sq2_alias1.col_int
                    FROM ( c AS sq2_alias1
                           JOIN
                           c AS sq2_alias2
                           ON ( sq2_alias2.col_int = sq2_alias1.pk ) )) ) );
SELECT * FROM view_c;
DROP VIEW view_c;
DROP TABLE c;
CREATE TABLE t1 (i int);
CREATE TABLE t2 (i int);
SELECT t2.i FROM t2
WHERE ( false ) AND
      ( t2.i  IN ( SELECT t1.i FROM t1
                  WHERE t1.i <= SOME ( SELECT 8 UNION  SELECT 3 ) ) );
DROP TABLE t1, t2;
CREATE TABLE t1 (a int);
INSERT INTO t1 VALUES (1), (2);
SELECT a FROM t1 WHERE (SELECT 1 FROM DUAL WHERE 1=0) IS NULL;
DROP TABLE t1;
CREATE TABLE a (col_varchar_key varchar(1));
SELECT table1.col_varchar_key
FROM ( SELECT sub1_t2.*
       FROM (a
            JOIN
            (a AS sub1_t2)
            ON sub1_t2.col_varchar_key IN (SELECT col_varchar_key FROM a))
       WHERE EXISTS (SELECT sub2_t1.col_varchar_key
                     FROM a AS sub2_t1))  AS table1
     JOIN
     (a AS table2
       JOIN
       a
       ON 1 >= (SELECT MIN( col_varchar_key) FROM a))
     ON true;
DROP TABLE a;
CREATE TABLE t1(pk int primary key);
INSERT INTO t1 VALUES(1),(2),(3),(4),(5);
DROP TABLE t1;
CREATE TABLE t1 ( pk INTEGER );
SELECT
  (SELECT COUNT(*) FROM t1) AS f1,
  (SELECT COUNT(*) FROM t1) AS f2
FROM t1
GROUP BY f1, f2 WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 ( f1 INTEGER);
INSERT INTO t1 VALUES (0);
SELECT (SELECT MIN(f1) AS min FROM t1 ) AS field1 FROM t1 GROUP BY
field1 WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER);
SELECT (SELECT SUM(f1) AS SQ1_field1 FROM t1) as field1
 FROM t1 GROUP BY f1 WITH ROLLUP ORDER BY f1;
DROP TABLE t1;
CREATE TABLE t1 (pk integer auto_increment,
                 col_int int ,
                 col_datetime datetime ,
                 col_char_255 char(255) ,
                 col_smallint smallint ,
                 col_decimal_10_8 decimal(10,8),
                 primary key(pk));
DROP TABLE t1;
CREATE TABLE t1 (f1 INTEGER);
SELECT SUM(f1), ROW_NUMBER() OVER (), (SELECT MIN(f1) FROM t1) FROM t1 ORDER BY f1;
DROP TABLE t1;
CREATE TABLE t(i INT);
INSERT INTO t VALUES (1);
DROP TABLE t;
CREATE TABLE t(x INT);
DROP TABLE t;
CREATE TABLE t(i INT);
INSERT INTO t VALUES (4);
DROP TABLE t;
