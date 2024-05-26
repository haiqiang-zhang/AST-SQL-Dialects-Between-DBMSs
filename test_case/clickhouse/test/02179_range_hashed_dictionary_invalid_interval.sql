SELECT dictGet('02179_test_dictionary', 'value', 0, 15);
SELECT dictHas('02179_test_dictionary', 0, 15);
SELECT * FROM 02179_test_dictionary;
DROP DICTIONARY 02179_test_dictionary;
DROP TABLE 02179_test_table;
