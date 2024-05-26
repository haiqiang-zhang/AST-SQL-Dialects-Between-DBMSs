SET allow_experimental_analyzer=1;
DROP TABLE IF EXISTS 03038_table;
CREATE TABLE 03038_table
(
    `time` DateTime
)
ENGINE = MergeTree
ORDER BY time;
