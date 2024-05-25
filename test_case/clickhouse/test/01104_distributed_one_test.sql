SELECT 'local_0', toUInt8(1) AS dummy FROM system.one AS o WHERE o.dummy = 0;
SELECT 'local_1', toUInt8(1) AS dummy FROM system.one AS o WHERE o.dummy = 1;
SET distributed_product_mode = 'local';
SELECT 'local_0', toUInt8(1) AS dummy FROM system.one AS o WHERE o.dummy = 0;
SELECT 'local_1', toUInt8(1) AS dummy FROM system.one AS o WHERE o.dummy = 1;
