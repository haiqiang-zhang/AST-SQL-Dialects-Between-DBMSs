SELECT
  (SELECT n
     FROM (VALUES (1)) AS x,
          (SELECT n FROM generate_series(1,10) AS n
             ORDER BY n LIMIT 1 OFFSET s-1) AS y) AS z
  FROM generate_series(1,10) AS s;
create temp sequence testseq;
explain (verbose, costs off)
select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2;
select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2;
explain (verbose, costs off)
select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2
order by s2 desc;
select generate_series(0,2) as s1, generate_series((random()*.1)::int,2) as s2
order by s2 desc;
