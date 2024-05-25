SELECT t.val == t.expected AS ok, * FROM t_leading_zeroes t ORDER BY id;
SELECT t.val == t.expected AS ok, * FROM t_leading_zeroes_f t ORDER BY id;
DROP TABLE IF EXISTS t_leading_zeroes;
DROP TABLE IF EXISTS t_leading_zeroes_f;
