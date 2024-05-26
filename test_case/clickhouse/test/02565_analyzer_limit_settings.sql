SELECT * FROM numbers(10);
SELECT * FROM numbers(10) SETTINGS limit=5, offset=2;
SELECT count(*) FROM (SELECT * FROM numbers(10));
SELECT count(*) FROM view(SELECT * FROM numbers(10));
SET limit = 3;
SELECT * FROM numbers(10) SETTINGS limit=5, offset=2;
SET limit = 4;
SET offset = 1;
