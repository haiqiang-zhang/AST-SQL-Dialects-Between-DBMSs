SELECT uniqExact(nan) FROM numbers(1000);
SELECT sumDistinct(number + nan) FROM numbers(1000);
SELECT DISTINCT number + nan FROM numbers(1000);
SELECT topKWeightedMerge(1)(initializeAggregation('topKWeightedState(1)', nan, arrayJoin(range(10))));
