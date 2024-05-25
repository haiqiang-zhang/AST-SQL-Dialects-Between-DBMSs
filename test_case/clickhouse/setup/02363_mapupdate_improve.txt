DROP TABLE IF EXISTS map_test;
CREATE TABLE map_test(`tags` Map(String, String)) ENGINE = MergeTree PRIMARY KEY tags ORDER BY tags SETTINGS index_granularity = 8192;
INSERT INTO map_test (tags) VALUES (map('fruit','apple','color','red'));
INSERT INTO map_test (tags) VALUES (map('fruit','apple','color','red'));
INSERT INTO map_test (tags) VALUES (map('fruit','apple','color','red'));
INSERT INTO map_test (tags) VALUES (map('fruit','apple','color','red'));
INSERT INTO map_test (tags) VALUES (map('fruit','apple','color','red'));
