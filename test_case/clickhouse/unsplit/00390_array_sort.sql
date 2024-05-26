SELECT [2, 1, 3] AS arr, arraySort(arr), arrayReverseSort(arr), arraySort(x -> -x, arr);
SELECT splitByChar('0', toString(intHash64(number))) AS arr, arraySort(arr) AS sorted, arraySort(x -> toUInt64OrZero(x), arr) AS sorted_nums FROM system.numbers LIMIT 10;
SELECT arrayReverseSort(number % 2 ? emptyArrayUInt64() : range(number)) FROM system.numbers LIMIT 10;
SELECT arraySort((x, y) -> y, ['hello', 'world'], [2, 1]);
SELECT [9,4,8,10,5,2,3,7,1,6] AS arr, 4 AS lim, arrayResize(arrayPartialReverseSort(lim, arr), lim), arrayResize(arrayPartialSort(x -> -x, lim, arr), lim);
SELECT splitByChar('0', toString(intHash64(number))) AS arr, 3 AS lim, arrayResize(arrayPartialSort(lim, arr), lim) AS sorted, arrayResize(arrayPartialSort(x -> toUInt64OrZero(x), lim, arr), lim) AS sorted_nums FROM system.numbers LIMIT 10;
SELECT res FROM (SELECT arrayPartialReverseSort(2, number % 2 ? emptyArrayUInt64() : range(number)) AS arr, arrayResize(arr, if(empty(arr), 0, 2)) AS res FROM system.numbers LIMIT 10);
SELECT 0 as nelems, [NULL,9,4,8,10,5,2,3,7,1,6] AS arr, arrayPartialSort(nelems, arr), arrayPartialReverseSort(nelems, arr), arrayPartialSort((x) -> -x, nelems, arr);
