select hex('a'), hex('a ');
select 'c' like '\_' as want0;
create table t1 (c1 char(10) character set utf32 collate utf32_bin);
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_unicode_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_icelandic_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_latvian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_romanian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_slovenian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_polish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_estonian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_spanish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_swedish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_turkish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_czech_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_danish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_lithuanian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_slovak_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_spanish2_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_roman_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_esperanto_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_hungarian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_croatian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_german2_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_unicode_520_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf32_vietnamese_ci;
drop table t1;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf32 COLLATE utf32_general_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (_ucs2 0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE _utf32 0x0000039C00000025 COLLATE utf32_general_ci;
INSERT INTO t1 VALUES (CONVERT(_ucs2 0x039C03C903B4 USING utf8mb3));
SELECT * FROM t1 WHERE c LIKE _utf32 0x0000039C00000025
COLLATE utf32_general_ci ORDER BY c;
DROP TABLE t1;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (_ucs2 0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE _utf32 0x0000039C00000025 COLLATE utf32_unicode_ci;
INSERT INTO t1 VALUES (_ucs2 0x039C03C903B4);
SELECT * FROM t1 WHERE c LIKE _utf32 0x0000039C00000025
COLLATE utf32_unicode_ci ORDER BY c;
DROP TABLE t1;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (_ucs2 0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE CONVERT(_ucs2 0x039C0025 USING utf32) COLLATE utf32_unicode_ci;
INSERT INTO t1 VALUES (CONVERT(_ucs2 0x039C03C903B4 USING utf8mb3));
SELECT * FROM t1 WHERE c LIKE CONVERT(_ucs2 0x039C0025 USING utf32)
COLLATE utf32_unicode_ci ORDER BY c;
DROP TABLE t1;
CREATE TABLE t1 (id int, a varchar(30) character set utf32);
INSERT INTO t1 VALUES (1, _ucs2 0x01310069), (2, _ucs2 0x01310131);
INSERT INTO t1 VALUES (3, _ucs2 0x00690069), (4, _ucs2 0x01300049);
INSERT INTO t1 VALUES (5, _ucs2 0x01300130), (6, _ucs2 0x00490049);
SELECT a, length(a) la, @l:=lower(a) l, length(@l) ll, @u:=upper(a) u, length(@u) lu
FROM t1 ORDER BY id;
ALTER TABLE t1 MODIFY a VARCHAR(30) character set utf32 collate utf32_turkish_ci;
SELECT a, length(a) la, @l:=lower(a) l, length(@l) ll, @u:=upper(a) u, length(@u) lu
FROM t1 ORDER BY id;
DROP TABLE t1;
CREATE TABLE t1 (a TEXT CHARACTER SET utf32 COLLATE utf32_turkish_ci NOT NULL);
INSERT INTO t1 VALUES ('a'), ('b');
CREATE TABLE t2 (b VARBINARY(5) NOT NULL);
INSERT INTO t2 VALUEs (0x082837),(0x082837);
SELECT * FROM t1,t2 WHERE a LIKE b;
SELECT 1 FROM t1 AS t1_0 NATURAL LEFT OUTER JOIN t2 AS t2_0
RIGHT JOIN t1 AS t1_1 ON t1_0.a LIKE t2_0.b;
DROP TABLE t1,t2;
select hex(weight_string(_utf32 0x10000 collate utf32_unicode_ci));
select hex(weight_string(_utf32 0x10001 collate utf32_unicode_ci));
