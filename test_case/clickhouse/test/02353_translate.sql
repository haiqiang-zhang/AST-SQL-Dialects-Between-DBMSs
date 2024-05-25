SELECT translate('Hello? world.', '.?', '!,');
SELECT translate('gtcttgcaag', 'ACGTacgt', 'TGCAtgca');
SELECT translate(toString(number), '0123456789', 'abcdefghij') FROM numbers(987654, 5);
SELECT translateUTF8('ÃÂ¤ÃÂ¸ÃÂ­ÃÂ¦ÃÂÃÂÃÂ¥ÃÂÃÂÃÂ§ÃÂ ÃÂ', 'ÃÂ¤ÃÂ¹ÃÂÃÂ¦ÃÂ ÃÂÃÂ¥ÃÂÃÂÃÂ¤ÃÂ¸ÃÂ­ÃÂ¦ÃÂÃÂÃÂ¥ÃÂÃÂÃÂ§ÃÂ ÃÂ', 'ÃÂ£ÃÂÃÂ¦ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ³ÃÂ£ÃÂÃÂ¼ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ¨ÃÂ£ÃÂÃÂ¯');
SELECT translate('abc', '', '');
SELECT translateUTF8('abc', '', '');
