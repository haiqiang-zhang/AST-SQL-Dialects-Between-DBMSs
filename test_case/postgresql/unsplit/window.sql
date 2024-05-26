CREATE TEMPORARY TABLE empsalary (
    depname varchar,
    empno bigint,
    salary int,
    enroll_date date
);
INSERT INTO empsalary VALUES
('develop', 10, 5200, '2007-08-01'),
('sales', 1, 5000, '2006-10-01'),
('personnel', 5, 3500, '2007-12-10'),
('sales', 4, 4800, '2007-08-08'),
('personnel', 2, 3900, '2006-12-23'),
('develop', 7, 4200, '2008-01-01'),
('develop', 9, 4500, '2008-01-01'),
('sales', 3, 4800, '2007-08-01'),
('develop', 8, 6000, '2006-10-01'),
('develop', 11, 5200, '2007-08-15');
SELECT depname, empno, salary, sum(salary) OVER (PARTITION BY depname) FROM empsalary ORDER BY depname, salary;
SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary) FROM empsalary;
SELECT sum(salary),
	row_number() OVER (ORDER BY depname),
	sum(sum(salary)) OVER (ORDER BY depname DESC)
FROM empsalary GROUP BY depname;
SELECT sum(salary) OVER w1, count(*) OVER w2
FROM empsalary WINDOW w1 AS (ORDER BY salary), w2 AS (ORDER BY salary);
SELECT sum(salary) OVER w, rank() OVER w FROM empsalary WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);
SELECT empno, depname, salary, bonus, depadj, MIN(bonus) OVER (ORDER BY empno), MAX(depadj) OVER () FROM(
	SELECT *,
		CASE WHEN enroll_date < '2008-01-01' THEN 2008 - extract(YEAR FROM enroll_date) END * 500 AS bonus,
		CASE WHEN
			AVG(salary) OVER (PARTITION BY depname) < salary
		THEN 200 END AS depadj FROM empsalary
)s;
select x, lag(x, 1) over (order by x), lead(x, 3) over (order by x)
from (select x::numeric as x from generate_series(1,10) x);
CREATE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i rows between 1 preceding and 1 following) as sum_rows
	FROM generate_series(1, 10) i;
SELECT * FROM v_window;
SELECT pg_get_viewdef('v_window');
CREATE OR REPLACE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i rows between 1 preceding and 1 following
	exclude current row) as sum_rows FROM generate_series(1, 10) i;
SELECT * FROM v_window;
CREATE OR REPLACE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i rows between 1 preceding and 1 following
	exclude group) as sum_rows FROM generate_series(1, 10) i;
SELECT * FROM v_window;
CREATE OR REPLACE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i rows between 1 preceding and 1 following
	exclude ties) as sum_rows FROM generate_series(1, 10) i;
SELECT * FROM v_window;
CREATE OR REPLACE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i rows between 1 preceding and 1 following
	exclude no others) as sum_rows FROM generate_series(1, 10) i;
SELECT * FROM v_window;
CREATE OR REPLACE TEMP VIEW v_window AS
	SELECT i, sum(i) over (order by i groups between 1 preceding and 1 following) as sum_rows FROM generate_series(1, 10) i;
SELECT * FROM v_window;
DROP VIEW v_window;
CREATE TEMP VIEW v_window AS
	SELECT i, min(i) over (order by i range between '1 day' preceding and '10 days' following) as min_i
  FROM generate_series(now(), now()+'100 days'::interval, '1 hour') i;
select first_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lead(salary) over(order by salary range between 1000 preceding and 1000 following),
	nth_value(salary, 1) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary;
select last_value(salary) over(order by salary range between 1000 preceding and 1000 following),
	lag(salary) over(order by salary range between 1000 preceding and 1000 following),
	salary from empsalary;
select first_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following
	exclude ties),
	last_value(salary) over(order by enroll_date range between unbounded preceding and '1 year'::interval following),
	salary, enroll_date from empsalary;
select x, y,
       first_value(y) over w,
       last_value(y) over w
from
  (select x, x as y from generate_series(1,5) as x
   union all select null, 42
   union all select null, 43) ss
window w as
  (order by x asc nulls first range between 2 preceding and 2 following);
