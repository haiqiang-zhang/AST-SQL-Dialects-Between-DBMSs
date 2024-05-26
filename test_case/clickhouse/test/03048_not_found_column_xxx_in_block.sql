SELECT *
FROM ab_12_aaa aa
LEFT JOIN ab_12_bbb bb
ON bb.id = aa.id AND bb.`_year` = aa.`_year`
WHERE bb.theyear >= 2019;
DROP TABLE IF EXISTS ab_12_aaa;
DROP TABLE IF EXISTS ab_12_bbb;
