

-- TODO: enable these tests when RENAME DATABASE is implemented.
--
-- --disable_warnings
-- drop database if exists testdb1;
-- 
-- create database testdb1 default character set latin2;
-- 
--
-- Bug#19392 Rename Database: Crash if case change
--
-- create database testdb1;

--
-- WL#4030 (Deprecate RENAME DATABASE: replace with ALTER DATABASE <name> UPGRADE)
--

--error ER_PARSE_ERROR
rename database testdb1 to testdb2;
