SELECT groupArrayMovingSum(256)(-1) FROM numbers(300);
SELECT groupArrayMovingAvg(256)(1) FROM numbers(300);
SELECT arrayMap(x -> round(x, 4), groupArrayMovingAvg(256)(1)) FROM numbers(300);
SELECT toTypeName(groupArrayMovingAvg(256)(toDecimal32(1, 9))) FROM numbers(300);