END;
END;
CREATE FUNCTION unbounded(x int) RETURNS int LANGUAGE SQL IMMUTABLE RETURN x;
DROP FUNCTION unbounded;
select x, last_value(x) over (order by x::smallint range between current row and 2147450884 following)
from generate_series(32764, 32766) x;
create temp table numerics(
    id int,
    f_float4 float4,
    f_float8 float8,
    f_numeric numeric
);
insert into numerics values
(0, '-infinity', '-infinity', '-infinity'),
(1, -3, -3, -3),
(2, -1, -1, -1),
(3, 0, 0, 0),
(4, 1.1, 1.1, 1.1),
(5, 1.12, 1.12, 1.12),
(6, 2, 2, 2),
(7, 100, 100, 100),
(8, 'infinity', 'infinity', 'infinity'),
(9, 'NaN', 'NaN', 'NaN');
create temp table datetimes(
    id int,
    f_time time,
    f_timetz timetz,
    f_interval interval,
    f_timestamptz timestamptz,
    f_timestamp timestamp
);
WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following);
WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following);
WITH cte (x) AS (
        SELECT * FROM generate_series(1, 35, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following);
WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x rows between 1 preceding and 1 following);
WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x range between 1 preceding and 1 following);
WITH cte (x) AS (
        select 1 union all select 1 union all select 1 union all
        SELECT * FROM generate_series(5, 49, 2)
)
SELECT x, (sum(x) over w)
FROM cte
WINDOW w AS (ORDER BY x groups between 1 preceding and 1 following);
create temp table t1 (f1 int, f2 int8);
insert into t1 values (1,1),(1,2),(2,2);
explain (costs off)
select f1, sum(f1) over (partition by f1 order by f2
                         range between 1 preceding and 1 following)
from t1 where f1 = f2;
EXPLAIN (COSTS OFF)
SELECT
    empno,
    depname,
    row_number() OVER (PARTITION BY depname ORDER BY enroll_date) rn,
    rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                 UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rnk,
    dense_rank() OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                       CURRENT ROW AND CURRENT ROW) drnk,
    ntile(10) OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                    CURRENT ROW AND UNBOUNDED FOLLOWING) nt,
    percent_rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                         CURRENT ROW AND UNBOUNDED FOLLOWING) pr,
    cume_dist() OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                      CURRENT ROW AND UNBOUNDED FOLLOWING) cd
FROM empsalary;
EXPLAIN (COSTS OFF, VERBOSE)
SELECT
    empno,
    depname,
    row_number() OVER (PARTITION BY depname ORDER BY enroll_date) rn,
    rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                 UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rnk,
    count(*) OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                   CURRENT ROW AND CURRENT ROW) cnt
FROM empsalary;
SELECT
    empno,
    depname,
    row_number() OVER (PARTITION BY depname ORDER BY enroll_date) rn,
    rank() OVER (PARTITION BY depname ORDER BY enroll_date ROWS BETWEEN
                 UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) rnk,
    count(*) OVER (PARTITION BY depname ORDER BY enroll_date RANGE BETWEEN
                   CURRENT ROW AND CURRENT ROW) cnt
FROM empsalary;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT depname,
          sum(salary) OVER (PARTITION BY depname) depsalary,
          min(salary) OVER (PARTITION BY depname || 'A', depname) depminsalary
   FROM empsalary) emp
WHERE depname = 'sales';
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT depname,
          sum(salary) OVER (PARTITION BY enroll_date) enroll_salary,
          min(salary) OVER (PARTITION BY depname) depminsalary
   FROM empsalary) emp
WHERE depname = 'sales';
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3;
SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3;
SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE 3 > rn;
SELECT * FROM
  (SELECT empno,
          row_number() OVER (ORDER BY empno) rn
   FROM empsalary) emp
WHERE 2 >= rn;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          rank() OVER (ORDER BY salary DESC) r
   FROM empsalary) emp
WHERE r <= 3;
SELECT * FROM
  (SELECT empno,
          salary,
          rank() OVER (ORDER BY salary DESC) r
   FROM empsalary) emp
WHERE r <= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          dense_rank() OVER (ORDER BY salary DESC) dr
   FROM empsalary) emp
WHERE dr = 1;
SELECT * FROM
  (SELECT empno,
          salary,
          dense_rank() OVER (ORDER BY salary DESC) dr
   FROM empsalary) emp
WHERE dr = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(empno) OVER (ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
SELECT * FROM
  (SELECT empno,
          salary,
          count(empno) OVER (ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) c
   FROM empsalary) emp
WHERE c >= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER () c
   FROM empsalary) emp
WHERE 11 <= c;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary DESC) c,
          dense_rank() OVER (ORDER BY salary DESC) dr
   FROM empsalary) emp
