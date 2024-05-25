SELECT * FROM products AS p LEFT JOIN cat_hist AS c USING (categoryId);
SELECT * FROM products AS p GLOBAL LEFT JOIN cat_hist AS c USING (categoryId);
DROP TABLE cat_hist;
DROP TABLE prod_hist;
DROP TABLE products;
