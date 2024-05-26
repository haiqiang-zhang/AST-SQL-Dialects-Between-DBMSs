SELECT uniqMerge(Uniq) FROM stored_aggregates;
INSERT INTO stored_aggregates
SELECT
	toDate(toUInt16(toDate('2014-06-01')) + intDiv(number, 100)) AS d,
	uniqState(intDiv(number + 50, 10)) AS Uniq
FROM
(
	SELECT * FROM system.numbers LIMIT 500, 1000
)
GROUP BY d;
OPTIMIZE TABLE stored_aggregates;
DROP TABLE stored_aggregates;
