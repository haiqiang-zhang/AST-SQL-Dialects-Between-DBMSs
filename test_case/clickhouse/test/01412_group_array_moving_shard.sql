SELECT groupArrayMovingSum(256)(-1) FROM numbers(300);
SELECT groupArrayMovingAvg(256)(1) FROM numbers(300);
SELECT groupArrayMovingSum(256)(toDecimal32(100000000, 1)) FROM numbers(300);
SELECT groupArrayMovingSum(256)(toDecimal64(-1, 1)) FROM numbers(300);
SELECT groupArrayMovingAvg(256)(toDecimal128(-1, 1)) FROM numbers(300);
SELECT groupArrayMovingSum(10)(number) FROM numbers(100);
SELECT groupArrayMovingSum(10)(1) FROM numbers(100);
SELECT groupArrayMovingSum(256)(toDecimal32(1, 9)) FROM numbers(300);
SELECT groupArrayMovingSum(256)(toDecimal32(100000000, 1)) FROM numbers(300);
SELECT groupArrayMovingSum(256)(toDecimal32(1, 1)) FROM numbers(300);
SELECT groupArrayMovingAvg(256)(-1) FROM numbers(300);
SELECT arrayMap(x -> round(x, 4), groupArrayMovingAvg(256)(1)) FROM numbers(300);
SELECT groupArrayMovingAvg(256)(toDecimal32(1, 9)) FROM numbers(300);
SELECT toTypeName(groupArrayMovingAvg(256)(toDecimal32(1, 9))) FROM numbers(300);
SELECT groupArrayMovingAvg(100)(toDecimal32(1, 9)) FROM numbers(300);
