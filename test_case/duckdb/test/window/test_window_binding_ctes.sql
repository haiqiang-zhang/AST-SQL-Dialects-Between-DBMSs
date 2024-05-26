WITH
  cte_a AS (
    SELECT *
    FROM a
    WINDOW my_window AS ()
  ),
  cte_b AS (
    SELECT *
    FROM a
    WINDOW my_window AS ()
  )
SELECT *
FROM cte_a CROSS JOIN cte_b;
select i, lag(i) over named_window from (values (1), (2), (3)) as t (i) window named_window as (order by i);
with subquery as (select i, lag(i) over named_window from (values (1), (2), (3)) as t (i) window named_window as (order by i)) select * from subquery;
select * from (select i, lag(i) over named_window from (values (1), (2), (3)) as t (i) window named_window as (order by i)) t1;
select * from v1;
SELECT * FROM (SELECT i, lag(i) OVER named_window FROM ( VALUES (1), (2), (3)) AS t (i) window named_window AS ( ORDER BY i)) t1, (SELECT i, lag(i) OVER named_window FROM ( VALUES (1), (2), (3)) AS t (i) window named_window AS ( ORDER BY i)) t2 ORDER BY 1, 2, 3, 4;
