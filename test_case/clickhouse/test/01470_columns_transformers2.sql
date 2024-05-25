SELECT * APPLY x->argMax(x, number) FROM numbers(1);
EXPLAIN SYNTAX SELECT * APPLY x->argMax(x, number) FROM numbers(1);
