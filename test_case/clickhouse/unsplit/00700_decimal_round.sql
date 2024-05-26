SELECT toDecimal32(12345.6789, 4) AS x, round(x), round(x, 1), round(x, 2), round(x, 3), round(x, 4), round(x, 5);
SELECT toDecimal32(12345.6789, 4) AS x, roundBankers(x), roundBankers(x, 1), roundBankers(x, 2), roundBankers(x, 3), roundBankers(x, 4), roundBankers(x, 5);
SELECT toDecimal32(12345.6789, 4) AS x, ceil(x), ceil(x, 1), ceil(x, 2), ceil(x, 3), ceil(x, 4), ceil(x, 5);
SELECT toDecimal32(12345.6789, 4) AS x, floor(x), floor(x, 1), floor(x, 2), floor(x, 3), floor(x, 4), floor(x, 5);
SELECT toDecimal32(12345.6789, 4) AS x, trunc(x), trunc(x, 1), trunc(x, 2), trunc(x, 3), trunc(x, 4), trunc(x, 5);
select '-- Decimal128, Scale 20';
select '-- Decimal256, Scale 40';
