
--
-- Check all charsets/collation combinations
--

let $check_std_csets= 1;

-- single byte 8 bit encoding charset
-- cp1251

let $cset= cp1251;
let $coll= cp1251_bin;

-- variable width multi byte encoding charset
-- euckr

let $cset= euckr;
let $coll= euckr_bin;

-- eucjpms

let $cset= eucjpms;
let $coll= eucjpms_bin;

-- gb18030

let $cset= gb18030;
let $coll= gb18030_bin;

let $cset= cp932;
let $coll= cp932_bin;

}

let $check_std_csets= 0;
let $check_ucs2_csets=1;

-- ucs2

let $cset= ucs2;
let $coll= ucs2_bin;

let $cset= ucs2;
let $coll= ucs2_unicode_ci;

}

let $check_std_csets= 0;
let $check_ucs2_csets= 0;
let $check_utf8_csets= 1;

if ($check_utf8_csets)
{

-- utf8mb3

let $cset= utf8mb3;
let $coll= utf8_bin;

let $cset= utf8mb3;
let $coll= utf8_unicode_ci;

}

--
-- Test for non ascii characters for object names
--

let $check_std_csets= 0;
let $check_ucs2_csets= 0;
let $check_utf8_csets= 0;
let $check_for_object_names=1;

-- cp1251

let $cset= cp1251;
let $coll= cp1251_bulgarian_ci;

-- euckr

let $cset= euckr;
let $coll= euckr_korean_ci;
 
-- gb18030
let $cset= gb18030;
let $coll= gb18030_bin;

-- ujis

let $cset= ujis;
let $coll= ujis_japanese_ci;

-- sjis

let $cset= sjis;
let $coll= sjis_japanese_ci;

}

-- Misc tests

CREATE DATABASE db1_charset;
USE db1_charset;

CREATE TABLE t_latin1(c CHAR(40)) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t_latin1 VALUES ('aaa'), ('ÁÂÃÄ');
INSERT INTO t_latin1 VALUES (_latin1'ςσ');

CREATE TABLE t_utf8(c CHAR(40)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
INSERT INTO t_utf8 VALUES ('aaa'), ('ÁÂÃÄ');

CREATE TABLE t_koi8r (c1 VARBINARY(255), c2 VARBINARY(255));
SET CHARACTER_SET_CLIENT=koi8r,
 CHARACTER_SET_CONNECTION=cp1251,
 CHARACTER_SET_RESULTS=koi8r;
INSERT INTO t_koi8r (c1, c2) VALUES ('îÕ, ÚÁ ÒÙÂÁÌËÕ','îÕ, ÚÁ ÒÙÂÁÌËÕ');

SET NAMES utf8mb3;
SELECT * FROM t_latin1 ORDER BY 1;
SELECT * FROM t_utf8 ORDER BY 1;
SELECT hex(c1), hex(c2) from t_koi8r;
DROP DATABASE db1_charset;
CREATE DATABASE db1_charset;

USE db1_charset;
SET NAMES utf8mb3;
SELECT * FROM t_latin1 ORDER BY 1;
SELECT * FROM t_utf8 ORDER BY 1;
SELECT hex(c1), hex(c2) FROM t_koi8r ORDER BY 1;
DROP DATABASE db1_charset;


CREATE DATABASE db1_charset;
USE db1_charset;
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

USE db1_charset;
SELECT * FROM t_allcharsets;
DROP DATABASE db1_charset;
