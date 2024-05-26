CREATE TABLE t ENGINE = Log AS SELECT * FROM system.numbers LIMIT 20;
SET enable_optimize_predicate_expression = 0;
