SET allow_experimental_analyzer=1;
SELECT
  sum(t.b) / 1 a,
  sum(t.a)
FROM ( SELECT 1 a, 2 b ) t;
