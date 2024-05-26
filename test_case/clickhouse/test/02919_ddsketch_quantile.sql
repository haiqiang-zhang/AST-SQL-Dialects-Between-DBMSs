SELECT '1';
SELECT round(quantileDD(0.01, 0.5)(number), 2) FROM numbers(200);
SELECT '2';
SELECT round(quantileDD(0.01, 0.5)(number), 2)
FROM
(
    SELECT arrayJoin([toInt64(number), number - 10]) AS number
    FROM numbers(0, 10)
);
SELECT '3';
SELECT '4';
SELECT '5';
SELECT '6';
SELECT '7';
SELECT '8';
SELECT '9';
DROP TABLE IF EXISTS `02919_ddsketch_quantile`;
CREATE TABLE `02919_ddsketch_quantile`
ENGINE = Log AS
SELECT quantilesDDState(0.001, 0.9)(number) AS sketch
FROM numbers(1000);
INSERT INTO `02919_ddsketch_quantile` SELECT quantilesDDState(0.001, 0.9)(number + 1000)
FROM numbers(1000);
SELECT arrayMap(a -> round(a, 2), (quantilesDDMerge(0.001, 0.9)(sketch)))
FROM `02919_ddsketch_quantile`;
