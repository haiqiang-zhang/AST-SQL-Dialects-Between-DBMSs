select '---- Q1 ----';
SELECT
	product_name,
	price,
	group_name,
	AVG(price) OVER (PARTITION BY group_name)
FROM products INNER JOIN  product_groups USING (group_id)
order by group_name, product_name, price;
select '---- Q2 ----';
SELECT
	product_name,
	group_name,
  price,
	rank() OVER (PARTITION BY group_name ORDER BY price) rank
FROM products INNER JOIN product_groups USING (group_id)
order by group_name, rank, price, product_name;
select '---- Q3 ----';
SELECT
	product_name,
	group_name,
	price,
	row_number() OVER (PARTITION BY group_name ORDER BY price desc, product_name asc) rn
FROM products INNER JOIN product_groups USING (group_id)
ORDER BY group_name, rn;
select '---- Q4 ----';
SELECT *
FROM
(
    SELECT
        product_name,
        group_name,
        price,
        min(price) OVER (PARTITION BY group_name) AS min_price,
        dense_rank() OVER (PARTITION BY group_name ORDER BY price ASC) AS r
    FROM products
    INNER JOIN product_groups USING (group_id)
) AS t
WHERE min_price > 160
ORDER BY
    group_name ASC,
    r ASC,
    product_name ASC;
select '---- Q5 ----';
SELECT
	product_name,
	group_name,
	price,
	FIRST_VALUE (price) OVER (PARTITION BY group_name ORDER BY product_name desc) AS price_per_group_per_alphab
FROM products INNER JOIN product_groups USING (group_id)
order by group_name, product_name desc;
select '---- Q6 ----';
SELECT
	product_name,
	group_name,
	price,
	LAST_VALUE (price) OVER (PARTITION BY group_name ORDER BY
			price RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS highest_price_per_group
FROM
	products
INNER JOIN product_groups USING (group_id)
order by group_name, product_name;
select '---- Q7 ----';
select product_name, price, group_name, round(avg0), round(avg1)
from (
SELECT
	product_name,
	price,
	group_name,
	avg(price) OVER (PARTITION BY group_name ORDER BY price) avg0,
	avg(price) OVER (PARTITION BY group_name ORDER BY
			price RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) avg1
FROM products INNER JOIN  product_groups USING (group_id)) t
order by group_name, product_name, price;
drop table product_groups;
drop table products;
