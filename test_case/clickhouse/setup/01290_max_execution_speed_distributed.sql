SET max_execution_speed = 1000000;
SET timeout_before_checking_execution_speed = 0;
SET max_block_size = 100;
SET log_queries=1;
CREATE TEMPORARY TABLE times (t DateTime);
INSERT INTO times SELECT now();
INSERT INTO times SELECT now();
