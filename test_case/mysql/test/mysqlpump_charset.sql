SELECT * FROM t_latin1 ORDER BY 1;
SELECT * FROM t_utf8 ORDER BY 1;
SELECT hex(c1), hex(c2) from t_koi8r;
DROP DATABASE db1_charset;
CREATE DATABASE db1_charset;
SELECT * FROM t_latin1 ORDER BY 1;
SELECT * FROM t_utf8 ORDER BY 1;
SELECT hex(c1), hex(c2) FROM t_koi8r ORDER BY 1;
DROP DATABASE db1_charset;
CREATE DATABASE db1_charset;
CREATE TABLE t_allcharsets
             (ucs2 CHAR(40) character set ucs2,
              utf8mb3 CHAR(40) character set utf8mb3,
              big5 CHAR(40) character set big5,
              cp932 CHAR(40) character set cp932,
              eucjpms CHAR(40) character set eucjpms,
              euckr CHAR(40) character set euckr,
              gb2312 CHAR(40) character set gb2312,
              gbk CHAR(40) character set gbk,
              sjis CHAR(40) character set sjis,
              ujis CHAR(40) character set ujis);
INSERT INTO t_allcharsets (ucs2) VALUES (0x30da);
UPDATE t_allcharsets
          SET utf8mb3=ucs2,
              big5=ucs2,
              cp932=ucs2,
              eucjpms=ucs2,
              euckr=ucs2,
              gb2312=ucs2,
              gbk=ucs2,
              sjis=ucs2,
              ujis=ucs2;
SELECT * FROM t_allcharsets;
DROP DATABASE db1_charset;
SELECT * FROM t_allcharsets;
