
SET NAMES utf8mb4;
SET CHARACTER_SET_DATABASE = utf8mb4;

CREATE DATABASE `中文`;
CREATE DATABASE `数据库`;

SELECT schema_name, HEX(schema_name)
  FROM information_schema.schemata
  WHERE schema_name NOT IN ('mtr', 'sys')
  ORDER BY schema_name;

USE `数据库`;
USE `中文`;

DROP DATABASE `数据库`;
DROP DATABASE `中文`;

USE test;

CREATE TABLE `表格` (`字段一` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `模式` (`列列列` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `隞嗷㐁` (`列㐄㐅` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `表格`(`字段一` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `模式` (`列列列` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `隞嗷㐁` (`列㐄㐅` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE IF NOT EXISTS `㐅㐅㐅` (`㐄㐄㐄` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TEMPORARY TABLE `㐇㐈㐉` (`㐐㐐㐐` CHAR(1)) DEFAULT CHARSET = utf8mb4;

DROP TABLE `表格`, `模式`, `隞嗷㐁`, `㐅㐅㐅`, `㐇㐈㐉`;
CREATE TABLE `表格` (`字段一` CHAR(5)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE `隞嗷㐁` (`㐂㐃㐄` CHAR(5)) DEFAULT CHARSET = utf8mb4;

INSERT INTO `表格` VALUES ('一二三四五'), ('六七八九十'), ('㐅㐆㐇㐈㐉');
INSERT INTO `隞嗷㐁` VALUES ('焊䏷菡釬'), ('漢汉漢汉漢'), ('㐃㐄㐇㐈㐀');

ALTER TABLE `表格` ADD `新字段一` CHAR(1) FIRST;
ALTER TABLE `表格` ADD `新字段二` CHAR(1) AFTER `字段一`;
ALTER TABLE `表格` ADD `新字段三` CHAR(1);
ALTER TABLE `表格` ADD INDEX (`新字段二`);
ALTER TABLE `表格` ADD PRIMARY KEY (`字段一`);
ALTER TABLE `表格` ADD UNIQUE (`新字段三`);
ALTER TABLE `表格` CHANGE `新字段二` `䑃䑃一` CHAR(1);
ALTER TABLE `表格` MODIFY `新字段三` CHAR(6);
SELECT * FROM `表格`;

ALTER TABLE `表格` DROP INDEX `新字段二`;
ALTER TABLE `表格` DROP PRIMARY KEY;
ALTER TABLE `表格` DROP INDEX `新字段三`;
ALTER TABLE `表格` DROP `䑃䑃一`;
ALTER TABLE `表格` DROP `新字段一`;
ALTER TABLE `表格` DROP `新字段三`;
SELECT * FROM `表格`;

DROP TABLE `表格`, `隞嗷㐁`;
CREATE TABLE `表一` (`字段一` char(5)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表一` VALUES ('繓𠻟作𤈼阼');
SELECT INSERT(`字段一`, 1, 1, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '㐊') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '㐊') FROM `表一`;

SELECT INSERT(`字段一`, 4, 1, '𠻠') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '𠻠') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, '𠻠') FROM `表一`;

SELECT INSERT(`字段一`, 1, 1, ' ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '  ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '   ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '    ') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '     ') FROM `表一`;

SELECT INSERT(`字段一`, 4, 1, ' ') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '  ') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, ' ') FROM `表一`;

SELECT INSERT(`字段一`, 1, 1, '岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 2, '岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 3, '岝岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 4, '岝岝岝岝') FROM `表一`;
SELECT INSERT(`字段一`, 1, 5, '岝岝岝岝岝') FROM `表一`;

SELECT INSERT(`字段一`, 4, 1, '𠀂') FROM `表一`;
SELECT INSERT(`字段一`, 4, 2, '𠀂𠀂') FROM `表一`;
SELECT INSERT(`字段一`, 5, 1, '𠀂') FROM `表一`;

UPDATE `表一` SET `字段一` = ('坐阼座岝𠀂');
SELECT * FROM `表一`;
DELETE FROM `表一` WHERE `字段一` = '繓𠻟作𤈼阼';
SELECT * FROM `表一`;
DELETE FROM `表一`;
SELECT * FROM `表一`;
CREATE TABLE `表二` (c CHAR(5), v VARCHAR(10), t TEXT) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表二` VALUES ('定长𤈼𠻜字', '变长𠀂𨡃𤈼字符串字段', '文本大对象𠻞𠻟𠻠字段');
SELECT * FROM `表二`;

DROP TABLE `表一`, `表二`;
CREATE TABLE `表二` (e ENUM('口', '日', '目', '田', '晶'), INDEX(e)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表二` VALUES('田'), ('日'), ('目'), ('晶'), ('口');
SELECT * FROM `表二`;
ALTER TABLE `表二` ADD c CHAR(1) NOT NULL FIRST;
DROP TABLE `表二`;
CREATE TABLE `表一` (c1 CHAR(20), INDEX(c1)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・・ºª©®™');
INSERT INTO `表一` VALUES ('¤№・・・・・・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・ΆΈΉΊΪ・Ό・ΎΫ・Ώ・・・');
INSERT INTO `表一` VALUES ('・άέήίϊΐόςύϋΰώ・・・・・・・');
INSERT INTO `表一` VALUES ('・・・・・・・・・・・・・・ЂЃЄЅІЇ');
INSERT INTO `表一` VALUES ('ЈЉЊЋЌЎЏ・・・・・・・・・・・・・');
INSERT INTO `表一` VALUES (' !"--$%&\'()*+,-./');
INSERT INTO `表一` VALUES ('0123456789:;
INSERT INTO `表一` VALUES ('@ABCDEFGHIJKLMNO');
INSERT INTO `表一` VALUES ('PQRSTUVWXYZ[\\]^_');
INSERT INTO `表一` VALUES ('abcdefghijklmno');
INSERT INTO `表一` VALUES ('pqrstuvwxyz{|}~');
INSERT INTO `表一` VALUES ('・ÁÀÄÂĂǍĀĄÅÃĆĈČÇĊĎÉÈË');
INSERT INTO `表一` VALUES ('ÊĚĖĒĘ・ĜĞĢĠĤÍÌÏÎǏİĪĮĨ');
INSERT INTO `表一` VALUES ('ĴĶĹĽĻŃŇŅÑÓÒÖÔǑŐŌÕŔŘŖ');
INSERT INTO `表一` VALUES ('ŚŜŠŞŤŢÚÙÜÛŬǓŰŪŲŮŨǗǛǙ');
INSERT INTO `表一` VALUES ('ǕŴÝŸŶŹŽŻ・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・áàäâăǎāąåãćĉčçċďéèë');
INSERT INTO `表一` VALUES ('êěėēęǵĝğ・ġĥíìïîǐ・īįĩ');
INSERT INTO `表一` VALUES ('ĵķĺľļńňņñóòöôǒőōõŕřŗ');
INSERT INTO `表一` VALUES ('śŝšşťţúùüûŭǔűūųůũǘǜǚ');
INSERT INTO `表一` VALUES ('ǖŵýÿŷźžż・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('・丂丄丅丌丒丟丣两丨丫丮丯丰丵乀乁乄乇乑');
INSERT INTO `表一` VALUES ('乚乜乣乨乩乴乵乹乿亍亖亗亝亯亹仃仐仚仛仠');
INSERT INTO `表一` VALUES ('仡仢仨仯仱仳仵份仾仿伀伂伃伈伋伌伒伕伖众');
INSERT INTO `表一` VALUES ('伙伮伱你伳伵伷伹伻伾佀佂佈佉佋佌佒佔佖佘');
INSERT INTO `表一` VALUES ('佟佣佪佬佮佱佷佸佹佺佽佾侁侂侄・・・・・');
INSERT INTO `表一` VALUES ('・黸黿鼂鼃鼉鼏鼐鼑鼒鼔鼖鼗鼙鼚鼛鼟鼢鼦鼪');
INSERT INTO `表一` VALUES ('鼫鼯鼱鼲鼴鼷鼹鼺鼼鼽鼿齁齃齄齅齆齇齓齕齖');
INSERT INTO `表一` VALUES ('齗齘齚齝齞齨齩齭齮齯齰齱齳齵齺齽龏龐龑龒');
INSERT INTO `表一` VALUES ('龔龖龗龞龡龢龣龥・・・・・・・・・・・・');
INSERT INTO `表一` VALUES ('龔龖龗龞龡龢龣龥𠀀𠀂𨡃𤈼𠻜𠻝𠻞𠻟𠻠𠻟𠻠');
SELECT * FROM `表一`;
SELECT * FROM `表一` WHERE c1 LIKE ' %';
SELECT * FROM `表一` WHERE c1 LIKE '% %';
SELECT * FROM `表一` WHERE c1 LIKE '% ';
SELECT * FROM `表一` WHERE c1 LIKE '仡%';
SELECT * FROM `表一` WHERE c1 LIKE '%乹乿%';
SELECT * FROM `表一` WHERE c1 LIKE '%佘';
SELECT * FROM `表一` WHERE c1 LIKE '鼫鼯鼱鼲鼴鼷鼹鼺鼼鼽鼿齁齃齄齅齆齇齓齕齖%';
SELECT * FROM `表一` WHERE c1 LIKE '%鼫鼯鼱鼲鼴鼷鼹鼺鼼鼽鼿齁齃齄齅齆齇齓齕齖%';
SELECT * FROM `表一` WHERE c1 LIKE '%鼫鼯鼱鼲鼴鼷鼹鼺鼼鼽鼿齁齃齄齅齆齇齓齕齖';
SELECT * FROM `表一` WHERE c1 = 'ĴĶĹĽĻŃŇŅÑÓÒÖÔǑŐŌÕŔŘŖ';
SELECT * FROM `表一` WHERE c1 = '乚乜乣乨乩乴乵乹乿亍亖亗亝亯亹仃仐仚仛仠';
SELECT * FROM `表一` WHERE c1 = '齗齘齚齝齞齨齩齭齮齯齰齱齳齵齺齽龏龐龑龒';
SELECT * FROM `表一` WHERE c1 = '龔龖龗龞龡龢龣龥𠀀𠀂𨡃𤈼𠻜𠻝𠻞𠻟𠻠𠻟𠻠';
SELECT c1, CONVERT(c1 USING gb18030) FROM `表一`;
SELECT c1, CONVERT(c1 USING utf8mb4), CONVERT(CONVERT(c1 USING utf8mb4) USING gb18030) FROM `表一`;

DROP TABLE `表一`;
CREATE TABLE t1a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = utf8mb4;
CREATE TABLE t1b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = utf8mb4;

CREATE TABLE t2a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = utf8mb4;
CREATE TABLE t2b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = utf8mb4;

INSERT INTO t1a VALUES ('双'), ('字'), ('𤈼'), ('䑃');
INSERT INTO t1b VALUES ('双');

INSERT INTO t2a VALUES ('𠻠'), ('齳'), ('䑂');
INSERT INTO t2b VALUES ('𠻠');

SELECT c FROM t1a WHERE c IN (SELECT c FROM t1b);
SELECT c FROM t1a WHERE EXISTS (SELECT c FROM t1b WHERE t1a.c = t1b.c);
SELECT c FROM t1a WHERE NOT EXISTS (SELECT c FROM t1b WHERE t1a.c = t1b.c);

SELECT c FROM t2a WHERE c IN (SELECT c FROM t2b);
SELECT c FROM t2a WHERE EXISTS (SELECT c FROM t2b WHERE t2a.c = t2b.c);
SELECT c FROM t2a WHERE NOT EXISTS (SELECT c FROM t2b WHERE t2a.c = t2b.c);
SELECT * FROM t1a JOIN t1b;
SELECT * FROM t1a INNER JOIN t1b;
SELECT * FROM t1a JOIN t1b USING (c);
SELECT * FROM t1a INNER JOIN t1b USING (c);
SELECT * FROM t1a CROSS JOIN t1b;
SELECT * FROM t1a LEFT JOIN t1b USING (c);
SELECT * FROM t1a LEFT JOIN t1b ON (t1a.c = t1b.c);
SELECT * FROM t1b RIGHT JOIN t1a USING (c);
SELECT * FROM t1b RIGHT JOIN t1a ON (t1a.c = t1b.c);
SELECT * FROM t2a JOIN t2b;
SELECT * FROM t2a INNER JOIN t2b;
SELECT * FROM t2a JOIN t2b USING (c);
SELECT * FROM t2a INNER JOIN t2b USING (c);
SELECT * FROM t2a CROSS JOIN t2b;
SELECT * FROM t2a LEFT JOIN t2b USING (c);
SELECT * FROM t2a LEFT JOIN t2b ON (t2a.c = t2b.c);
SELECT * FROM t2b RIGHT JOIN t2a USING (c);
SELECT * FROM t2b RIGHT JOIN t2a ON (t2a.c = t2b.c);

DROP TABLE t1a, t1b, t2a, t2b;
CREATE TABLE `表一` (c1 CHAR(20), INDEX(c1)) DEFAULT CHARSET = utf8mb4;

INSERT INTO `表一` VALUES ('12345678900987654321'), ('一二三四五伍肆叁贰壹'), ('六七八'), ('九十'), ('百'), ('𠻜𠻝𠻞𠻟');
INSERT INTO `表一` VALUES ('䑃'), ('一䑃二三四'), ('𠀂𨡃');
SELECT c1, LENGTH(c1) FROM `表一`;
SELECT c1, LPAD(c1, 20, '中') FROM `表一`;
SELECT c1, RPAD(c1, 20, '𤈼') FROM `表一`;

INSERT INTO `表一` VALUES ('一䑃二𤈼三𠻠四');
SELECT INSTR(c1, '一') FROM `表一`;
SELECT INSTR(c1, '二') FROM `表一`;
SELECT INSTR(c1, '三') FROM `表一`;
SELECT INSTR(c1, '四') FROM `表一`;
SELECT INSTR(c1, '𤈼') FROM `表一`;
SELECT INSTR(c1, '𠻠') FROM `表一`;
SELECT INSTR(c1, '䑃') FROM `表一`;

SELECT c1, LEFT(c1, 0) FROM `表一`;
SELECT c1, LEFT(c1, 1) FROM `表一`;
SELECT c1, LEFT(c1, 2) FROM `表一`;
SELECT c1, LEFT(c1, 3) FROM `表一`;
SELECT c1, LEFT(c1, 4) FROM `表一`;
SELECT c1, LEFT(c1, 5) FROM `表一`;
SELECT c1, LEFT(c1, 6) FROM `表一`;
SELECT c1, LEFT(c1, 7) FROM `表一`;

SELECT c1, RIGHT(c1, 0) FROM `表一`;
SELECT c1, RIGHT(c1, 1) FROM `表一`;
SELECT c1, RIGHT(c1, 2) FROM `表一`;
SELECT c1, RIGHT(c1, 3) FROM `表一`;
SELECT c1, RIGHT(c1, 4) FROM `表一`;
SELECT c1, RIGHT(c1, 5) FROM `表一`;
SELECT c1, RIGHT(c1, 6) FROM `表一`;
SELECT c1, RIGHT(c1, 7) FROM `表一`;

SELECT REPLACE(c1, '一', '一一') FROM `表一`;
SELECT REPLACE(c1, '四', '四四') FROM `表一`;
SELECT REPLACE(c1, '𠻠', '𠻠𠻠') FROM `表一`;
SELECT REPLACE(c1, '𤈼', '𤈼𤈼') FROM `表一`;

INSERT INTO `表一` VALUES ('一䑃二𤈼三𠻟');
INSERT INTO `表一` VALUES ('一䑃二𤈼三𠻟𠻞');
INSERT INTO `表一` VALUES ('一䑃二𤈼三𠻟𠻞𠻞');
INSERT INTO `表一` VALUES ('一䑃二𤈼三𠻟𠻞𠻞𠻞');
INSERT INTO `表一` VALUES ('𠻞一䑃二𤈼三𠻟');
INSERT INTO `表一` VALUES ('𠻞𠻞一䑃二𤈼三𠻟');
INSERT INTO `表一` VALUES ('𠻞𠻞𠻞一䑃二𤈼三𠻟');
INSERT INTO `表一` VALUES ('   一䑃二𤈼三𠻟   ');
SELECT c1, TRIM(TRAILING '𠻞' FROM c1) FROM `表一`;
SELECT c1, TRIM(LEADING '𠻞' FROM c1) FROM `表一`;
SELECT c1, TRIM(BOTH '𠻞' FROM c1) FROM `表一`;
SELECT c1, TRIM(c1) FROM `表一`;
SELECT REVERSE(c1) FROM `表一`;

DROP TABLE `表一`;
CREATE TABLE t1 (c VARCHAR(10)) DEFAULT CHARSET = utf8mb4;
INSERT INTO t1 VALUES ('嬽仛砻'), ('櫶'), ('怑橷'), ('獣厘濸氻'), ('嚏'), ('𠻠'), ('怑橷');
SELECT c, COUNT(c) FROM t1 GROUP BY c;
DROP TABLE t1;

CREATE TABLE t1 (c1 CHAR(3)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE t2 (c1 CHAR(3)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE t3 (`䑃` CHAR(1), `㐐` CHAR(1), `段` CHAR(1)) DEFAULT CHARSET = utf8mb4;
CREATE TABLE t4 (c1 CHAR(3)) DEFAULT CHARSET = utf8mb4;

INSERT INTO t1 VALUES ('xxx');
INSERT INTO t2 VALUES ('𠻜㐉列');
INSERT INTO t3 VALUES ('x', 'x', 'x'), ('x', 'x', 'x'), ('y', 'y', 'y'), ('y', 'y', 'y'), ('z', 'z', 'z'), ('z', 'z', 'z');
INSERT INTO t4 VALUES ('𠻜'), ('㐉'), ('列');

-- Chinese parameter for column name
-- the parameter for stmt is not interpreted as column name
PREPARE stmt1 FROM 'SELECT ? FROM t3';

SET @arg = '𠻜';
SELECT * FROM t4;
SELECT * FROM t4;


SET @arg = '㐉';
SELECT * FROM t4;
SELECT * FROM t4;


SET @arg = '列';
SELECT * FROM t4;
SELECT * FROM t4;

DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
CREATE TABLE `表格一` (id INT PRIMARY KEY, c CHAR(5), b BINARY(50), v VARBINARY(100)) DEFAULT CHARSET = utf8mb4;
INSERT INTO `表格一` VALUES(1, 'ab䶩匼串', '123345', '字符䶩匼串'), (2, '僜𠀀𠀂刓', '乗俓僜刓5C', '㐄㐅㐈㐉㐁'), (3, '𨡃𤈼𠻜', '𠀀𠀂𨡃𤈼𠻜', '𠻝𠻞𠻟𠻠');
SELECT * FROM `表格一`;
DROP TABLE `表格二`;
DROP TABLE `表格二`;
DROP TABLE `表格二`;
DROP TABLE `表格二`, `表格一`;