SELECT 
  hex(a), 
  hex(@u:=convert(a using utf8mb3)),
  hex(@l:=convert(@u using latin1)),
  a=@l FROM t1;
DROP TABLE t1;
SELECT 1 as ÃÂ, 2 as ÃÂ, 3 as ÃÂ, 4 as ÃÂ, 5 as ÃÂ, 6 as ÃÂ, 7 as ÃÂ, 8 as ÃÂ;
CREATE TABLE ÃÂa (a int);
SELECT 'ÃÂa' as str;
SELECT convert(@str collate latin1_bin using utf8mb3);
SELECT convert(@str collate latin1_general_ci using utf8mb3);
SELECT convert(@str collate latin1_german1_ci using utf8mb3);
SELECT convert(@str collate latin1_danish_ci using utf8mb3);
SELECT convert(@str collate latin1_spanish_ci using utf8mb3);
SELECT convert(@str collate latin1_german2_ci using utf8mb3);
SELECT convert(@str collate latin1_swedish_ci using utf8mb3);
DROP TABLE IF EXISTS `abcÃÂ¿def`;
CREATE TABLE `abcÃÂ¿def` (i int);
INSERT INTO `abcÃÂ¿def` VALUES (1);
INSERT INTO abcÃÂ¿def VALUES (2);
SELECT * FROM `abcÃÂ¿def`;
SELECT * FROM abcÃÂ¿def;
DROP TABLE `abcÃÂ¿def`;
select hex(cast(_ascii 0x7f as char(1) character set latin1));
SELECT '' LIKE '' ESCAPE EXPORT_SET(1, 1, 1, 1, '');