WHERE dr = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          depname,
          row_number() OVER (PARTITION BY depname ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3;
SELECT * FROM
  (SELECT empno,
          depname,
          row_number() OVER (PARTITION BY depname ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3;
EXPLAIN (COSTS OFF)
SELECT empno, depname FROM
  (SELECT empno,
          depname,
          row_number() OVER (PARTITION BY depname ORDER BY empno) rn
   FROM empsalary) emp
WHERE rn < 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          depname,
          salary,
          count(empno) OVER (PARTITION BY depname ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
SELECT * FROM
  (SELECT empno,
          depname,
          salary,
          count(empno) OVER (PARTITION BY depname ORDER BY salary DESC) c
   FROM empsalary) emp
WHERE c <= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          depname,
          salary,
          count(empno) OVER () c
   FROM empsalary) emp
WHERE c = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT *,
          count(salary) OVER (PARTITION BY depname || '') c1, 
          row_number() OVER (PARTITION BY depname) rn, 
          count(*) OVER (PARTITION BY depname) c2, 
          count(*) OVER (PARTITION BY '' || depname) c3, 
          ntile(2) OVER (PARTITION BY depname) nt 
   FROM empsalary
) e WHERE rn <= 1 AND c1 <= 3 AND nt < 2;
SELECT * FROM
  (SELECT *,
          count(salary) OVER (PARTITION BY depname || '') c1, 
          row_number() OVER (PARTITION BY depname) rn, 
          count(*) OVER (PARTITION BY depname) c2, 
          count(*) OVER (PARTITION BY '' || depname) c3, 
          ntile(2) OVER (PARTITION BY depname) nt 
   FROM empsalary
) e WHERE rn <= 1 AND c1 <= 3 AND nt < 2;
EXPLAIN (COSTS OFF)
SELECT 1 FROM
  (SELECT ntile(e2.salary) OVER (PARTITION BY e1.depname) AS c
   FROM empsalary e1 LEFT JOIN empsalary e2 ON TRUE
   WHERE e1.empno = e2.empno) s
WHERE s.c = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) c
   FROM empsalary) emp
WHERE c <= 3;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(*) OVER (ORDER BY salary) c
   FROM empsalary) emp
WHERE 3 <= c;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count(random()) OVER (ORDER BY empno DESC) c
   FROM empsalary) emp
WHERE c = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT empno,
          salary,
          count((SELECT 1)) OVER (ORDER BY empno DESC) c
   FROM empsalary) emp
WHERE c = 1;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT depname,
          sum(salary) OVER (PARTITION BY depname order by empno) depsalary,
          min(salary) OVER (PARTITION BY depname, empno order by enroll_date) depminsalary
   FROM empsalary) emp
WHERE depname = 'sales';
EXPLAIN (COSTS OFF)
SELECT empno,
       enroll_date,
       depname,
       sum(salary) OVER (PARTITION BY depname order by empno) depsalary,
       min(salary) OVER (PARTITION BY depname order by enroll_date) depminsalary
FROM empsalary
ORDER BY depname, empno;
EXPLAIN (COSTS OFF)
SELECT empno,
       enroll_date,
       depname,
       sum(salary) OVER (PARTITION BY depname order by empno) depsalary,
       min(salary) OVER (PARTITION BY depname order by enroll_date) depminsalary
FROM empsalary
ORDER BY depname, enroll_date;
SET enable_hashagg TO off;
EXPLAIN (COSTS OFF)
SELECT DISTINCT
       empno,
       enroll_date,
       depname,
       sum(salary) OVER (PARTITION BY depname order by empno) depsalary,
       min(salary) OVER (PARTITION BY depname order by enroll_date) depminsalary
FROM empsalary
ORDER BY depname, enroll_date;
EXPLAIN (COSTS OFF)
SELECT DISTINCT
       empno,
       enroll_date,
       depname,
       sum(salary) OVER (PARTITION BY depname order by empno) depsalary,
       min(salary) OVER (PARTITION BY depname order by enroll_date) depminsalary
FROM empsalary
ORDER BY depname, empno;
RESET enable_hashagg;
EXPLAIN (COSTS OFF)
SELECT
  lead(1) OVER (PARTITION BY depname ORDER BY salary, enroll_date),
  lag(1) OVER (PARTITION BY depname ORDER BY salary,enroll_date,empno)
FROM empsalary;
EXPLAIN (COSTS OFF)
SELECT * FROM
  (SELECT depname,
          empno,
          salary,
          enroll_date,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date) AS first_emp,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date DESC) AS last_emp
   FROM empsalary) emp
WHERE first_emp = 1 OR last_emp = 1;
SELECT * FROM
  (SELECT depname,
          empno,
          salary,
          enroll_date,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date) AS first_emp,
          row_number() OVER (PARTITION BY depname ORDER BY enroll_date DESC) AS last_emp
   FROM empsalary) emp
