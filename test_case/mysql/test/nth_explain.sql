
SET NAMES utf8mb3;

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
       NTH_VALUE(id, 3) OVER w,
       FIRST_VALUE(id) OVER w,
       NTH_VALUE(id, 1) OVER w,
       NTH_VALUE(id, 2) OVER w FROM t1
  WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);
       NTH_VALUE(id, 3) OVER w,
       FIRST_VALUE(id) OVER w,
       NTH_VALUE(id, 1) OVER w,
       NTH_VALUE(id, 2) OVER w FROM t1
  WINDOW w AS (ORDER BY id ASC ROWS BETWEEN 2 PRECEDING AND CURRENT ROW);

DROP TABLE t1;
