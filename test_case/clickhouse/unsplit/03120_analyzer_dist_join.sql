-- https://github.com/ClickHouse/ClickHouse/issues/8547
SET allow_experimental_analyzer=1;
SET distributed_foreground_insert=1;
SET distributed_product_mode='local';
SET distributed_product_mode='global';
