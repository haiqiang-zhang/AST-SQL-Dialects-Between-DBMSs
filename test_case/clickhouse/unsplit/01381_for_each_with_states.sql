SELECT hex(toString(uniqStateForEach([1, NULL])));
SELECT arrayMap(x -> hex(toString(x)), finalizeAggregation(uniqStateForEachState([1, NULL])));
