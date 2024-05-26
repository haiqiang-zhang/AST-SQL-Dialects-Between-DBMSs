SELECT toUInt8(number) AS x, round(x), roundBankers(x), floor(x), ceil(x), trunc(x) FROM system.numbers LIMIT 20;
SELECT 123456789 AS x, floor(x, -1), floor(x, -2), floor(x, -3), floor(x, -4), floor(x, -5), floor(x, -6), floor(x, -7), floor(x, -8), floor(x, -9), floor(x, -10);
SELECT roundToExp2(100), roundToExp2(64), roundToExp2(3), roundToExp2(0), roundToExp2(-1);
select round(2, 4) round2, round(20, 4) round20, round(200, 4) round200, round(5, 4) round5, round(50, 4) round50, round(500, 4) round500, round(toInt32(5), 4) roundInt5, round(toInt32(50), 4) roundInt50, round(toInt32(500), 4) roundInt500;
select roundBankers(2, 4) round2, roundBankers(20, 4) round20, roundBankers(200, 4) round200, roundBankers(5, 4) round5, roundBankers(50, 4) round50, roundBankers(500, 4) round500, roundBankers(toInt32(5), 4) roundInt5, roundBankers(toInt32(50), 4) roundInt50, roundBankers(toInt32(500), 4) roundInt500;
