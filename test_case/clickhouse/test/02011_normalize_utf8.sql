DROP TABLE IF EXISTS normalize_test;
CREATE TABLE normalize_test (id int, value String) ENGINE = MergeTree ORDER BY value;
SELECT
    'Ñ' AS norm, 'ÐµÌ' AS denorm,
    length(norm), length(denorm),
    normalizeUTF8NFC(norm) AS norm_nfc,
    normalizeUTF8NFC(denorm) AS denorm_nfc,
    length(norm_nfc),
    length(denorm_nfc);
INSERT INTO normalize_test (id, value) VALUES (1, 'ÐµÌ');
INSERT INTO normalize_test (id, value) VALUES (2, 'Ñ');
INSERT INTO normalize_test (id, value) VALUES (3, 'à°à±à°âà°¾');
INSERT INTO normalize_test (id, value) VALUES (4, 'æ¬æ°ã§ãã');
INSERT INTO normalize_test (id, value) VALUES (5, 'ï·º');
INSERT INTO normalize_test (id, value) VALUES (6, 'á¾');
INSERT INTO normalize_test (id, value) VALUES (7, 'Î');
INSERT INTO normalize_test (id, value) VALUES (8, '×©Ö¼×');
INSERT INTO normalize_test (id, value) VALUES (9, 'ðð¥ð®');
INSERT INTO normalize_test (id, value) VALUES (10, 'QÌ¹Ì£Ì©Ì­Ì°Ì°Ì¹ÌÍ¬Ì¿ÍÌá¹·Ì¬Ì°Í¥eÌÍÍÌ°ÌºÌÍsÍÌÌtÍÌ£Ì¯Ì²ÌÌ Í£ÌÍ¨ÌÌÌoÌ²ÍÌºÍÍ¯Í£ÌÌÌÌ Ì³ÍÍÌÌÃ¨ÌÍ¥Í¯Í¨ÌÍ®Í Ì¦Ì¹Ì£Ì°ÌÌÌÍÌÌtÍÌ­Ì»ÌÍÌ¾eÌºÍÍ£ÍÌá¹£Ì ÍÍÍÌ²Ì¦ÌtÌÍÌÍÌ£Í­ÍÌÌÌá»Ì¥ÍÍÍÌ ÌÍ¦Ì½ÍZÍ¯ÌÌaÍlÌ»Í¨ÌÍ§Í£Í¨Í¬gÍÌÌÌ¾ÌÌ¾Í¬oÌ Í®Í');
SELECT
    id, value, length(value),
    normalizeUTF8NFC(value) AS nfc, length(nfc) AS nfc_len,
    normalizeUTF8NFD(value) AS nfd, length(nfd) AS nfd_len,
    normalizeUTF8NFKC(value) AS nfkc, length(nfkc) AS nfkc_len,
    normalizeUTF8NFKD(value) AS nfkd, length(nfkd) AS nfkd_len
FROM normalize_test
ORDER BY id;
SELECT char(228) AS value, normalizeUTF8NFC(value);
SELECT char(228) AS value, normalizeUTF8NFD(value);
SELECT char(228) AS value, normalizeUTF8NFKC(value);
SELECT char(228) AS value, normalizeUTF8NFKD(value);