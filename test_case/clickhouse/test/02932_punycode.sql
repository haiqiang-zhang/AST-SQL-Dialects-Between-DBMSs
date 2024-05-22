-- no-fasttest: requires idna library

-- See also 02932_idna.sql

SELECT '-- Negative tests';
SELECT '-- Regular cases';
-- - https://github.com/ada-url/idna/blob/8cd03ef867dbd06be87bd61df9cf69aa1182ea21/tests/fixtures/utf8_punycode_alternating.txt

SELECT 'a' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'A' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT '--' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'London' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'Lloyd-Atkinson' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'This has spaces' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT '-> $1.00 <-' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂÃÂ°' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂÃÂ¼' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂÃÂ±' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ¤ÃÂ¾ÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ°ÃÂÃÂÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂÃÂ±ÃÂÃÂ²ÃÂÃÂ³' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'MÃÂÃÂ¼nchen' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'Mnchen-3ya' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'MÃÂÃÂ¼nchen-Ost' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'Bahnhof MÃÂÃÂ¼nchen-Ost' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'abÃÂÃÂ¦cdÃÂÃÂ¶ef' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂÃÂ¿ÃÂÃÂÃÂÃÂ°ÃÂÃÂ²ÃÂÃÂ´ÃÂÃÂ°' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ ÃÂ¸ÃÂ¢ÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂÃÂ ÃÂ¸ÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ¡ÃÂ£ÃÂÃÂ¤ÃÂ£ÃÂÃÂ³ÃÂ¥ÃÂÃÂÃÂ¤ÃÂ¾ÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'MajiÃÂ£ÃÂÃÂ§KoiÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ5ÃÂ§ÃÂ§ÃÂÃÂ¥ÃÂÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ£ÃÂÃÂbÃÂÃÂ¼cherÃÂ£ÃÂÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT 'ÃÂ¥ÃÂÃÂ¢ÃÂ¦ÃÂ·ÃÂ' AS str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try;
SELECT '-- Special cases';
SELECT '---- Empty input';
SELECT punycodeEncode('');
SELECT punycodeDecode('');
SELECT tryPunycodeDecode('');
SELECT '---- NULL input';
SELECT punycodeEncode(NULL);
SELECT punycodeDecode(NULL);
SELECT tryPunycodeDecode(NULL);
SELECT '---- Garbage Punycode-encoded input';
SELECT tryPunycodeDecode('no punycode');
SELECT '---- Long input';
SELECT '---- Non-const values';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab (str String) ENGINE=MergeTree ORDER BY str;
INSERT INTO tab VALUES ('abc') ('aÃÂÃÂ¤oÃÂÃÂ¶uÃÂÃÂ¼') ('MÃÂÃÂ¼nchen');
SELECT str, punycodeEncode(str) AS puny, punycodeDecode(puny) AS original, tryPunycodeDecode(puny) AS original_try FROM tab;
DROP TABLE tab;
SELECT '---- Non-const values with invalid values sprinkled in';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab (puny String) ENGINE=MergeTree ORDER BY puny;
INSERT INTO tab VALUES ('Also no punycode') ('London-') ('Mnchen-3ya') ('No punycode') ('Rtting-3ya') ('XYZ no punycode');
SELECT puny, tryPunycodeDecode(puny) AS original FROM tab;
DROP TABLE tab;
