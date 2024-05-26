CREATE TEMP TABLE FLOAT8_TBL(f1 float8);
INSERT INTO FLOAT8_TBL(f1) VALUES ('    0.0   ');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1004.30  ');
INSERT INTO FLOAT8_TBL(f1) VALUES ('   -34.84');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1.2345678901234e+200');
INSERT INTO FLOAT8_TBL(f1) VALUES ('1.2345678901234e-200');
SELECT pg_input_is_valid('34.5', 'float8');
SELECT pg_input_is_valid('xyz', 'float8');
SELECT pg_input_is_valid('1e4000', 'float8');
SELECT * FROM pg_input_error_info('1e4000', 'float8');
SELECT 'NaN'::float8;
SELECT 'nan'::float8;
SELECT '   NAN  '::float8;
SELECT 'infinity'::float8;
SELECT '          -INFINiTY   '::float8;
SELECT 'Infinity'::float8 + 100.0;
SELECT 'Infinity'::float8 / 'Infinity'::float8;
SELECT '42'::float8 / 'Infinity'::float8;
SELECT 'nan'::float8 / 'nan'::float8;
SELECT 'nan'::float8 / '0'::float8;
SELECT 'nan'::numeric::float8;
SELECT * FROM FLOAT8_TBL;
SELECT f.* FROM FLOAT8_TBL f WHERE f.f1 <> '1004.3';
SELECT f.* FROM FLOAT8_TBL f WHERE f.f1 = '1004.3';
SELECT f.* FROM FLOAT8_TBL f WHERE '1004.3' > f.f1;
SELECT f.* FROM FLOAT8_TBL f WHERE  f.f1 < '1004.3';
SELECT f.* FROM FLOAT8_TBL f WHERE '1004.3' >= f.f1;
SELECT f.* FROM FLOAT8_TBL f WHERE  f.f1 <= '1004.3';
SELECT f.f1, f.f1 * '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 + '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 / '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 - '-10' AS x
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1 ^ '2.0' AS square_f1
   FROM FLOAT8_TBL f where f.f1 = '1004.3';
SELECT f.f1, @f.f1 AS abs_f1
   FROM FLOAT8_TBL f;
SELECT f.f1, trunc(f.f1) AS trunc_f1
   FROM FLOAT8_TBL f;
SELECT f.f1, round(f.f1) AS round_f1
   FROM FLOAT8_TBL f;
select ceil(f1) as ceil_f1 from float8_tbl f;
select ceiling(f1) as ceiling_f1 from float8_tbl f;
select floor(f1) as floor_f1 from float8_tbl f;
select sign(f1) as sign_f1 from float8_tbl f;
SET extra_float_digits = 0;
SELECT sqrt(float8 '64') AS eight;
SELECT |/ float8 '64' AS eight;
SELECT f.f1, |/f.f1 AS sqrt_f1
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT power(float8 '144', float8 '0.5');
SELECT power(float8 'NaN', float8 '0.5');
SELECT power(float8 '144', float8 'NaN');
SELECT power(float8 'NaN', float8 'NaN');
SELECT power(float8 '-1', float8 'NaN');
SELECT power(float8 '1', float8 'NaN');
SELECT power(float8 'NaN', float8 '0');
SELECT power(float8 'inf', float8 '0');
SELECT power(float8 '-inf', float8 '0');
SELECT power(float8 '0', float8 'inf');
SELECT power(float8 '1', float8 'inf');
SELECT power(float8 '1', float8 '-inf');
SELECT power(float8 '-1', float8 'inf');
SELECT power(float8 '-1', float8 '-inf');
SELECT power(float8 '0.1', float8 'inf');
SELECT power(float8 '-0.1', float8 'inf');
SELECT power(float8 '1.1', float8 'inf');
SELECT power(float8 '-1.1', float8 'inf');
SELECT power(float8 '0.1', float8 '-inf');
SELECT power(float8 '-0.1', float8 '-inf');
SELECT power(float8 '1.1', float8 '-inf');
SELECT power(float8 '-1.1', float8 '-inf');
SELECT power(float8 'inf', float8 '-2');
SELECT power(float8 'inf', float8 '2');
SELECT power(float8 'inf', float8 'inf');
SELECT power(float8 'inf', float8 '-inf');
SELECT power(float8 '-inf', float8 '-2') = '0';
SELECT power(float8 '-inf', float8 '-3');
SELECT power(float8 '-inf', float8 '2');
SELECT power(float8 '-inf', float8 '3');
SELECT power(float8 '-inf', float8 'inf');
SELECT power(float8 '-inf', float8 '-inf');
SELECT f.f1, exp(ln(f.f1)) AS exp_ln_f1
   FROM FLOAT8_TBL f
   WHERE f.f1 > '0.0';
