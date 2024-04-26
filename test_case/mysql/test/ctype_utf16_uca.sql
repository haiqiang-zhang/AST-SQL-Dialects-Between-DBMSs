DROP TABLE IF EXISTS t1;

set names utf8mb3;
set collation_connection=utf16_unicode_ci;
select hex('a'), hex('a ');

--
-- Bug #6787 LIKE not working properly with _ and utf8mb3 data
--
select 'c' like '\_' as want0;

create table t1 (c1 char(10) character set utf16 collate utf16_bin);

select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_unicode_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_icelandic_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_latvian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_romanian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_slovenian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_polish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_estonian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_spanish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_swedish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_turkish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_czech_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_danish_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_lithuanian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_slovak_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_spanish2_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_roman_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_esperanto_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_hungarian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_croatian_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_german2_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_unicode_520_ci;
select group_concat(c1 order by binary c1 separator '') from t1 group by c1 collate utf16_vietnamese_ci;

drop table t1;

--
-- Bug#5324
--
SET NAMES utf8mb3;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf16 COLLATE utf16_general_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025 COLLATE utf16_general_ci;
INSERT INTO t1 VALUES (0x039C03C903B4);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025
COLLATE utf16_general_ci ORDER BY c;
DROP TABLE t1;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf16 COLLATE utf16_unicode_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025 COLLATE utf16_unicode_ci;
INSERT INTO t1 VALUES (0x039C03C903B4);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025
COLLATE utf16_unicode_ci ORDER BY c;
DROP TABLE t1;
CREATE TABLE t1 (c varchar(150) CHARACTER SET utf16 COLLATE utf16_unicode_ci NOT NULL, INDEX (c));
INSERT INTO t1 VALUES (0x039C03C903B403B11F770308);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025 COLLATE utf16_unicode_ci;
INSERT INTO t1 VALUES (0x039C03C903B4);
SELECT * FROM t1 WHERE c LIKE _utf16 0x039C0025
COLLATE utf16_unicode_ci ORDER BY c;
DROP TABLE t1;


SET NAMES utf8mb3;
SET @test_character_set='utf16';
SET @test_collation='utf16_swedish_ci';

SET collation_connection='utf16_unicode_ci';

--
-- Check UPPER/LOWER changing length
--
-- Result shorter than argument
CREATE TABLE t1 (id int, a varchar(30) character set utf16);
INSERT INTO t1 VALUES (1, 0x01310069), (2, 0x01310131);
INSERT INTO t1 VALUES (3, 0x00690069), (4, 0x01300049);
INSERT INTO t1 VALUES (5, 0x01300130), (6, 0x00490049);
SELECT a, length(a) la, @l:=lower(a) l, length(@l) ll, @u:=upper(a) u, length(@u) lu
FROM t1 ORDER BY id;
ALTER TABLE t1 MODIFY a VARCHAR(30) character set utf16 collate utf16_turkish_ci;
SELECT a, length(a) la, @l:=lower(a) l, length(@l) ll, @u:=upper(a) u, length(@u) lu
FROM t1 ORDER BY id;
DROP TABLE t1;

--
-- Test basic regex functionality
--
set collation_connection=utf16_unicode_ci;

--
-- Test my_like_range and contractions
--
SET collation_connection=utf16_czech_ci;

set collation_connection=utf16_unicode_ci;
select hex(weight_string(_utf16 0xD800DC00 collate utf16_unicode_ci));
select hex(weight_string(_utf16 0xD800DC01 collate utf16_unicode_ci));

set @@collation_connection=utf16_czech_ci;

--
-- WL#4013 Unicode german2 collation
--
SET NAMES utf8mb3;
SET collation_connection=utf16_german2_ci;
SET NAMES utf8mb4;
SET collation_connection=utf16_unicode_520_ci;
