CREATE FUNCTION 02101_test_function AS x -> x + 1;
SELECT 02101_test_function(1);
DROP FUNCTION 02101_test_function;
DROP FUNCTION IF EXISTS 02101_test_function;