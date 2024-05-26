SELECT uniqExact(x) FROM (SELECT uniqState(number) AS x FROM numbers(100));
SELECT hex(toString(uniqExactState(x))) FROM (SELECT uniqState(number) AS x FROM numbers(1000));
SELECT toTypeName(uniqExactState(x)) FROM (SELECT quantileState(number) AS x FROM numbers(1000));
SELECT finalizeAggregation(initializeAggregation('uniqExactState', initializeAggregation('uniqState', 0)));
