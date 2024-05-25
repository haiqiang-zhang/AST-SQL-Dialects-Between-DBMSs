SELECT arr, has(`arr`, 'str1') FROM has_function;
SELECT has([null, 'str1', 'str2'], 'str1');
DROP TABLE has_function;
