SELECT '-- negative tests';
SELECT '-- const and non-const inputs';
SELECT [1, 2, 3, 4, 5] AS arr, 1 AS len, arrayShingles(arr, len), arrayShingles(materialize(arr), len);
SELECT '-- special cases';
