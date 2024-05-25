-- encrypt function doesn't exist in the fastest build

-- { echoOn }
SET allow_experimental_analyzer = 1;
EXPLAIN QUERY TREE SELECT encrypt('aes-256-ofb', (SELECT 'qwerty'), '12345678901234567890123456789012'), encrypt('aes-256-ofb', (SELECT 'asdf'), '12345678901234567890123456789012');
EXPLAIN QUERY TREE SELECT encrypt('aes-256-ofb', (SELECT 'qwerty'), '12345678901234567890123456789012'), encrypt('aes-256-ofb', (SELECT 'asdf'), '12345678901234567890123456789012');
