DROP TABLE IF EXISTS sites;
CREATE TABLE sites (Domain UInt8, `Users.UserID` Array(UInt64), `Users.Dates` Array(Array(Date))) ENGINE = MergeTree ORDER BY Domain SETTINGS vertical_merge_algorithm_min_rows_to_activate = 0, vertical_merge_algorithm_min_columns_to_activate = 0;
