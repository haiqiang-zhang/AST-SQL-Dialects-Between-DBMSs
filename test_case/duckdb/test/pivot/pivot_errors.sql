PRAGMA enable_verification;
CREATE TABLE test(i INT, j VARCHAR);;
PIVOT test ON j IN ('a', 'b') USING SUM(test.i);;
SET pivot_filter_threshold=0;
PIVOT test ON j IN ('a', 'b') USING current_date();;
SET pivot_filter_threshold=100;
PIVOT test ON j IN ('a', 'b') USING current_date();;
PIVOT test ON j IN ('a', 'b') USING sum(41) over ();;
PIVOT test ON j IN ('a', 'b') USING sum(sum(41) over ());;
