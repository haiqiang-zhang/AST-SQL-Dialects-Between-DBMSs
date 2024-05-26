SELECT arrayDifference([toUInt128(1), 3]), toTypeName(arrayDifference([toUInt128(1), 3]));
SELECT '---';
SELECT arrayCumSum([toUInt128(1), 2]), toTypeName(arrayCumSum([toUInt128(1), 2]));
SELECT '---';
SELECT arrayCumSumNonNegative([toUInt128(1), 2]), toTypeName(arrayCumSumNonNegative([toUInt128(1), 2]));
