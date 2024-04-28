pragma enable_verification;;
CREATE TABLE tbl AS SELECT 42 AS a;
SELECT column_name, min FROM (SUMMARIZE SELECT 42 AS a);;
SELECT column_name, min FROM (SUMMARIZE tbl);;
