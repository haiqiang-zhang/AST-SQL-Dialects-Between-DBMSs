
-- There is a gap between when START SLAVE returns and when MASTER_LOG_FILE and
-- MASTER_LOG_POS are set.  Ensure that we don't call SHOW SLAVE STATUS during
-- that gap.
--sync_slave_with_master

connection master;
use test;
