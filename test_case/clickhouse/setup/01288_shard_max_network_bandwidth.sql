SET max_network_bandwidth = 100000;
SET max_block_size = 100;
CREATE TEMPORARY TABLE times (t DateTime);
INSERT INTO times SELECT now();
INSERT INTO times SELECT now();
