SET optimize_if_chain_to_multiif = 0;
EXPLAIN SYNTAX SELECT number = 1 ? 'hello' : (number = 2 ? 'world' : 'xyz') FROM numbers(10);
SET optimize_if_chain_to_multiif = 1;
EXPLAIN SYNTAX SELECT number = 1 ? 'hello' : (number = 2 ? 'world' : 'xyz') FROM numbers(10);
SELECT now64(if(Null, NULL, if(Null, nan, toFloat64(number))), Null) FROM numbers(2);