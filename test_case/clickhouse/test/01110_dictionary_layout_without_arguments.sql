SELECT dictGet('db_for_dict.dict_with_hashed_layout', 'value', toUInt64(2));
DETACH DICTIONARY db_for_dict.dict_with_hashed_layout;
ATTACH DICTIONARY db_for_dict.dict_with_hashed_layout;
SHOW CREATE DICTIONARY db_for_dict.dict_with_hashed_layout;
DROP DATABASE IF EXISTS db_for_dict;
