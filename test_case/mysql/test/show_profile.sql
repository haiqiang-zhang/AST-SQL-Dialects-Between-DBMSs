
--
-- Test for show profiles
-- No meaningful check is possible. 
-- So it only checks that SET profiling is possible and
-- that SHOW PROFILES, SHOW PROFILE FOR QUERY and SHOW PROFILE CPU FOR QUERY
-- do not cause syntax errors. It also increases code coverage for sql_profile.cc

--source include/have_profiling.inc
SET profiling = 1;
SELECT 1;
SET profiling = 0;
