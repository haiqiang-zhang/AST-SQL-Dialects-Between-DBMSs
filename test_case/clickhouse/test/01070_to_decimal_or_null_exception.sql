SELECT toDecimal32OrNull('e', 1) x, isNull(x);
SELECT toDecimal64OrNull('e', 2) x, isNull(x);
SELECT toDecimal128OrNull('e', 3) x, isNull(x);
