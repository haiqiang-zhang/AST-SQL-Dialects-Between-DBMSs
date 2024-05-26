SELECT dictGet(currentDatabase() || '.dict', 's', number) FROM numbers(2);
DROP TABLE src;
DROP DICTIONARY dict;
