SELECT uniqCombinedIfMerge(n) FROM (SELECT uniqCombinedIfState(number, number % 2) AS n, max(number) AS last FROM numbers(10));
SELECT uniqCombinedIfMergeIf(n, last > 50) FROM (SELECT uniqCombinedIfState(number, number % 2) AS n, max(number) AS last FROM numbers(10));
SELECT uniqCombinedIfMerge(n) FILTER(WHERE last>50) FROM (SELECT uniqCombinedIfState(number, number % 2) AS n, max(number) AS last FROM numbers(10));
