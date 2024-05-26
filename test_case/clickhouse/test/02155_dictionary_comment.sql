SELECT name, comment FROM system.dictionaries WHERE name == '02155_test_dictionary' AND database == currentDatabase();
ALTER TABLE 02155_test_dictionary MODIFY COMMENT '02155_test_dictionary_comment_0';
SELECT name, comment FROM system.dictionaries WHERE name == '02155_test_dictionary' AND database == currentDatabase();
SELECT name, comment FROM system.tables WHERE name == '02155_test_dictionary' AND database == currentDatabase();
SELECT * FROM 02155_test_dictionary;
SELECT name, comment FROM system.dictionaries WHERE name == '02155_test_dictionary' AND database == currentDatabase();
SELECT name, comment FROM system.tables WHERE name == '02155_test_dictionary' AND database == currentDatabase();
ALTER TABLE 02155_test_dictionary MODIFY COMMENT '02155_test_dictionary_comment_1';
SELECT name, comment FROM system.dictionaries WHERE name == '02155_test_dictionary' AND database == currentDatabase();
SELECT name, comment FROM system.tables WHERE name == '02155_test_dictionary' AND database == currentDatabase();
DROP TABLE IF EXISTS 02155_test_dictionary_view;
CREATE TABLE 02155_test_dictionary_view
(
    id UInt64,
    value String
) ENGINE=Dictionary(concat(currentDatabase(), '.02155_test_dictionary'));
SELECT * FROM 02155_test_dictionary_view;
ALTER TABLE 02155_test_dictionary_view MODIFY COMMENT '02155_test_dictionary_view_comment_0';
SELECT name, comment FROM system.tables WHERE name == '02155_test_dictionary_view' AND database == currentDatabase();
SELECT name, comment FROM system.tables WHERE name == '02155_test_dictionary_view' AND database == currentDatabase();
DROP TABLE 02155_test_dictionary_view;
DROP TABLE 02155_test_table;
DROP DICTIONARY 02155_test_dictionary;
