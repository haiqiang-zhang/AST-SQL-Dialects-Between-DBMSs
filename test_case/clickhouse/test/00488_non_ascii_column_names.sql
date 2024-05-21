DROP TABLE IF EXISTS non_ascii;
CREATE TABLE non_ascii (`ÃÂÃÂ¿ÃÂÃÂÃÂÃÂ¸ÃÂÃÂ²ÃÂÃÂµÃÂÃÂ` String, `ÃÂÃÂ¼ÃÂÃÂ¸ÃÂÃÂ` String) ENGINE = TinyLog;
SELECT `ÃÂÃÂ¿ÃÂÃÂÃÂÃÂ¸ÃÂÃÂ²ÃÂÃÂµÃÂÃÂ` FROM non_ascii;
SELECT * FROM non_ascii;
DROP TABLE non_ascii;
