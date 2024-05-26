SELECT base58Encode('Hold my beer...');
SELECT base58Decode(encoded) FROM (SELECT base58Encode(val) as encoded FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar', 'Hello world!']) val));
SELECT tryBase58Decode(encoded) FROM (SELECT base58Encode(val) as encoded FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar', 'Hello world!']) val));
SELECT base58Encode(base58Decode('1BWutmTvYPwDtmw9abTkS4Ssr8no61spGAvW1X6NDix')) == '1BWutmTvYPwDtmw9abTkS4Ssr8no61spGAvW1X6NDix';