WHERE first_emp = 1 OR last_emp = 1;
DROP TABLE empsalary;
CREATE FUNCTION logging_sfunc_nonstrict(text, anyelement) RETURNS text AS
$$ SELECT COALESCE($1, '') || '*' || quote_nullable($2) $$
LANGUAGE SQL IMMUTABLE;
CREATE FUNCTION logging_msfunc_nonstrict(text, anyelement) RETURNS text AS
$$ SELECT COALESCE($1, '') || '+' || quote_nullable($2) $$
LANGUAGE SQL IMMUTABLE;
CREATE FUNCTION logging_minvfunc_nonstrict(text, anyelement) RETURNS text AS
$$ SELECT $1 || '-' || quote_nullable($2) $$
LANGUAGE SQL IMMUTABLE;
CREATE AGGREGATE logging_agg_nonstrict (anyelement)
(
	stype = text,
	sfunc = logging_sfunc_nonstrict,
	mstype = text,
	msfunc = logging_msfunc_nonstrict,
	minvfunc = logging_minvfunc_nonstrict
);
CREATE AGGREGATE logging_agg_nonstrict_initcond (anyelement)
(
	stype = text,
	sfunc = logging_sfunc_nonstrict,
	mstype = text,
	msfunc = logging_msfunc_nonstrict,
	minvfunc = logging_minvfunc_nonstrict,
	initcond = 'I',
	minitcond = 'MI'
);
CREATE FUNCTION logging_sfunc_strict(text, anyelement) RETURNS text AS
$$ SELECT $1 || '*' || quote_nullable($2) $$
LANGUAGE SQL STRICT IMMUTABLE;
CREATE FUNCTION logging_msfunc_strict(text, anyelement) RETURNS text AS
$$ SELECT $1 || '+' || quote_nullable($2) $$
LANGUAGE SQL STRICT IMMUTABLE;
CREATE FUNCTION logging_minvfunc_strict(text, anyelement) RETURNS text AS
$$ SELECT $1 || '-' || quote_nullable($2) $$
LANGUAGE SQL STRICT IMMUTABLE;
CREATE AGGREGATE logging_agg_strict (text)
(
	stype = text,
	sfunc = logging_sfunc_strict,
	mstype = text,
	msfunc = logging_msfunc_strict,
	minvfunc = logging_minvfunc_strict
);
CREATE AGGREGATE logging_agg_strict_initcond (anyelement)
(
	stype = text,
	sfunc = logging_sfunc_strict,
	mstype = text,
	msfunc = logging_msfunc_strict,
	minvfunc = logging_minvfunc_strict,
	initcond = 'I',
	minitcond = 'MI'
);
SELECT
	p::text || ',' || i::text || ':' || COALESCE(v::text, 'NULL') AS row,
	logging_agg_nonstrict(v) over wnd as nstrict,
	logging_agg_nonstrict_initcond(v) over wnd as nstrict_init,
	logging_agg_strict(v::text) over wnd as strict,
	logging_agg_strict_initcond(v) over wnd as strict_init
