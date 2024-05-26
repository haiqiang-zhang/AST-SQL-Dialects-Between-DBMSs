DROP TABLE IF EXISTS DATE_INFO_DICT;
CREATE TABLE DATE_INFO_DICT
(
    `TV` Date,
    `SHAMSI` String,
    `HIJRI` String,
    `MILADI` String,
    `S_DAY` UInt8,
    `H_DAY` UInt8,
    `S_MONTH` UInt8,
    `H_MONTH` UInt8,
    `WEEK_DAY_NAME` String,
    `DAY_NUMBER` UInt8,
    `HOLIDAY` UInt8,
    `WEEK_NAME` String
)
ENGINE = Join(ANY, LEFT, TV);