SELECT exp('inf'::float8), exp('-inf'::float8), exp('nan'::float8);
SELECT ||/ float8 '27' AS three;
SELECT f.f1, ||/f.f1 AS cbrt_f1 FROM FLOAT8_TBL f;
SELECT * FROM FLOAT8_TBL;
UPDATE FLOAT8_TBL
   SET f1 = FLOAT8_TBL.f1 * '-1'
   WHERE FLOAT8_TBL.f1 > '0.0';
SELECT 0 ^ 0 + 0 ^ 1 + 0 ^ 0.0 + 0 ^ 0.5;
SELECT * FROM FLOAT8_TBL;
SELECT sinh(float8 '1');
SELECT cosh(float8 '1');
SELECT tanh(float8 '1');
SELECT asinh(float8 '1');
SELECT acosh(float8 '2');
SELECT atanh(float8 '0.5');
SELECT sinh(float8 'infinity');
SELECT sinh(float8 '-infinity');
SELECT sinh(float8 'nan');
SELECT cosh(float8 'infinity');
SELECT cosh(float8 '-infinity');
SELECT cosh(float8 'nan');
SELECT tanh(float8 'infinity');
SELECT tanh(float8 '-infinity');
SELECT tanh(float8 'nan');
SELECT asinh(float8 'infinity');
SELECT asinh(float8 '-infinity');
SELECT asinh(float8 'nan');
SELECT acosh(float8 'nan');
SELECT atanh(float8 'nan');
SET extra_float_digits = -1;
SELECT x,
       erf(x),
       erfc(x)
FROM (VALUES (float8 '-infinity'),
      (-28), (-6), (-3.4), (-2.1), (-1.1), (-0.45),
      (-1.2e-9), (-2.3e-13), (-1.2e-17), (0),
      (1.2e-17), (2.3e-13), (1.2e-9),
      (0.45), (1.1), (2.1), (3.4), (6), (28),
      (float8 'infinity'), (float8 'nan')) AS t(x);
RESET extra_float_digits;
DROP TABLE FLOAT8_TBL;
SELECT '32767.4'::float8::int2;
SELECT '-32768.4'::float8::int2;
SELECT '2147483647.4'::float8::int4;
SELECT '-2147483648.4'::float8::int4;
SELECT '9223372036854773760'::float8::int8;
SELECT '-9223372036854775808.5'::float8::int8;
SELECT x,
       sind(x),
       sind(x) IN (-1,-0.5,0,0.5,1) AS sind_exact
FROM (VALUES (0), (30), (90), (150), (180),
      (210), (270), (330), (360)) AS t(x);
SELECT x,
       cosd(x),
       cosd(x) IN (-1,-0.5,0,0.5,1) AS cosd_exact
FROM (VALUES (0), (60), (90), (120), (180),
      (240), (270), (300), (360)) AS t(x);
SELECT x,
       tand(x),
       tand(x) IN ('-Infinity'::float8,-1,0,
                   1,'Infinity'::float8) AS tand_exact,
       cotd(x),
       cotd(x) IN ('-Infinity'::float8,-1,0,
                   1,'Infinity'::float8) AS cotd_exact
FROM (VALUES (0), (45), (90), (135), (180),
      (225), (270), (315), (360)) AS t(x);
SELECT x,
       asind(x),
       asind(x) IN (-90,-30,0,30,90) AS asind_exact,
       acosd(x),
       acosd(x) IN (0,60,90,120,180) AS acosd_exact
FROM (VALUES (-1), (-0.5), (0), (0.5), (1)) AS t(x);
SELECT x,
       atand(x),
       atand(x) IN (-90,-45,0,45,90) AS atand_exact
FROM (VALUES ('-Infinity'::float8), (-1), (0), (1),
      ('Infinity'::float8)) AS t(x);
SELECT x, y,
       atan2d(y, x),
       atan2d(y, x) IN (-90,0,90,180) AS atan2d_exact
FROM (SELECT 10*cosd(a), 10*sind(a)
      FROM generate_series(0, 360, 90) AS t(a)) AS t(x,y);
