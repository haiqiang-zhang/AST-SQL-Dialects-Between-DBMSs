
-- At report time, the query used crash, later due to "commit 88d716a -
-- Bug#35813111" it no longer failed, but fell back on tmp table
-- de-duplication.  With this patch, it spills to disk - normal
-- behavior since default buffer (set_operations_buffer_size) is too
-- small for the data - but no longer falls back on tmp table
-- de-duplication.

CREATE TABLE t1(
  c1 TEXT,
  c2 CHAR(255) DEFAULT NULL
);

SET optimizer_trace="enabled=on";

let $show_trace=
   SELECT JSON_PRETTY(JSON_EXTRACT(trace,"$.steps[*].join_execution"))
   FROM information_schema.optimizer_trace;

let $pattern=$elide_trace_costs_and_rows;
let $pattern=$pattern /num_initial_chunks_spilled_to_disk\": [0-9.]+/num_initial_chunks_spilled_to_disk\": "elided"/;
let $pattern=$pattern /peak_memory_used\": [0-9.]+/peak_memory_used\": "elided"/;
let $pattern=$pattern /chunk files\": [48]/chunk files\": "elided"/;


SELECT MAX( c1 ) OVER ( ORDER BY c2 ROWS CURRENT ROW ) FROM t1
INTERSECT DISTINCT
SELECT "can't" OR 447938560 FROM t1;

SET optimizer_trace=default;

DROP TABLE t1;
