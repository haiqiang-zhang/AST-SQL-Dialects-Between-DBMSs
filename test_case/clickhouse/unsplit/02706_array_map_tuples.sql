WITH [(1, 2)] AS arr1 SELECT arrayMap((x, y) -> (y, x), arr1);
