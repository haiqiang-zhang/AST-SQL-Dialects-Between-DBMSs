DROP TABLE IF EXISTS table_02916;
DROP TABLE IF EXISTS table_02916_distributed;
CREATE TABLE table_02916
(
    `ID` UInt32,
    `Name` String
)
ENGINE = MergeTree
ORDER BY ID;
INSERT INTO table_02916 VALUES (1234, 'abcd');
SET send_logs_level='fatal';
DROP TABLE table_02916;
