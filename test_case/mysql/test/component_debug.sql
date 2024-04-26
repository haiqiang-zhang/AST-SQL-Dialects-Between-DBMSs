
let $connection_id= `SELECT CONNECTION_ID()`;
SET DEBUG_SYNC='before_ha_index_read_idx_map SIGNAL kill_query WAIT_FOR nothing TIMEOUT 10';
SET DEBUG_SYNC='now WAIT_FOR kill_query';
SELECT COUNT(*) FROM mysql.component;
SELECT COUNT(*) FROM mysql.component;
