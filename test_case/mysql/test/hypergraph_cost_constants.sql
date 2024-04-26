
-- This test verifies that changes to the value of optimizer cost constants by
-- modifying the tables mysql.engine_cost and mysql.server_cost only affects
-- the original optimizer, and not the hypergraph optimizer.

-- The test looks at the cost in the EXPLAIN output before and after modifying
-- (and re-loading) cost constants. We want to ensure that both optimizers pick
-- plans that utilize the modified cost constants, and that only the cost
-- reported by the original optimizer changes.

-- First we look at the effect of doubling the engine cost constants on a simple
-- table scan. Both the original and hypergraph optimizer use the engine cost
-- constants when computing the cost of a table scan.

-- The second test doubles the server cost constants and looks at the cost of
-- a covering index range scan. With hypergraph + InnoDB the default handler
-- implementation of multi_range_read_info_const() is called which uses the
-- server cost constant row_evaluate_cost, among other calls to the cost model.

-- echo --
-- echo -- First test: engine costs.
-- echo --

CREATE TABLE t(x INT);
INSERT INTO t VALUES (0), (1), (2);

-- echo --
-- echo -- Default engine costs.
-- echo --

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

-- echo --
-- echo -- Double engine costs.
-- echo --

UPDATE mysql.engine_cost SET cost_value = 2*default_value;

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

UPDATE mysql.engine_cost SET cost_value = DEFAULT;

-- echo --
-- echo -- Second test: server costs.
-- echo --

DROP TABLE t;
CREATE TABLE t(x INT PRIMARY KEY);
INSERT INTO t VALUES (0), (1), (2), (3), (4), (5), (6), (7), (8), (9);

-- echo --
-- echo -- Default server costs.
-- echo --

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

-- echo --
-- echo -- Double server costs.
-- echo --

UPDATE mysql.server_cost SET cost_value = 2*default_value;

SET optimizer_switch='hypergraph_optimizer=off';

SET optimizer_switch='hypergraph_optimizer=on';

UPDATE mysql.server_cost SET cost_value = DEFAULT;

DROP TABLE t;
