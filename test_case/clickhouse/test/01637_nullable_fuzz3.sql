SELECT item_id FROM (SELECT item_id FROM t GROUP BY item_id WITH TOTALS) AS l FULL OUTER JOIN (SELECT item_id FROM t GROUP BY item_id WITH TOTALS) AS r USING (item_id);
SELECT item_id FROM (SELECT item_id FROM t GROUP BY item_id WITH TOTALS) AS l FULL OUTER JOIN (SELECT item_id FROM t GROUP BY item_id WITH TOTALS) AS r USING (item_id) SETTINGS join_use_nulls = '1';
SELECT * FROM (SELECT item_id, sum(price_sold) as price_sold FROM t GROUP BY item_id WITH TOTALS) AS l FULL OUTER JOIN (SELECT item_id, sum(price_sold) as price_sold FROM t GROUP BY item_id WITH TOTALS) AS r USING (item_id) SETTINGS join_use_nulls = '1';
DROP TABLE t;
