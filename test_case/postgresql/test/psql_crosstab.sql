
CREATE TABLE ctv_data (v, h, c, i, d) AS
VALUES
   ('v1','h2','foo', 3, '2015-04-01'::date),
   ('v2','h1','bar', 3, '2015-01-02'),
   ('v1','h0','baz', NULL, '2015-07-12'),
   ('v0','h4','qux', 4, '2015-07-15'),
   ('v0','h4','dbl', -3, '2014-12-15'),
   ('v0',NULL,'qux', 5, '2014-07-15'),
   ('v1','h2','quux',7, '2015-04-04');

ANALYZE ctv_data;

SELECT v, EXTRACT(year FROM d), count(*)
 FROM ctv_data
 GROUP BY 1, 2
 ORDER BY 1, 2;

SELECT v, to_char(d, 'Mon') AS "month name", EXTRACT(month FROM d) AS num,
 count(*) FROM ctv_data  GROUP BY 1,2,3 ORDER BY 1

SELECT EXTRACT(year FROM d) AS year, to_char(d,'Mon') AS """month"" name",
  EXTRACT(month FROM d) AS month,
  format('sum=%s avg=%s', sum(i), avg(i)::numeric(2,1))
  FROM ctv_data
  GROUP BY EXTRACT(year FROM d), to_char(d,'Mon'), EXTRACT(month FROM d)
ORDER BY month

SELECT v, h, string_agg(c, E'\n') FROM ctv_data GROUP BY v, h ORDER BY 1,2,3

SELECT v,h, string_agg(c, E'\n') AS c, row_number() OVER(ORDER BY h) AS r
FROM ctv_data GROUP BY v, h ORDER BY 1,3,2

SELECT v, h, string_agg(c, E'\n') AS c, row_number() OVER(ORDER BY h DESC) AS r
FROM ctv_data GROUP BY v, h ORDER BY 1,3,2

SELECT v,h, string_agg(c, E'\n') AS c, row_number() OVER(ORDER BY h NULLS LAST) AS r
FROM ctv_data GROUP BY v, h ORDER BY 1,3,2

SELECT null,null \crosstabview

SELECT null,null,null \crosstabview

SELECT v,h, string_agg(i::text, E'\n') AS i FROM ctv_data
GROUP BY v, h ORDER BY h,v

SELECT v,h,string_agg(i::text, E'\n'), string_agg(c, E'\n')
FROM ctv_data GROUP BY v, h ORDER BY h,v

SELECT v,h, string_agg(i::text, E'\n') AS i, string_agg(c, E'\n') AS c
FROM ctv_data GROUP BY v, h ORDER BY h,v

SELECT 1 as "22", 2 as b, 3 as "Foo"

SELECT v,h,c,i FROM ctv_data

SELECT 1 as "22", 2 as b, 3 as "Foo"

SELECT 1 as "22", 2 as b, 3 as "Foo"

SELECT v,h,i,c FROM ctv_data

SELECT v,h,i,c FROM ctv_data

SELECT a,a,1 FROM generate_series(1,3000) AS a

SELECT 1 \crosstabview

DROP TABLE ctv_data;

CREATE TABLE ctv_data (x int, y int, v text);

INSERT INTO ctv_data SELECT 1, x, '*' || x FROM generate_series(1,10) x;
SELECT * FROM ctv_data \crosstabview

INSERT INTO ctv_data VALUES (1, 10, '*'); 
SELECT * FROM ctv_data \crosstabview

DROP TABLE ctv_data;
