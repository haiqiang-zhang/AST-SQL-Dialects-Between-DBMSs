CREATE TABLE FLOAT4_TBL (f1  float4);
INSERT INTO FLOAT4_TBL(f1) VALUES ('    0.0');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1004.30   ');
INSERT INTO FLOAT4_TBL(f1) VALUES ('     -34.84    ');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1.2345678901234e+20');
INSERT INTO FLOAT4_TBL(f1) VALUES ('1.2345678901234e-20');
SELECT pg_input_is_valid('34.5', 'float4');
SELECT * FROM pg_input_error_info('1e400', 'float4');
SELECT 'NaN'::float4;
SELECT 'nan'::float4;
SELECT '   NAN  '::float4;
SELECT 'infinity'::float4;
SELECT '          -INFINiTY   '::float4;
SELECT 'Infinity'::float4 + 100.0;
SELECT 'Infinity'::float4 / 'Infinity'::float4;
SELECT '42'::float4 / 'Infinity'::float4;
SELECT 'nan'::float4 / 'nan'::float4;
SELECT 'nan'::float4 / '0'::float4;
SELECT 'nan'::numeric::float4;
SELECT * FROM FLOAT4_TBL;
SELECT f.* FROM FLOAT4_TBL f WHERE f.f1 <> '1004.3';
SELECT f.* FROM FLOAT4_TBL f WHERE f.f1 = '1004.3';
SELECT f.* FROM FLOAT4_TBL f WHERE '1004.3' > f.f1;
SELECT f.* FROM FLOAT4_TBL f WHERE  f.f1 < '1004.3';
SELECT f.* FROM FLOAT4_TBL f WHERE '1004.3' >= f.f1;
SELECT f.* FROM FLOAT4_TBL f WHERE  f.f1 <= '1004.3';
SELECT f.f1, f.f1 * '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 + '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 / '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';
SELECT f.f1, f.f1 - '-10' AS x FROM FLOAT4_TBL f
   WHERE f.f1 > '0.0';
SELECT * FROM FLOAT4_TBL;
SELECT f.f1, @f.f1 AS abs_f1 FROM FLOAT4_TBL f;
UPDATE FLOAT4_TBL
   SET f1 = FLOAT4_TBL.f1 * '-1'
   WHERE FLOAT4_TBL.f1 > '0.0';
SELECT * FROM FLOAT4_TBL;
SELECT '32767.4'::float4::int2;
SELECT '-32768.4'::float4::int2;
SELECT '2147483520'::float4::int4;
SELECT '-2147483648.5'::float4::int4;
SELECT '9223369837831520256'::float4::int8;
SELECT '-9223372036854775808.5'::float4::int8;
