SELECT translate('Hello? world.', '.?', '!,');
SELECT translate('gtcttgcaag', 'ACGTacgt', 'TGCAtgca');
SELECT translate(toString(number), '0123456789', 'abcdefghij') FROM numbers(987654, 5);
SELECT translateUTF8('Ã¤Â¸Â­Ã¦ÂÂÃ¥ÂÂÃ§Â Â', 'Ã¤Â¹ÂÃ¦Â ÂÃ¥ÂÂÃ¤Â¸Â­Ã¦ÂÂÃ¥ÂÂÃ§Â Â', 'Ã£ÂÂ¦Ã£ÂÂÃ£ÂÂ³Ã£ÂÂ¼Ã£ÂÂÃ£ÂÂ¨Ã£ÂÂ¯');
SELECT translate('abc', '', '');
SELECT translateUTF8('abc', '', '');
