DROP TABLE IF EXISTS tokenbf_tab;
DROP TABLE IF EXISTS ngrambf_tab;
CREATE TABLE tokenbf_tab
(
    id UInt32,
    str String,
    INDEX idx str TYPE tokenbf_v1(256, 2, 0)
)
ENGINE = MergeTree
ORDER BY id
SETTINGS index_granularity = 1;
CREATE TABLE ngrambf_tab
(
    id UInt32,
    str String,
    INDEX idx str TYPE ngrambf_v1(3, 256, 2, 0)
)
ENGINE = MergeTree
ORDER BY id
SETTINGS index_granularity = 1;
INSERT INTO tokenbf_tab VALUES (1, 'Hello ClickHouse'), (2, 'Hello World'), (3, 'Good Weather'), (4, 'Say Hello'), (5, 'OLAP Database'), (6, 'World Champion');
INSERT INTO ngrambf_tab VALUES (1, 'Hello ClickHouse'), (2, 'Hello World'), (3, 'Good Weather'), (4, 'Say Hello'), (5, 'OLAP Database'), (6, 'World Champion');