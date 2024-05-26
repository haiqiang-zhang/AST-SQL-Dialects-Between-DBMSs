SELECT toTypeName(first_value_respect_nullsState(dummy)), toTypeName(last_value_respect_nullsState(dummy)) from system.one;
SELECT first_value_respect_nullsMerge(t) FROM (Select first_value_respect_nullsState(dummy) as t FROM system.one);
SELECT last_value_respect_nullsMerge(t) FROM (Select last_value_respect_nullsState(dummy) as t FROM system.one);
SELECT finalizeAggregation(CAST(unhex('01'), 'AggregateFunction(any_respect_nulls, UInt64)'));
