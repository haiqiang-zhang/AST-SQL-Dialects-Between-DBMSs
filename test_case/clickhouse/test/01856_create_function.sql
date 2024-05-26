SELECT 01856_test_function_0(2, 3, 4);
SELECT isConstant(01856_test_function_0(1, 2, 3));
DROP FUNCTION 01856_test_function_0;
CREATE FUNCTION 01856_test_function_2 AS (a, b) -> a + b;
DROP FUNCTION 01856_test_function_2;
