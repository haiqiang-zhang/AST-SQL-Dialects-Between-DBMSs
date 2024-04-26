
CREATE TABLE t1 ( a INTEGER, KEY (a) );
INSERT INTO t1 VALUES (1),(2),(3);

-- Simple table scan, with subplan tokens.
SET DEBUG='+d,subplan_tokens';

-- Demonstrate that we'd normally use an index to satisfy ORDER BY.
EXPLAIN FORMAT=tree SELECT * FROM t1 ORDER BY a;

-- However, if we force the table scan variant from earlier,
-- we should get a sort instead.
SET DEBUG='+d,subplan_tokens,force_subplan_0xeed2c0bd3e39ba93';

-- Force a hash join;
SET DEBUG='+d,subplan_tokens,'
  'force_subplan_0x38d170e70c04e92c,'
  'force_subplan_0xeed2c0bd3e39ba93,'
  'force_subplan_0x079e429c703ec298';

-- When not forcing anything, we should prefer the nested loop join.
SET DEBUG='-d,subplan_tokens';

DROP TABLE t1;