FROM (VALUES
	(1, 1, NULL),
	(1, 2, 'a'),
	(1, 3, 'b'),
	(1, 4, NULL),
	(1, 5, NULL),
	(1, 6, 'c'),
	(2, 1, NULL),
	(2, 2, 'x'),
	(3, 1, 'z')
) AS t(p, i, v)
WINDOW wnd AS (PARTITION BY P ORDER BY i ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
ORDER BY p, i;
SELECT
	p::text || ',' || i::text || ':' ||
		CASE WHEN f THEN COALESCE(v::text, 'NULL') ELSE '-' END as row,
	logging_agg_nonstrict(v) filter(where f) over wnd as nstrict_filt,
	logging_agg_nonstrict_initcond(v) filter(where f) over wnd as nstrict_init_filt,
	logging_agg_strict(v::text) filter(where f) over wnd as strict_filt,
	logging_agg_strict_initcond(v) filter(where f) over wnd as strict_init_filt
FROM (VALUES
	(1, 1, true,  NULL),
	(1, 2, false, 'a'),
	(1, 3, true,  'b'),
	(1, 4, false, NULL),
	(1, 5, false, NULL),
	(1, 6, false, 'c'),
	(2, 1, false, NULL),
	(2, 2, true,  'x'),
	(3, 1, true,  'z')
) AS t(p, i, f, v)
WINDOW wnd AS (PARTITION BY p ORDER BY i ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
ORDER BY p, i;
SELECT
	i::text || ':' || COALESCE(v::text, 'NULL') as row,
	logging_agg_strict(v::text)
		over wnd as inverse,
	logging_agg_strict(v::text || CASE WHEN random() < 0 then '?' ELSE '' END)
		over wnd as noinverse
FROM (VALUES
	(1, 'a'),
	(2, 'b'),
	(3, 'c')
) AS t(i, v)
WINDOW wnd AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
ORDER BY i;
SELECT
	i::text || ':' || COALESCE(v::text, 'NULL') as row,
	logging_agg_strict(v::text) filter(where true)
		over wnd as inverse,
	logging_agg_strict(v::text) filter(where random() >= 0)
		over wnd as noinverse
FROM (VALUES
	(1, 'a'),
	(2, 'b'),
	(3, 'c')
) AS t(i, v)
WINDOW wnd AS (ORDER BY i ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
ORDER BY i;
SELECT
	logging_agg_strict(v::text) OVER wnd
FROM (VALUES
	(1, 'a'),
	(2, 'b'),
	(3, 'c')
) AS t(i, v)
WINDOW wnd AS (ORDER BY i ROWS BETWEEN CURRENT ROW AND CURRENT ROW)
ORDER BY i;
CREATE FUNCTION sum_int_randrestart_minvfunc(int4, int4) RETURNS int4 AS
$$ SELECT CASE WHEN random() < 0.2 THEN NULL ELSE $1 - $2 END $$
LANGUAGE SQL STRICT;
CREATE AGGREGATE sum_int_randomrestart (int4)
(
	stype = int4,
	sfunc = int4pl,
	mstype = int4,
	msfunc = int4pl,
	minvfunc = sum_int_randrestart_minvfunc
);
WITH
vs AS (
	SELECT i, (random() * 100)::int4 AS v
	FROM generate_series(1, 100) AS i
),
sum_following AS (
	SELECT i, SUM(v) OVER
		(ORDER BY i DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS s
	FROM vs
)
SELECT DISTINCT
	sum_following.s = sum_int_randomrestart(v) OVER fwd AS eq1,
	-sum_following.s = sum_int_randomrestart(-v) OVER fwd AS eq2,
	100*3+(vs.i-1)*3 = length(logging_agg_nonstrict(''::text) OVER fwd) AS eq3
FROM vs
JOIN sum_following ON sum_following.i = vs.i
WINDOW fwd AS (
	ORDER BY vs.i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
);
SELECT i,AVG(v::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v);
SELECT i,SUM(v::smallint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v);
SELECT SUM(n::numeric) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1.01),(2,2),(3,3)) v(i,n);
SELECT i,COUNT(v) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,1),(2,2),(3,NULL),(4,NULL)) t(i,v);
SELECT VAR_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n);
SELECT VAR_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n);
SELECT VARIANCE(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n);
SELECT STDDEV_POP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n);
SELECT STDDEV_SAMP(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(1,NULL),(2,600),(3,470),(4,170),(5,430),(6,300)) r(i,n);
SELECT STDDEV(n::bigint) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)
  FROM (VALUES(0,NULL),(1,600),(2,470),(3,170),(4,430),(5,300)) r(i,n);
SELECT a, b,
       SUM(b) OVER(ORDER BY A ROWS BETWEEN 1 PRECEDING AND CURRENT ROW)
FROM (VALUES(1,1::numeric),(2,2),(3,'NaN'),(4,3),(5,4)) t(a,b);
SELECT to_char(SUM(n::float8) OVER (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING),'999999999999999999999D9')
  FROM (VALUES(1,1e20),(2,1)) n(i,n);
SELECT i, b, bool_and(b) OVER w, bool_or(b) OVER w
  FROM (VALUES (1,true), (2,true), (3,false), (4,false), (5,true)) v(i,b)
  WINDOW w AS (ORDER BY i ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING);
SELECT array_agg(i) OVER w
  FROM generate_series(1,5) i
WINDOW w AS (ORDER BY i ROWS BETWEEN (('foo' < 'foobar')::integer) PRECEDING AND CURRENT ROW);
CREATE FUNCTION pg_temp.f(group_size BIGINT) RETURNS SETOF integer[]
AS $$
    SELECT array_agg(s) OVER w
      FROM generate_series(1,5) s
    WINDOW w AS (ORDER BY s ROWS BETWEEN CURRENT ROW AND GROUP_SIZE FOLLOWING)
$$ LANGUAGE SQL STABLE;
EXPLAIN (costs off) SELECT * FROM pg_temp.f(2);
SELECT * FROM pg_temp.f(2);
