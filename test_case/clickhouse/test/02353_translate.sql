SELECT translate('Hello? world.', '.?', '!,');
SELECT translate('gtcttgcaag', 'ACGTacgt', 'TGCAtgca');
SELECT translate(toString(number), '0123456789', 'abcdefghij') FROM numbers(987654, 5);
SELECT translateUTF8('HÃ´telGenÃ¨v', 'ÃÃ¡Ã©Ã­Ã³ÃºÃ´Ã¨', 'aaeiouoe');
SELECT translateUTF8('ä¸­æåç ', 'ä¹æ åä¸­æåç ', 'ã¦ãã³ã¼ãã¨ã¯');
SELECT translateUTF8(toString(number), '1234567890', 'á©à¤¯ð¿ðà¦¨ÕÃ°Ð¹Â¿à¸') FROM numbers(987654, 5);
SELECT translate('abc', '', '');
SELECT translateUTF8('abc', '', '');
SELECT translate('abc', 'ÃÃ¡Ã©Ã­Ã³ÃºÃ´Ã¨', 'aaeiouoe');
SELECT translateUTF8('abc', 'efg', '');