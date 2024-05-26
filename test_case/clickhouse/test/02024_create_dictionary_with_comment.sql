SHOW CREATE DICTIONARY 2024_dictionary_with_comment;
SELECT comment FROM system.dictionaries WHERE name == '2024_dictionary_with_comment' AND database == currentDatabase();
DROP DICTIONARY IF EXISTS 2024_dictionary_with_comment;
