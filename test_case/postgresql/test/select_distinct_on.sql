
SELECT DISTINCT ON (string4) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using >, ten using <;

SELECT DISTINCT ON (string4, ten) string4, two, ten
   FROM onek
   ORDER BY string4 using <, two using <, ten using <;

SELECT DISTINCT ON (string4, ten) string4, ten, two
   FROM onek
   ORDER BY string4 using <, ten using >, two using <;

select distinct on (1) floor(random()) as r, f1 from int4_tbl order by 1,2;


EXPLAIN (COSTS OFF)
SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1;

SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1;

EXPLAIN (COSTS OFF)
SELECT DISTINCT ON (four) four,two
   FROM tenk1 WHERE four = 0 ORDER BY 1,2;

EXPLAIN (COSTS OFF)
SELECT DISTINCT ON (four) four,hundred
   FROM tenk1 WHERE four = 0 ORDER BY 1,2;
