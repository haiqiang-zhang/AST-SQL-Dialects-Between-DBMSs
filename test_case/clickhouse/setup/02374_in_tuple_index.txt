DROP TABLE IF EXISTS t_in_tuple_index;
CREATE TABLE t_in_tuple_index
(
    `ID` String,
    `USER_ID` String,
    `PLATFORM` LowCardinality(String)
)
ENGINE = MergeTree()
ORDER BY (PLATFORM, USER_ID, ID)
SETTINGS index_granularity = 2048, index_granularity_bytes = '10Mi';
INSERT INTO t_in_tuple_index VALUES ('1', 33, 'insta'), ('2', 33, 'insta');
