
SELECT r, count(*)
FROM (SELECT random() r FROM generate_series(1, 1000)) ss
GROUP BY r HAVING count(*) > 1;


SELECT count(*) FILTER (WHERE r < 0 OR r >= 1) AS out_of_range,
       (count(*) FILTER (WHERE r < 0.01)) > 0 AS has_small,
       (count(*) FILTER (WHERE r > 0.99)) > 0 AS has_large
FROM (SELECT random() r FROM generate_series(1, 2000)) ss;


CREATE FUNCTION ks_test_uniform_random()
RETURNS boolean AS
$$
DECLARE
  n int := 1000;        
  c float8 := 1.94947;  
  ok boolean;
BEGIN
  ok := (
    WITH samples AS (
      SELECT random() r FROM generate_series(1, n) ORDER BY 1
    ), indexed_samples AS (
      SELECT (row_number() OVER())-1.0 i, r FROM samples
    )
    SELECT max(abs(i/n-r)) < c / sqrt(n) FROM indexed_samples
  );
  RETURN ok;
END
$$
LANGUAGE plpgsql;

SELECT ks_test_uniform_random() OR
       ks_test_uniform_random() OR
       ks_test_uniform_random() AS uniform;


SELECT r, count(*)
FROM (SELECT random_normal() r FROM generate_series(1, 1000)) ss
GROUP BY r HAVING count(*) > 1;

SELECT r, count(*)
FROM (SELECT random_normal(10, 0) r FROM generate_series(1, 100)) ss
GROUP BY r;
SELECT r, count(*)
FROM (SELECT random_normal(-10, 0) r FROM generate_series(1, 100)) ss
GROUP BY r;


CREATE FUNCTION ks_test_normal_random()
RETURNS boolean AS
$$
DECLARE
  n int := 1000;        
  c float8 := 1.94947;  
  ok boolean;
BEGIN
  ok := (
    WITH samples AS (
      SELECT random_normal() r FROM generate_series(1, n) ORDER BY 1
    ), indexed_samples AS (
      SELECT (row_number() OVER())-1.0 i, r FROM samples
    )
    SELECT max(abs((1+erf(r/sqrt(2)))/2 - i/n)) < c / sqrt(n)
    FROM indexed_samples
  );
  RETURN ok;
END
$$
LANGUAGE plpgsql;

SELECT ks_test_normal_random() OR
       ks_test_normal_random() OR
       ks_test_normal_random() AS standard_normal;


SELECT setseed(0.5);

SELECT random() FROM generate_series(1, 10);

SET extra_float_digits = -1;

SELECT random_normal() FROM generate_series(1, 10);
SELECT random_normal(mean => 1, stddev => 0.1) r FROM generate_series(1, 10);
