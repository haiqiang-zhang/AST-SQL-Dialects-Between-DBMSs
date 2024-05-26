SET function_range_max_elements_in_block = 10;
SELECT range(number % 3) FROM numbers(10);
SET function_range_max_elements_in_block = 12;
