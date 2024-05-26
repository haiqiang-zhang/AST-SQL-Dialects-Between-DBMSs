SELECT d, k1, k2,
	sumMerge(Sum), avgMerge(Avg), uniqMerge(Uniq),
	anyMerge(Any), anyIfMerge(AnyIf),
	arrayMap(x -> round(x, 6), quantilesMerge(0.5, 0.9)(Quantiles)),
	groupArrayMerge(GroupArray)
FROM stored_aggregates
GROUP BY d, k1, k2
ORDER BY d, k1, k2;
DROP TABLE stored_aggregates;
