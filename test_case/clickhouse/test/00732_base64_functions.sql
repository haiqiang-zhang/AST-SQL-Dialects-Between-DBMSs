SET send_logs_level = 'fatal';
-- test with valid inputs

SELECT base64Encode(val) FROM (select arrayJoin(['', 'f', 'fo', 'foo', 'foob', 'fooba', 'foobar']) val);
SELECT base64Decode(val) FROM (select arrayJoin(['', 'Zg==', 'Zm8=', 'Zm9v', 'Zm9vYg==', 'Zm9vYmE=', 'Zm9vYmFy']) val);
SELECT tryBase64Decode(val) FROM (select arrayJoin(['', 'Zg==', 'Zm8=', 'Zm9v', 'Zm9vYg==', 'Zm9vYmE=', 'Zm9vYmFy']) val);
SELECT base64Decode(base64Encode('foo')) = 'foo', base64Encode(base64Decode('Zm9v')) == 'Zm9v';
SELECT tryBase64Decode(base64Encode('foo')) = 'foo', base64Encode(tryBase64Decode('Zm9v')) == 'Zm9v';
SELECT tryBase64Decode('Zm9vYmF=Zm9v');
SELECT tryBase64Decode('foo');
SELECT tryBase64Decode('aoeo054640eu=');
select base64Encode(toFixedString('foo', 3));
select base64Decode(toFixedString('Zm9v', 4));
select tryBase64Decode(toFixedString('Zm9v', 4));
