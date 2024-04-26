
-- Escape to perl to locate zoneinfo on this system
perl;
   -- check if whereis command knows zoneinfo location
   system("whereis zoneinfo");
   if ($?==0) {
      @path = split (/\s+/, `whereis zoneinfo`);
   }
}

-- Check that all requires zoneinfo resources are available
if (defined($path[1])) {
   if (-e "$path[1]/Japan") {
      print OUTPUT "let zoneinfo_japan_path = $path[1]/Japan;
   }
   if (-d "$path[1]/Europe") {
      print OUTPUT "let zoneinfo_europe_path = $path[1]/Europe;
   }
   if (-e "$path[1]/right/Europe/Moscow") {
      print OUTPUT "let zoneinfo_leap_moscow_path= $path[1]/right/Europe/Moscow;
   }
}

close (OUTPUT);
EOF

-- Load zoneinfo_path variables
--source  $MYSQLTEST_VARDIR/tmp/zoneinfocheck.inc

--remove_file $MYSQLTEST_VARDIR/tmp/zoneinfocheck.inc

-- Skip test if any required zoneinfo resources are unavailable
if (!$zoneinfo_japan_path) { 
   --skip Unable to locate zoneinfo/Japan
}
if (!$zoneinfo_europe_path) { 
   --skip Unable to locate zoneinfo/Europe
}

-- Create tables zone tables in test_zone database
CREATE DATABASE test_zone;
USE test_zone;
CREATE TABLE time_zone as SELECT * FROM mysql.time_zone WHERE 1 = 0;
CREATE TABLE time_zone_leap_second as SELECT * FROM mysql.time_zone_leap_second WHERE 1 = 0;
CREATE TABLE time_zone_name as SELECT * FROM mysql.time_zone_name WHERE 1 = 0;
CREATE TABLE time_zone_transition as SELECT * FROM mysql.time_zone_transition WHERE 1 = 0;
CREATE TABLE time_zone_transition_type as SELECT * FROM mysql.time_zone_transition_type WHERE 1 = 0;

-- Disabling query log when sourcing loadzonefile.sql to make test stable
--disable_query_log
--source $MYSQLTEST_VARDIR/tmp/loadzonefile.sql
--enable_query_log
-- Selecting count(*) > 0 to verify that mysql_tzinfo_to_sql produced output, while keeping the test stable
SELECT (count(*) > 0) FROM time_zone;
SELECT (count(*) > 0) FROM time_zone_name;
SELECT (count(*) > 0) FROM time_zone_transition;
SELECT (count(*) > 0) FROM time_zone_transition_type;
  SELECT (count(*) > 1) AS OK FROM time_zone_leap_second;
  -- Dummy select to match the result file
  SELECT (count(*) = 0) AS OK FROM time_zone_leap_second;
SELECT (count(*) > 0) FROM time_zone;
SELECT (count(*) > 0) FROM time_zone_name;
SELECT (count(*) > 0) FROM time_zone_transition;
SELECT (count(*) > 0) FROM time_zone_transition_type;

-- Cleanup
DROP DATABASE test_zone;
