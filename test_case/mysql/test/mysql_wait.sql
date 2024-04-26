
-- test --wait flag
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_LOG= $MYSQLD_DATADIR/mysql_wait_output.log;

-- Wait should attempt a single retry on connectivity issues to a resolvable, but unavailable host
-- (simulated with unused IPv4 numeric address and port combination)
-- Use -v to output "Waiting" line (to assert retry actually happened)
--echo Test --wait with unavailable server host
--error 1
--exec $MYSQL -v --wait --host=0.0.0.0 --port=1 -e "SELECT 1;

-- Wait should immediately fail on connectivity issues to unresolvable host name (no retries)
--echo Test --wait with unresolvable server host name
--error 1
--exec $MYSQL -v --wait --host=invalid -e "SELECT 1;
