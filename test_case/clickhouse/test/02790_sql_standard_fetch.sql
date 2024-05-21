CREATE TEMPORARY TABLE employees (id UInt64, name String, department String, salary UInt64);
INSERT INTO employees VALUES (23, 'Henry', 'it', 104), (24, 'Irene', 'it', 104), (25, 'Frank', 'it', 120), (31, 'Cindy', 'sales', 96), (33, 'Alice', 'sales', 100), (32, 'Dave', 'sales', 96), (22, 'Grace', 'it', 90), (21, 'Emma', 'it', 84);
SET max_threads = 1, parallelize_output_from_storages = 0;