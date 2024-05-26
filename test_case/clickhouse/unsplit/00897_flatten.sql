SELECT flatten(arrayJoin([[[1, 2, 3], [4, 5]], [[6], [7, 8]]]));
SELECT arrayFlatten(arrayJoin([[[[]], [[1], [], [2, 3]]], [[[4]]]]));
SELECT flatten(arrayMap(x -> arrayMap(y -> arrayMap(z -> range(x), range(x)), range(x)), range(number))) FROM numbers(6);
