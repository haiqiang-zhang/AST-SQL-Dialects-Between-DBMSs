SELECT 02102_test_function(1);
CREATE FUNCTION IF NOT EXISTS 02102_test_function AS x -> x + 1;
DROP FUNCTION 02102_test_function;
