DROP QUOTA IF EXISTS q1_01297, q2_01297, q3_01297, q4_01297, q5_01297, q6_01297, q7_01297, q8_01297, q9_01297,
q10_01297, q11_01297, q12_01297, q13_01297, q14_01297, q15_01297, q16_01297, q17_01297,q18_01297;
DROP QUOTA IF EXISTS q2_01297_renamed;
DROP USER IF EXISTS u1_01297;
DROP ROLE IF EXISTS r1_01297;
SELECT '-- default';
SELECT '-- same as default';
SELECT '-- rename';
SELECT '-- key';
SELECT '-- intervals';
SELECT '-- to roles';
SELECT '-- multiple quotas in one command';
SELECT '-- system.quotas';
SELECT name, storage, keys, durations, apply_to_all, apply_to_list, apply_to_except FROM system.quotas WHERE name LIKE 'q%\_01297' ORDER BY name;
SELECT '-- system.quota_limits';
SELECT * FROM system.quota_limits WHERE quota_name LIKE 'q%\_01297' ORDER BY quota_name, duration;
SELECT '-- query_selects query_inserts';
SELECT '-- size suffix';
SELECT '-- functional test';
DROP QUOTA IF EXISTS q1_01297;
DROP QUOTA IF EXISTS q2_01297;
DROP QUOTA IF EXISTS q3_01297;
DROP QUOTA IF EXISTS q4_01297;
DROP QUOTA IF EXISTS q5_01297;
DROP QUOTA IF EXISTS q6_01297;
DROP QUOTA IF EXISTS q7_01297;
DROP QUOTA IF EXISTS q8_01297;
DROP QUOTA IF EXISTS q9_01297;
DROP QUOTA IF EXISTS q10_01297;
DROP QUOTA IF EXISTS q11_01297;
DROP QUOTA IF EXISTS q12_01297;
DROP QUOTA IF EXISTS q13_01297;
DROP QUOTA IF EXISTS q14_01297;
DROP QUOTA IF EXISTS q15_01297;
DROP QUOTA IF EXISTS q16_01297;
SELECT '-- overflow test';
DROP QUOTA IF EXISTS q1_01297;
DROP QUOTA IF EXISTS q2_01297;
SELECT '-- zero test';
DROP QUOTA IF EXISTS q1_01297;
DROP QUOTA IF EXISTS q2_01297;
SELECT '-- underflow test';
SELECT '-- syntax test';
DROP QUOTA IF EXISTS q1_01297;
DROP QUOTA IF EXISTS q2_01297;
DROP QUOTA IF EXISTS q3_01297;
DROP QUOTA IF EXISTS q4_01297;
DROP QUOTA IF EXISTS q5_01297;
DROP QUOTA IF EXISTS q6_01297;
DROP QUOTA IF EXISTS q7_01297;
DROP QUOTA IF EXISTS q8_01297;
DROP QUOTA IF EXISTS q9_01297;
DROP QUOTA IF EXISTS q10_01297;
SELECT '-- bad syntax test';
