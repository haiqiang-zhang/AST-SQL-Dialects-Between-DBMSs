
CREATE TABLE t (x INT);
INSERT INTO t VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

CREATE TABLE t1 (x INT);
CREATE TABLE t2 (x INT);
CREATE TABLE t3 (x INT);

INSERT INTO t1 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;
INSERT INTO t2 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;
INSERT INTO t3 SELECT 10*tens.x + ones.x FROM t AS ones, t AS tens;

SET optimizer_switch = 'hypergraph_optimizer=on';

-- Force the plan (t1 NLJ (t2 HJ t3)). The join_buffer_size will affect the
-- estimated rescan cost of (t2 HJ t3) since it is used to determine whether the
-- hash TABLE built over t3 is kept in memory between rescans, or whether it has to
-- be rebuilt for iteration of the inner loop in the nested loop join.
SET DEBUG='+d,subplan_tokens,force_subplan_0xe22c12cb96055ddc,force_subplan_0x8ab90bde1dd6f68c';
SET @old_join_buffer_size = @@join_buffer_size;

SET SESSION join_buffer_size = 128;

SET SESSION join_buffer_size = 1024;

SET SESSION join_buffer_size = 8192;

SET DEBUG='-d,subplan_tokens,force_subplan_0xe22c12cb96055ddc,force_subplan_0x8ab90bde1dd6f68c';

SET join_buffer_size = @old_join_buffer_size;
DROP TABLE t, t1, t2, t3;
