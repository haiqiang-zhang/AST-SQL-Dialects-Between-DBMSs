DROP TABLE IF EXISTS has_function;
CREATE TABLE has_function(arr Array(Nullable(String))) ENGINE = Memory;
INSERT INTO has_function(arr) values ([null, 'str1', 'str2']),(['str1', 'str2']), ([]), ([]);
SELECT arr, has(`arr`, 'str1') FROM has_function;
DROP TABLE has_function;
