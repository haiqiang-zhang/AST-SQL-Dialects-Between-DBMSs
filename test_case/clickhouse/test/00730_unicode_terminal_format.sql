DROP TABLE IF EXISTS unicode;
CREATE TABLE unicode(c1 String, c2 String) ENGINE = Memory;
INSERT INTO unicode VALUES ('ÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂ°ÃÂÃÂ²ÃÂÃÂÃÂÃÂÃÂÃÂ²ÃÂÃÂÃÂÃÂ¹ÃÂÃÂÃÂÃÂµ', 'ÃÂÃÂ­ÃÂÃÂÃÂÃÂ¾ÃÂÃÂ ÃÂÃÂºÃÂÃÂ¾ÃÂÃÂ´ ÃÂÃÂ¼ÃÂÃÂ¾ÃÂÃÂ¶ÃÂÃÂ½ÃÂÃÂ¾ ÃÂÃÂ¾ÃÂÃÂÃÂÃÂÃÂÃÂµÃÂÃÂ´ÃÂÃÂ°ÃÂÃÂºÃÂÃÂÃÂÃÂ¸ÃÂÃÂÃÂÃÂ¾ÃÂÃÂ²ÃÂÃÂ°ÃÂÃÂÃÂÃÂ ÃÂÃÂ¸ ÃÂÃÂ·ÃÂÃÂ°ÃÂÃÂ¿ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¸ÃÂÃÂÃÂÃÂ!');
INSERT INTO unicode VALUES ('ÃÂ¤ÃÂ½ÃÂ ÃÂ¥ÃÂ¥ÃÂ½', 'ÃÂ¨ÃÂ¿ÃÂÃÂ¦ÃÂ®ÃÂµÃÂ¤ÃÂ»ÃÂ£ÃÂ§ÃÂ ÃÂÃÂ¦ÃÂÃÂ¯ÃÂ¥ÃÂÃÂ¯ÃÂ¤ÃÂ»ÃÂ¥ÃÂ§ÃÂ¼ÃÂÃÂ¨ÃÂ¾ÃÂÃÂ¥ÃÂ¹ÃÂ¶ÃÂ¤ÃÂ¸ÃÂÃÂ¨ÃÂÃÂ½ÃÂ¥ÃÂ¤ÃÂÃÂ¨ÃÂ¿ÃÂÃÂ¨ÃÂ¡ÃÂÃÂ§ÃÂÃÂÃÂ¯ÃÂ¼ÃÂ');
INSERT INTO unicode VALUES ('Hola', 'ÃÂÃÂ¡Este cÃÂÃÂ³digo es editable y ejecutable!');
INSERT INTO unicode VALUES ('Bonjour', 'Ce code est modifiable et exÃÂÃÂ©cutable !');
INSERT INTO unicode VALUES ('Ciao', 'Questo codice ÃÂÃÂ¨ modificabile ed eseguibile!');
INSERT INTO unicode VALUES ('ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ«ÃÂ£ÃÂÃÂ¡ÃÂ£ÃÂÃÂ¯', 'ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ®ÃÂ£ÃÂÃÂ³ÃÂ£ÃÂÃÂ¼ÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ¯ÃÂ§ÃÂ·ÃÂ¨ÃÂ©ÃÂÃÂÃÂ£ÃÂÃÂÃÂ£ÃÂÃÂ¦ÃÂ¥ÃÂ®ÃÂÃÂ¨ÃÂ¡ÃÂÃÂ¥ÃÂÃÂºÃÂ¦ÃÂÃÂ¥ÃÂ£ÃÂÃÂ¾ÃÂ£ÃÂÃÂÃÂ¯ÃÂ¼ÃÂ');
INSERT INTO unicode VALUES ('ÃÂ¬ÃÂÃÂÃÂ«ÃÂÃÂÃÂ­ÃÂÃÂÃÂ¬ÃÂÃÂ¸ÃÂ¬ÃÂÃÂ', 'ÃÂ¬ÃÂÃÂ¬ÃÂªÃÂ¸ÃÂ°ÃÂ¬ÃÂÃÂÃÂ¬ÃÂÃÂ ÃÂ¬ÃÂ½ÃÂÃÂ«ÃÂÃÂÃÂ«ÃÂ¥ÃÂ¼ ÃÂ¬ÃÂÃÂÃÂ¬ÃÂ ÃÂÃÂ­ÃÂÃÂÃÂªÃÂ³ÃÂ  ÃÂ¬ÃÂÃÂ¤ÃÂ­ÃÂÃÂÃÂ­ÃÂÃÂ  ÃÂ¬ÃÂÃÂ ÃÂ¬ÃÂÃÂÃÂ¬ÃÂÃÂµÃÂ«ÃÂÃÂÃÂ«ÃÂÃÂ¤!');
INSERT INTO unicode VALUES ('CzeÃÂÃÂÃÂÃÂ', 'Ten kod moÃÂÃÂ¼na edytowaÃÂÃÂ oraz uruchomiÃÂÃÂ!');
INSERT INTO unicode VALUES ('OlÃÂÃÂ¡', 'Este cÃÂÃÂ³digo ÃÂÃÂ© editÃÂÃÂ¡vel e executÃÂÃÂ¡vel!');
INSERT INTO unicode VALUES ('ChÃÂÃÂ o bÃÂ¡ÃÂºÃÂ¡n', 'BÃÂ¡ÃÂºÃÂ¡n cÃÂÃÂ³ thÃÂ¡ÃÂ»ÃÂ edit vÃÂÃÂ  run code trÃÂ¡ÃÂ»ÃÂ±c tiÃÂ¡ÃÂºÃÂ¿p!');
INSERT INTO unicode VALUES ('Hallo', 'Dieser Code kann bearbeitet und ausgefÃÂÃÂ¼hrt werden!');
INSERT INTO unicode VALUES ('Hej', 'Den hÃÂÃÂ¤r koden kan redigeras och kÃÂÃÂ¶ras!');
INSERT INTO unicode VALUES ('Ahoj', 'Tento kÃÂÃÂ³d mÃÂÃÂ¯ÃÂÃÂ¾ete upravit a spustit');
INSERT INTO unicode VALUES ('Tabs \t Tabs', 'Non-first \t Tabs');
INSERT INTO unicode VALUES ('Control characters \x1f\x1f\x1f\x1f with zero width', 'Invalid UTF-8 which eats pending characters \xf0, or invalid by itself \x80 with zero width');
INSERT INTO unicode VALUES ('Russian ÃÂÃÂ and ÃÂÃÂµÃÂÃÂ ', 'Zero bytes \0 \0 in middle');
DROP TABLE IF EXISTS unicode;
