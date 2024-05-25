SELECT schema_name, HEX(schema_name)
  FROM information_schema.schemata
  WHERE schema_name NOT IN ('mtr', 'sys')
  ORDER BY schema_name;
DROP DATABASE `ÃÂÃÂ½ÃÂ¾ÃÂÃÂ¿ÃÂ¢`;
DROP DATABASE `ÃÂÃÂÃÂÃÂ`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` (`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE `ÃÂÃÂ£ÃÂÃÂ½` (`ÃÂÃÂÃÂÃÂÃÂÃÂ` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE `ÃÂ«JÃÂ ÃÂ»ÃÂ9ÃÂ¯0` (`ÃÂÃÂÃÂ9ÃÂ¯3ÃÂ9ÃÂ¯4` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE IF NOT EXISTS `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±`(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE IF NOT EXISTS `ÃÂÃÂ£ÃÂÃÂ½` (`ÃÂÃÂÃÂÃÂÃÂÃÂ` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE IF NOT EXISTS `ÃÂ«JÃÂ ÃÂ»ÃÂ9ÃÂ¯0` (`ÃÂÃÂÃÂ9ÃÂ¯3ÃÂ9ÃÂ¯4` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE IF NOT EXISTS `ÃÂ9ÃÂ¯4ÃÂ9ÃÂ¯4ÃÂ9ÃÂ¯4` (`ÃÂ9ÃÂ¯3ÃÂ9ÃÂ¯3ÃÂ9ÃÂ¯3` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TEMPORARY TABLE `ÃÂ9ÃÂ¯6ÃÂ9ÃÂ¯7ÃÂ9ÃÂ¯8` (`ÃÂ9ÃÂ°5ÃÂ9ÃÂ°5ÃÂ9ÃÂ°5` CHAR(1)) DEFAULT CHARSET = gb18030;
DROP TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±`, `ÃÂÃÂ£ÃÂÃÂ½`, `ÃÂ«JÃÂ ÃÂ»ÃÂ9ÃÂ¯0`, `ÃÂ9ÃÂ¯4ÃÂ9ÃÂ¯4ÃÂ9ÃÂ¯4`, `ÃÂ9ÃÂ¯6ÃÂ9ÃÂ¯7ÃÂ9ÃÂ¯8`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` (`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` CHAR(5)) DEFAULT CHARSET = gb18030;
CREATE TABLE `ÃÂ«JÃÂ ÃÂ»ÃÂ9ÃÂ¯0` (`ÃÂ9ÃÂ¯1ÃÂ9ÃÂ¯2ÃÂ9ÃÂ¯3` CHAR(5)) DEFAULT CHARSET = gb18030;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` CHAR(1) FIRST;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂ¶ÃÂ¾` CHAR(1) AFTER `ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂÃÂ½` CHAR(1);
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD INDEX (`ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂ¶ÃÂ¾`);
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD PRIMARY KEY (`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`);
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` ADD UNIQUE (`ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂÃÂ½`);
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` CHANGE `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂ¶ÃÂ¾` `ÃÂ3ÃÂ2ÃÂ3ÃÂ2ÃÂÃÂ»` CHAR(1);
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` MODIFY `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂÃÂ½` CHAR(6);
SELECT * FROM `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±`;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` DROP INDEX `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂ¶ÃÂ¾`;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` DROP PRIMARY KEY;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±` DROP INDEX `ÃÂÃÂÃÂÃÂÃÂ¶ÃÂÃÂÃÂ½`;
SELECT * FROM `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±`;
DROP TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±`, `ÃÂ«JÃÂ ÃÂ»ÃÂ9ÃÂ¯0`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»` (`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` char(5)) DEFAULT CHARSET = gb18030;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 1, 'ÃÂ9ÃÂ¯9') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 2, 'ÃÂ9ÃÂ¯9') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 3, 'ÃÂ9ÃÂ¯9') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 4, 'ÃÂ9ÃÂ¯9') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 5, 'ÃÂ9ÃÂ¯9') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 1, 'ÃÂ5ÃÂ4') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 2, 'ÃÂ5ÃÂ4') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 5, 1, 'ÃÂ5ÃÂ4') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 1, ' ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 2, '  ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 3, '   ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 4, '    ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 5, '     ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 1, ' ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 2, '  ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 5, 1, ' ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 1, 'ÃÂÃÂµ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 2, 'ÃÂÃÂµÃÂÃÂµ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 3, 'ÃÂÃÂµÃÂÃÂµÃÂÃÂµ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 4, 'ÃÂÃÂµÃÂÃÂµÃÂÃÂµÃÂÃÂµ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 1, 5, 'ÃÂÃÂµÃÂÃÂµÃÂÃÂµÃÂÃÂµÃÂÃÂµ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 1, 'ÃÂ2ÃÂ8') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 4, 2, 'ÃÂ2ÃÂ8ÃÂ2ÃÂ8') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSERT(`ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»`, 5, 1, 'ÃÂ2ÃÂ8') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
UPDATE `ÃÂ±ÃÂ­ÃÂÃÂ»` SET `ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` = ('ÃÂÃÂ¸ÃÂÃÂ¨ÃÂÃÂ¹ÃÂÃÂµÃÂ2ÃÂ8');
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
DELETE FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE `ÃÂÃÂÃÂ¶ÃÂÃÂÃÂ»` = 'ÃÂ¿ÃÂÃÂ5ÃÂ3ÃÂÃÂ·ÃÂ5ÃÂ¼2ÃÂÃÂ¨';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
DELETE FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾` (c CHAR(5), v VARCHAR(10), t TEXT) DEFAULT CHARSET = gb18030;
SELECT * FROM `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾`;
DROP TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»`, `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾` (e ENUM('ÃÂ¿ÃÂ', 'ÃÂÃÂ', 'ÃÂÃÂ¿', 'ÃÂÃÂ¯', 'ÃÂ¾ÃÂ§'), INDEX(e)) DEFAULT CHARSET = gb18030;
INSERT INTO `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾` VALUES('ÃÂÃÂ¯'), ('ÃÂÃÂ'), ('ÃÂÃÂ¿'), ('ÃÂ¾ÃÂ§'), ('ÃÂ¿ÃÂ');
SELECT * FROM `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾`;
ALTER TABLE `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾` ADD c CHAR(1) NOT NULL FIRST;
DROP TABLE `ÃÂ±ÃÂ­ÃÂ¶ÃÂ¾`;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»` (c1 CHAR(20), INDEX(c1)) DEFAULT CHARSET = gb18030;
INSERT INTO `ÃÂ±ÃÂ­ÃÂÃÂ»` VALUES (' !"#$%&\'()*+,-./');
INSERT INTO `ÃÂ±ÃÂ­ÃÂÃÂ»` VALUES ('@ABCDEFGHIJKLMNO');
INSERT INTO `ÃÂ±ÃÂ­ÃÂÃÂ»` VALUES ('PQRSTUVWXYZ[\\]^_');
INSERT INTO `ÃÂ±ÃÂ­ÃÂÃÂ»` VALUES ('abcdefghijklmno');
INSERT INTO `ÃÂ±ÃÂ­ÃÂÃÂ»` VALUES ('pqrstuvwxyz{|}~');
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE ' %';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE '% %';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE '% ';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE 'ÃÂÃÂ®%';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE '%ÃÂqÃÂv%';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE '%ÃÂÃÂ';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE 'ÃÂ¼ÃÂÃÂ·ÃÂ¹ÃÂ¼ÃÂ ÃÂ½@ÃÂ½BÃÂ·ÃÂ»ÃÂ·ÃÂºÃÂ½FÃÂ½GÃÂ·ÃÂ¼ÃÂ½HÃÂ½JÃÂ½LÃÂ·ÃÂ¾ÃÂ½MÃÂ½NÃÂ½OÃÂ½YÃÂ½[ÃÂ½\%';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 LIKE '%ÃÂ¼ÃÂÃÂ·ÃÂ¹ÃÂ¼ÃÂ ÃÂ½@ÃÂ½BÃÂ·ÃÂ»ÃÂ·ÃÂºÃÂ½FÃÂ½GÃÂ·ÃÂ¼ÃÂ½HÃÂ½JÃÂ½LÃÂ·ÃÂ¾ÃÂ½MÃÂ½NÃÂ½OÃÂ½YÃÂ½[ÃÂ½\%';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 = 'ÃÂ0ÃÂ6ÃÂ0ÃÂ8ÃÂ0ÃÂ1ÃÂ0ÃÂ5ÃÂ0ÃÂ3ÃÂ0ÃÂ1ÃÂ0ÃÂ4ÃÂ0ÃÂ2ÃÂ0ÃÂ5ÃÂ0ÃÂ7ÃÂ0ÃÂ6ÃÂ0ÃÂ0ÃÂ0ÃÂ8ÃÂ0ÃÂ7ÃÂ0ÃÂ1ÃÂ0ÃÂ8ÃÂ0ÃÂ9ÃÂ0ÃÂ5ÃÂ0ÃÂ9ÃÂ0ÃÂ7';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 = 'ÃÂ]ÃÂÃÂ¿ÃÂ`ÃÂdÃÂÃÂÃÂlÃÂmÃÂqÃÂvÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂªÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 = 'ÃÂ½]ÃÂ½^ÃÂ½`ÃÂ½cÃÂ½dÃÂ½nÃÂ½oÃÂ½sÃÂ½tÃÂ½uÃÂ½vÃÂ½wÃÂ½yÃÂ½{ÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂ';
SELECT * FROM `ÃÂ±ÃÂ­ÃÂÃÂ»` WHERE c1 = 'ÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ½ÃÂÃÂ2ÃÂ6ÃÂ2ÃÂ8ÃÂ0ÃÂ5ÃÂ5ÃÂ¼2ÃÂ5ÃÂ0ÃÂ5ÃÂ1ÃÂ5ÃÂ2ÃÂ5ÃÂ3ÃÂ5ÃÂ4ÃÂ5ÃÂ3ÃÂ5ÃÂ4';
SELECT c1, CONVERT(c1 USING gb18030) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, CONVERT(c1 USING utf8mb4), CONVERT(CONVERT(c1 USING utf8mb4) USING gb18030) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
DROP TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»`;
CREATE TABLE t1a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t1b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t2a (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
CREATE TABLE t2b (c CHAR(1) PRIMARY KEY) DEFAULT CHARSET = gb18030;
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
CREATE TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»` (c1 CHAR(20), INDEX(c1)) DEFAULT CHARSET = gb18030;
SELECT c1, LENGTH(c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LPAD(c1, 20, 'ÃÂÃÂ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RPAD(c1, 20, 'ÃÂ5ÃÂ¼2') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂÃÂ»') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂ¶ÃÂ¾') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂÃÂ½') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂÃÂ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂ5ÃÂ¼2') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂ5ÃÂ4') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT INSTR(c1, 'ÃÂ3ÃÂ1') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 0) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 2) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 3) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 4) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 5) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 6) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, LEFT(c1, 7) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 0) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 2) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 3) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 4) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 5) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 6) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, RIGHT(c1, 7) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT REPLACE(c1, 'ÃÂÃÂ»', 'ÃÂÃÂ»ÃÂÃÂ»') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT REPLACE(c1, 'ÃÂÃÂ', 'ÃÂÃÂÃÂÃÂ') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT REPLACE(c1, 'ÃÂ5ÃÂ4', 'ÃÂ5ÃÂ4ÃÂ5ÃÂ4') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT REPLACE(c1, 'ÃÂ5ÃÂ¼2', 'ÃÂ5ÃÂ¼2ÃÂ5ÃÂ¼2') FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, TRIM(TRAILING 'ÃÂ5ÃÂ2' FROM c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, TRIM(LEADING 'ÃÂ5ÃÂ2' FROM c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, TRIM(BOTH 'ÃÂ5ÃÂ2' FROM c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT c1, TRIM(c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
SELECT REVERSE(c1) FROM `ÃÂ±ÃÂ­ÃÂÃÂ»`;
DROP TABLE `ÃÂ±ÃÂ­ÃÂÃÂ»`;
CREATE TABLE t1 (c VARCHAR(10)) DEFAULT CHARSET = gb18030;
SELECT c, COUNT(c) FROM t1 GROUP BY c;
DROP TABLE t1;
CREATE TABLE t1 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
CREATE TABLE t2 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
CREATE TABLE t3 (`ÃÂ3ÃÂ2` CHAR(1), `ÃÂ9ÃÂ°5` CHAR(1), `ÃÂ¶ÃÂ` CHAR(1)) DEFAULT CHARSET = gb18030;
CREATE TABLE t4 (c1 CHAR(3)) DEFAULT CHARSET = gb18030;
INSERT INTO t1 VALUES ('xxx');
INSERT INTO t3 VALUES ('x', 'x', 'x'), ('x', 'x', 'x'), ('y', 'y', 'y'), ('y', 'y', 'y'), ('z', 'z', 'z'), ('z', 'z', 'z');
PREPARE stmt1 FROM 'SELECT ? FROM t3';
PREPARE stmt2 FROM 'SELECT * FROM t3 ORDER BY ?';
PREPARE stmt3 FROM 'SELECT COUNT(*) FROM t3 GROUP BY ?';
PREPARE stmt4 FROM 'SELECT CHAR_LENGTH(?)';
PREPARE stmt5 FROM 'SELECT CHARSET(?)';
PREPARE stmt6 FROM 'SELECT INSERT(c1,1,1,?) FROM t1';
PREPARE stmt7 FROM 'SELECT INSTR(c1,?) FROM t2';
PREPARE stmt8 FROM 'SELECT LOCATE(?,c1) FROM t2';
PREPARE stmt9 FROM 'SELECT LPAD(c1,9,?) FROM t1';
PREPARE stmt10 FROM 'SELECT REPLACE(c1,?,\'x\') FROM t2';
PREPARE stmt11 FROM 'SELECT REPLACE(c1,\'x\',?) FROM t1';
PREPARE stmt12 FROM 'SELECT RPAD(c1,9,?) FROM t1';
PREPARE stmt13 FROM 'UPDATE t4 SET c1=\'x\' WHERE c1=?';
PREPARE stmt14 FROM 'UPDATE t4 SET c1=? WHERE c1=\'x\'';
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
SELECT * FROM t4;
DEALLOCATE PREPARE stmt1;
DEALLOCATE PREPARE stmt2;
DEALLOCATE PREPARE stmt3;
DEALLOCATE PREPARE stmt4;
DEALLOCATE PREPARE stmt5;
DEALLOCATE PREPARE stmt6;
DEALLOCATE PREPARE stmt7;
DEALLOCATE PREPARE stmt8;
DEALLOCATE PREPARE stmt9;
DEALLOCATE PREPARE stmt10;
DEALLOCATE PREPARE stmt11;
DEALLOCATE PREPARE stmt12;
DEALLOCATE PREPARE stmt13;
DEALLOCATE PREPARE stmt14;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
CREATE TABLE `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±ÃÂÃÂ»` (id INT PRIMARY KEY, c CHAR(5), b BINARY(50), v VARBINARY(100)) DEFAULT CHARSET = gb18030;
SELECT * FROM `ÃÂ±ÃÂ­ÃÂ¸ÃÂ±ÃÂÃÂ»`;
