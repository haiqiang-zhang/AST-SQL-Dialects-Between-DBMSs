-- Refer: contrib/cctz-cmake/CMakeLists.txt for the complete list. The count may change but we expect there will be at least 500 timezones.
-- SELECT count(*)
-- FROM system.time_zones
--
-- ÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂcount()ÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂ
-- ÃÂ¢ÃÂÃÂ     594 ÃÂ¢ÃÂÃÂ
-- ÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂÃÂ¢ÃÂÃÂ
SELECT if ((SELECT count(*) FROM system.time_zones) > 500, 'ok', 'fail');
