SELECT base58Encode('Hold my beer...');
SELECT base58Decode(encoded) FROM (SELECT base58Encode(val) as encoded FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar', 'Hello world!']) val));
SELECT tryBase58Decode(encoded) FROM (SELECT base58Encode(val) as encoded FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar', 'Hello world!']) val));
SELECT tryBase58Decode(val) FROM (SELECT arrayJoin(['Hold my beer', 'Hold another beer', '3csAg9', 'And a wine', 'And another wine', 'And a lemonade', 't1Zv2yaZ', 'And another wine']) val);
SELECT base58Encode(val) FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar']) val);
SELECT base58Decode(val) FROM (select arrayJoin(['', '2m', '8o8', 'bQbp', '3csAg9', 'CZJRhmz', 't1Zv2yaZ', '']) val);
SELECT base58Encode(base58Decode('1BWutmTvYPwDtmw9abTkS4Ssr8no61spGAvW1X6NDix')) == '1BWutmTvYPwDtmw9abTkS4Ssr8no61spGAvW1X6NDix';
