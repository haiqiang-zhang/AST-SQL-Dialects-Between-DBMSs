SELECT finalizeAggregation(initializeAggregation('uniqExactState', toNullable('foo')));
SELECT toTypeName(initializeAggregation('uniqExactState', toNullable('foo')));
SELECT initializeAggregation('uniqExactState', toNullable('foo')) = arrayReduce('uniqExactState', [toNullable('foo')]);
SELECT initializeAggregation('uniqExactState', toNullable(123)) = arrayReduce('uniqExactState', [toNullable(123)]);
