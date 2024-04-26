
-- This tests:
-- - LIMIT over a recursive CTE
-- - Direct materialization for a derived table containing a query
-- expression with a LIMIT

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

-- LIMIT in non-recursive CTE.

let $query =
WITH cte AS (SELECT * FROM t1 LIMIT 5) SELECT * FROM cte;

-- Add UNION. Non-overlapping rows. Take rows only from first member.

let $query =
WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 5)
SELECT * FROM cte;

-- UNION ALL.
let $query =
WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 5)
SELECT * FROM cte;

-- UNION DISTINCT, take rows from both members.
let $query =
WITH cte AS (SELECT a+20 FROM t1 UNION SELECT a+40 FROM t1 LIMIT 15)
SELECT * FROM cte;

-- The same, spelling out the DISTINCT word

let $query =
WITH cte AS (SELECT a+20 FROM t1 UNION DISTINCT SELECT a+40 FROM t1 LIMIT 15)
SELECT * FROM cte;

let $query =
WITH cte AS (SELECT a+20 FROM t1 UNION ALL SELECT a+40 FROM t1 LIMIT 15)
SELECT * FROM cte;

-- Overlapping rows ('a' and 'a+2' can be same):

let $query =
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15)
SELECT * FROM cte;

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15)
SELECT * FROM cte;

-- With OFFSET.

let $query =
WITH cte AS (SELECT * FROM t1 LIMIT 5 OFFSET 1) SELECT * FROM cte;

let $query =
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1)
SELECT * FROM cte;

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1)
SELECT * FROM cte;

-- With LIMIT/OFFSET in the CTE's body and in the top query.

let $query =
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15 OFFSET 1)
SELECT * FROM cte LIMIT 4 OFFSET 7;

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15 OFFSET 1)
SELECT * FROM cte LIMIT 2 OFFSET 7;

-- Same without OFFSET.

let $query =
WITH cte AS (SELECT a FROM t1 UNION ALL SELECT a+2 FROM t1 LIMIT 15)
SELECT * FROM cte LIMIT 4;

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 15)
SELECT * FROM cte LIMIT 2;

-- Two references to same CTE: verify that LIMIT and OFFSET apply to both.

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8)
 SELECT /*+ no_bnl() */ * FROM cte cte1, cte cte2;

-- Adding a join: verify that LIMIT and OFFSET applies only to CTE.

let $query =
WITH cte AS (SELECT a FROM t1 UNION SELECT a+2 FROM t1 LIMIT 10 OFFSET 8)
SELECT /*+ no_bnl() */ *
FROM cte cte1,
     (SELECT 100 UNION SELECT 101) dt;

-- Recursive CTE.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 5)
SELECT * FROM cte;

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte LIMIT 5)
SELECT * FROM cte;

-- The same, spelling out the DISTINCT word

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION DISTINCT SELECT a+1 FROM cte LIMIT 5)
SELECT * FROM cte;

-- Without LIMIT, it runs away.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a FROM cte)
SELECT * FROM cte;

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION SELECT a+1 FROM cte)
SELECT * FROM cte;

-- With too big LIMIT, it runs away too.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a FROM cte LIMIT 199999)
SELECT * FROM cte;

-- With OFFSET and LIMIT.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL
                       SELECT a+1 FROM cte LIMIT 5 OFFSET 1)
  SELECT * FROM cte;

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION
                       SELECT a+1 FROM cte LIMIT 5 OFFSET 1)
SELECT * FROM cte;

-- With LIMIT/OFFSET in the CTE's body and in the top query.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL
                       SELECT a+1 FROM cte LIMIT 5 OFFSET 1)
  SELECT * FROM cte LIMIT 1 OFFSET 2;

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION
                       SELECT a+1 FROM cte LIMIT 5 OFFSET 1)
SELECT * FROM cte LIMIT 1 OFFSET 2;

-- Same without OFFSET.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL
                       SELECT a+1 FROM cte LIMIT 5)
  SELECT * FROM cte LIMIT 3;

-- Wrong LIMIT value.

let $query =
WITH RECURSIVE cte AS (SELECT 1 AS a UNION ALL SELECT a+1 FROM cte LIMIT 1.3)
SELECT * FROM cte;

DROP TABLE t1;
