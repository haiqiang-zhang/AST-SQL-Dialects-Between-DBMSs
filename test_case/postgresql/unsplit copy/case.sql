CREATE TABLE CASE_TBL (
  i integer,
  f double precision
);
CREATE TABLE CASE2_TBL (
  i integer,
  j integer
);
INSERT INTO CASE_TBL VALUES (1, 10.1);
INSERT INTO CASE_TBL VALUES (2, 20.2);
INSERT INTO CASE_TBL VALUES (3, -30.3);
INSERT INTO CASE_TBL VALUES (4, NULL);
INSERT INTO CASE2_TBL VALUES (1, -1);
INSERT INTO CASE2_TBL VALUES (2, -2);
INSERT INTO CASE2_TBL VALUES (3, -3);
INSERT INTO CASE2_TBL VALUES (2, -4);
INSERT INTO CASE2_TBL VALUES (1, NULL);
INSERT INTO CASE2_TBL VALUES (NULL, -6);
SELECT '3' AS "One",
  CASE
    WHEN 1 < 2 THEN 3
  END AS "Simple WHEN";
SELECT '<NULL>' AS "One",
  CASE
    WHEN 1 > 2 THEN 3
  END AS "Simple default";
SELECT '3' AS "One",
  CASE
    WHEN 1 < 2 THEN 3
    ELSE 4
  END AS "Simple ELSE";
SELECT '4' AS "One",
  CASE
    WHEN 1 > 2 THEN 3
    ELSE 4
  END AS "ELSE default";
SELECT '6' AS "One",
  CASE
    WHEN 1 > 2 THEN 3
    WHEN 4 < 5 THEN 6
    ELSE 7
  END AS "Two WHEN with default";
SELECT '7' AS "None",
   CASE WHEN random() < 0 THEN 1
   END AS "NULL on no matches";
SELECT CASE WHEN 1=0 THEN 1/0 WHEN 1=1 THEN 1 ELSE 2/0 END;
SELECT CASE 1 WHEN 0 THEN 1/0 WHEN 1 THEN 1 ELSE 2/0 END;
SELECT CASE 'a' WHEN 'a' THEN 1 ELSE 2 END;
SELECT
  CASE
    WHEN i >= 3 THEN i
  END AS ">= 3 or Null"
  FROM CASE_TBL;
SELECT
  CASE WHEN i >= 3 THEN (i + i)
       ELSE i
  END AS "Simplest Math"
  FROM CASE_TBL;
SELECT i AS "Value",
  CASE WHEN (i < 0) THEN 'small'
       WHEN (i = 0) THEN 'zero'
       WHEN (i = 1) THEN 'one'
       WHEN (i = 2) THEN 'two'
       ELSE 'big'
  END AS "Category"
  FROM CASE_TBL;
SELECT
  CASE WHEN ((i < 0) or (i < 0)) THEN 'small'
       WHEN ((i = 0) or (i = 0)) THEN 'zero'
       WHEN ((i = 1) or (i = 1)) THEN 'one'
       WHEN ((i = 2) or (i = 2)) THEN 'two'
       ELSE 'big'
  END AS "Category"
  FROM CASE_TBL;
SELECT * FROM CASE_TBL WHERE COALESCE(f,i) = 4;
SELECT * FROM CASE_TBL WHERE NULLIF(f,i) = 2;
SELECT COALESCE(a.f, b.i, b.j)
  FROM CASE_TBL a, CASE2_TBL b;
SELECT *
  FROM CASE_TBL a, CASE2_TBL b
  WHERE COALESCE(a.f, b.i, b.j) = 2;
SELECT NULLIF(a.i,b.i) AS "NULLIF(a.i,b.i)",
  NULLIF(b.i, 4) AS "NULLIF(b.i,4)"
  FROM CASE_TBL a, CASE2_TBL b;
SELECT *
  FROM CASE_TBL a, CASE2_TBL b
  WHERE COALESCE(f,b.i) = 2;
explain (costs off)
SELECT * FROM CASE_TBL WHERE NULLIF(1, 2) = 2;
explain (costs off)
SELECT * FROM CASE_TBL WHERE NULLIF(1, 1) IS NOT NULL;
explain (costs off)
SELECT * FROM CASE_TBL WHERE NULLIF(1, null) = 2;
UPDATE CASE_TBL
  SET i = CASE WHEN i >= 3 THEN (- i)
                ELSE (2 * i) END;
SELECT * FROM CASE_TBL;
UPDATE CASE_TBL
  SET i = CASE WHEN i >= 2 THEN (2 * i)
                ELSE (3 * i) END;
SELECT * FROM CASE_TBL;
UPDATE CASE_TBL
  SET i = CASE WHEN b.i >= 2 THEN (2 * j)
                ELSE (3 * j) END
  FROM CASE2_TBL b
  WHERE j = -CASE_TBL.i;
SELECT * FROM CASE_TBL;
BEGIN;
ROLLBACK;
BEGIN;
CREATE DOMAIN arrdomain AS int[];
ROLLBACK;
BEGIN;
CREATE TYPE casetestenum AS ENUM ('e', 'f', 'g');
SELECT
  CASE 'foo'::text
    WHEN 'foo' THEN ARRAY['a', 'b', 'c', 'd'] || enum_range(NULL::casetestenum)::text[]
    ELSE ARRAY['x', 'y']
    END;
ROLLBACK;
DROP TABLE CASE_TBL;
DROP TABLE CASE2_TBL;
