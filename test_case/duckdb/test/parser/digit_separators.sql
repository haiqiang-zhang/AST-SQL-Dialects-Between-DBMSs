PRAGMA enable_verification;
SELECT '1000__000__000'::INT;
SELECT '_1_2'::INT;
SELECT '1_2_'::INT;
SELECT '_12.12'::DECIMAL(4,2);
SELECT '12._12'::DECIMAL(4,2);
SELECT '12_.12'::DECIMAL(4,2);
SELECT '12.12_'::DECIMAL(4,2);
SELECT '1__2.1__2'::FLOAT;
SELECT '_12.12'::FLOAT == 12.12;
SELECT '12._12'::FLOAT == 12.12;
SELECT '12._12e2'::FLOAT == 12.12e2;
SELECT '12_.12'::FLOAT == 12.12;
SELECT '12.12_'::FLOAT == 12.12;
SELECT '12.12_e2'::FLOAT == 12.12e2;
SELECT '_1_000_000_000_000_000_000_000'::DOUBLE == 1e+21;
SELECT '._000_000_000_000_000_000_000_123'::DOUBLE == 123e-23;
SELECT '1_000_000_000_000_000_000_000_'::DOUBLE == 1e+21;
SELECT '.000_000_000_000_000_000_000_123_'::DOUBLE == 123e-23;
select '20e10_'::FLOAT;
select '20e_10'::FLOAT;
select '20e10_'::BIGINT;
select '20e_10'::BIGINT;
SELECT '12e10_'::BIGINT == 12e10::BIGINT;
SELECT '_12e10::BIGINT' == 12e10::BIGINT;
SELECT '0b0_1_0_1_'::INT;
SELECT '0b_0_1_0_1'::INT;
SELECT '0b0__1_0_1'::INT;
SELECT '0x0_F_F_F_'::INT;
SELECT '0x_F_F_F'::INT;
SELECT '0x0__F_F_F'::INT;
SELECT 1_2;
SELECT 1_2.1_2E1_0;
SELECT '1_2.1_2E1_0'::DOUBLE;
SELECT 1__2;
SELECT 1_000_000;
SELECT '1000_000_000'::INT;
SELECT 1_2.1_2;
SELECT 12.1_2;
SELECT 1_2.12;
SELECT '12.1_2'::FLOAT;
SELECT '1_2.12'::FLOAT;
SELECT '12.1_2e2'::FLOAT;
SELECT 1_000_000_000_000_000_000_000::DOUBLE;
SELECT .000_000_000_000_000_000_000_123::DOUBLE;
SELECT 1_000_000_000_000_000_000_000.5::DOUBLE;
SELECT '1_000_000_000.000_000_000_5'::DOUBLE;
SELECT 12e1_0::BIGINT == 12e10::BIGINT;
SELECT '0b01_01'::INT;
SELECT '0b0_1_0_1'::INT;
SELECT '0xFF_FF'::INT;;
SELECT '0xF_F_F_F'::INT;;
SELECT typeof(10.00), typeof(10.0_0), typeof(1_0.00), typeof(1_0.0_0);;
select 1_2e1_0::FLOAT;
select '1_2e1_0'::FLOAT;
select 1_2e1_0::BIGINT;
select '1_2e1_0'::BIGINT;
