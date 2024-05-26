SET allow_experimental_analyzer = 0;
SET allow_experimental_window_view = 1;
DROP TABLE IF EXISTS mt;
CREATE TABLE mt(a Int32, timestamp DateTime) ENGINE=MergeTree ORDER BY tuple();
