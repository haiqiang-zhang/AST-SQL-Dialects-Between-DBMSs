WITH [(1, 2)] AS arr1 SELECT arrayMap((x, y) -> (y, x), arr1);
WITH [(1, 2)] AS arr1 SELECT arrayMap(x -> x.1, arr1);
WITH [(1, 2)] AS arr1, [(3, 4)] AS arr2 SELECT arrayMap((x, y) -> (y.1, x.2), arr1, arr2);
