
CREATE TABLE t1(a INT);
ALTER INSTANCE RELOAD TLS;
DROP TABLE t1;

-- Check that statements were executed/binlogged in correct order.
let $show_binlog_events_mask_columns=1,2,4,5;
