SELECT pg_input_is_valid('34', 'int8');
SELECT pg_input_is_valid('asdf', 'int8');
SELECT pg_input_is_valid('10000000000000000000', 'int8');
SELECT * FROM pg_input_error_info('10000000000000000000', 'int8');
select '-9223372036854775808'::int8;
select '9223372036854775807'::int8;
select -('-9223372036854775807'::int8);
SELECT CAST('42'::int2 AS int8), CAST('-37'::int2 AS int8);
SELECT CAST('36854775807.0'::float4 AS int8);
SELECT oid::int8 FROM pg_class WHERE relname = 'pg_class';
SELECT * FROM generate_series('+4567890123456789'::int8, '+4567890123456799'::int8);
SELECT * FROM generate_series('+4567890123456789'::int8, '+4567890123456799'::int8, 2);
SELECT (-1::int8<<63)::text;
SELECT ((-1::int8<<63)+1)::text;
SELECT (-9223372036854775808)::int8 % (-1)::int8;
SELECT (-9223372036854775808)::int8 % (-1)::int4;
SELECT (-9223372036854775808)::int8 % (-1)::int2;
SELECT x, x::int8 AS int8_value
FROM (VALUES (-2.5::float8),
             (-1.5::float8),
             (-0.5::float8),
             (0.0::float8),
             (0.5::float8),
             (1.5::float8),
             (2.5::float8)) t(x);
SELECT x, x::int8 AS int8_value
FROM (VALUES (-2.5::numeric),
             (-1.5::numeric),
             (-0.5::numeric),
             (0.0::numeric),
             (0.5::numeric),
             (1.5::numeric),
             (2.5::numeric)) t(x);
SELECT a, b, gcd(a, b), gcd(a, -b), gcd(b, a), gcd(-b, a)
FROM (VALUES (0::int8, 0::int8),
             (0::int8, 29893644334::int8),
             (288484263558::int8, 29893644334::int8),
             (-288484263558::int8, 29893644334::int8),
             ((-9223372036854775808)::int8, 1::int8),
             ((-9223372036854775808)::int8, 9223372036854775807::int8),
             ((-9223372036854775808)::int8, 4611686018427387904::int8)) AS v(a, b);
SELECT a, b, lcm(a, b), lcm(a, -b), lcm(b, a), lcm(-b, a)
FROM (VALUES (0::int8, 0::int8),
             (0::int8, 29893644334::int8),
             (29893644334::int8, 29893644334::int8),
             (288484263558::int8, 29893644334::int8),
             (-288484263558::int8, 29893644334::int8),
             ((-9223372036854775808)::int8, 0::int8)) AS v(a, b);
SELECT int8 '0b100101';
SELECT int8 '0o273';
SELECT int8 '0x42F';
SELECT int8 '0b111111111111111111111111111111111111111111111111111111111111111';
SELECT int8 '0o777777777777777777777';
SELECT int8 '0x7FFFFFFFFFFFFFFF';
SELECT int8 '-0b1000000000000000000000000000000000000000000000000000000000000000';
SELECT int8 '-0o1000000000000000000000';
SELECT int8 '-0x8000000000000000';
SELECT int8 '1_000_000';
SELECT int8 '1_2_3';
SELECT int8 '0x1EEE_FFFF';
SELECT int8 '0o2_73';
SELECT int8 '0b_10_0101';
