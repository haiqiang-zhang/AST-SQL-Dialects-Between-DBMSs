SELECT l FROM tbl ORDER BY l NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l NULLS LAST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS FIRST LIMIT 5;
SELECT l FROM tbl ORDER BY l DESC NULLS LAST LIMIT 5;
SELECT range(i) l FROM range(10) tbl(i) ORDER BY l DESC LIMIT 3;
SELECT range(i) l FROM range(10) tbl(i) ORDER BY l ASC LIMIT 3;