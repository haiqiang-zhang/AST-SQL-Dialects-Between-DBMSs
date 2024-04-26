
-- Create tables zone tables in test_zone database
CREATE DATABASE test_zone;
USE test_zone;
CREATE TABLE time_zone as SELECT * FROM mysql.time_zone WHERE 1 = 0;
CREATE TABLE time_zone_leap_second as SELECT * FROM mysql.time_zone_leap_second WHERE 1 = 0;
CREATE TABLE time_zone_name as SELECT * FROM mysql.time_zone_name WHERE 1 = 0;
CREATE TABLE time_zone_transition as SELECT * FROM mysql.time_zone_transition WHERE 1 = 0;
CREATE TABLE time_zone_transition_type as SELECT * FROM mysql.time_zone_transition_type WHERE 1 = 0;

-- Load timezone info file with garbage content
--error 1
--exec $MYSQL_TZINFO_TO_SQL $MYSQLTEST_VARDIR/std_data/Factory test_junk_content

-- Cleanup
DROP DATABASE test_zone;
