SET allow_experimental_inverted_index = 1;
DROP TABLE IF EXISTS tab;
SELECT data_version FROM system.parts WHERE database = currentDatabase() AND table = 'tab' AND active = 1;
SELECT data_version FROM system.parts WHERE database = currentDatabase() AND table = 'tab' AND active = 1;
