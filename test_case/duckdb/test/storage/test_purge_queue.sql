ATTACH '__TEST_DIR__/num${i}.db';;
CREATE OR REPLACE TABLE num${i}.tbl AS SELECT range AS id, range + 10 AS other FROM range(200);;
DROP TABLE num${i}.tbl;;
SELECT id, other FROM num${i}.tbl WHERE id > 50 ORDER BY other LIMIT 2;;
