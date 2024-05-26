SELECT pg_input_is_valid('34', 'int2');
SELECT * FROM pg_input_error_info('50000', 'int2');
SELECT (-1::int2<<15)::text;
SELECT ((-1::int2<<15)+1::int2)::text;
SELECT (-32768)::int2 % (-1)::int2;
SELECT x, x::int2 AS int2_value
FROM (VALUES (-2.5::float8),
             (-1.5::float8),
             (-0.5::float8),
             (0.0::float8),
             (0.5::float8),
             (1.5::float8),
             (2.5::float8)) t(x);
SELECT int2 '0b100101';
SELECT int2 '0o273';
SELECT int2 '0x42F';
SELECT int2 '0b111111111111111';
SELECT int2 '0o77777';
SELECT int2 '0x7FFF';
SELECT int2 '-0b1000000000000000';
SELECT int2 '-0o100000';
SELECT int2 '-0x8000';
SELECT int2 '1_000';
SELECT int2 '1_2_3';
SELECT int2 '0xE_FF';
SELECT int2 '0o2_73';
SELECT int2 '0b_10_0101';
