drop table if exists t1;
select collation_name, character_set_name, id from information_schema.collations where id>256 order by id;
CREATE TABLE t1 AS SELECT REPEAT(' ', 16) AS a LIMIT 0;
INSERT INTO t1 VALUES ('012345'),('001234'),('000123'),('000012'),('000001');
INSERT INTO t1 VALUES ('12345'),('01234'),('00123'),('00012'),('00001');
INSERT INTO t1 VALUES ('1234'),('0123'),('0012'),('0001');
INSERT INTO t1 VALUES ('123'),('012'),('001');
INSERT INTO t1 VALUES ('12'),('01');
INSERT INTO t1 VALUES ('1'),('9');
INSERT INTO t1 VALUES ('a'),('b'),('c'),('d'),('e');
INSERT INTO t1 VALUES ('a'),('~'),('!'),('@'),('#'),('$'),('%'),('^');
INSERT INTO t1 VALUES ('"'),('\''),('?');
INSERT INTO t1 VALUES ('ch'),('k'),('cs'),('ccs'),('cscs');
INSERT INTO t1 VALUES ('aa-'),('ab-'),('ac-'),('ad-'),('ae-'),('af-'),('az-');
INSERT INTO t1 VALUES ('lp-fni'),('lp-lni');
INSERT INTO t1 VALUES ('lp-fpi'),('lp-lpi');
INSERT INTO t1 VALUES ('lp-fsi'),('lp-lsi');
INSERT INTO t1 VALUES ('lp-fti'),('lp-lti');
INSERT INTO t1 VALUES ('lp-ft'),('lp-lt');
INSERT INTO t1 VALUES ('lp-fv'),('lp-lv');
INSERT INTO t1 VALUES ('lb-fni'),('lb-lni');
INSERT INTO t1 VALUES ('lb-fv'),('lb-lv');
INSERT INTO t1 VALUES (_ucs2 0x3106),(_ucs2 0x3110), (_ucs2 0x3111), (_ucs2 0x3112);
INSERT INTO t1 VALUES (_ucs2 0x32A3), (_ucs2 0x3231);
INSERT INTO t1 VALUES (_ucs2 0x84D9), (_ucs2 0x98F5), (_ucs2 0x7CF3), (_ucs2 0x5497);
SELECT a, HEX(WEIGHT_STRING(a)) FROM t1 ORDER BY a, LENGTH(a), BINARY a;
SELECT a, HEX(WEIGHT_STRING(a)) FROM t1 ORDER BY a, LENGTH(a), BINARY(a);
DROP TABLE t1;
CREATE TABLE t1 AS SELECT REPEAT(' ', 10) AS a LIMIT 0;
INSERT INTO t1 VALUES ('\\'),('u'),('x'),('X');
SELECT a, HEX(WEIGHT_STRING(a)) FROM t1 ORDER BY a, LENGTH(a), BINARY(a);
DROP TABLE t1;
CREATE TABLE t1 AS SELECT REPEAT (' ', 10) AS a LIMIT 0;
INSERT INTO t1 VALUES (_ucs2 0x09FA), (_ucs2 0x09F8), (_ucs2 0x09F9), (_ucs2 0x09F2);
INSERT INTO t1 VALUES (_ucs2 0x09DC), (_ucs2 0x09A109BC);
INSERT INTO t1 VALUES (_ucs2 0x09A2), (_ucs2 0x09DD), (_ucs2 0x09A209BC);
INSERT INTO t1 VALUES (_ucs2 0x09A3);
SELECT HEX(WEIGHT_STRING(a)), HEX(CONVERT(a USING ucs2)), HEX(a)
FROM t1 ORDER BY a, BINARY a;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT REPEAT (' ', 10) AS a LIMIT 0;
INSERT INTO t1 VALUES
(_ucs2 0x0985),(_ucs2 0x0986),(_ucs2 0x0987),(_ucs2 0x0988),
(_ucs2 0x0989),(_ucs2 0x098A),(_ucs2 0x098B),(_ucs2 0x09E0),
(_ucs2 0x098C),(_ucs2 0x09E1),(_ucs2 0x098F),(_ucs2 0x0990),
(_ucs2 0x0993);
INSERT INTO t1 VALUES
(_ucs2 0x0994),(_ucs2 0x0982),(_ucs2 0x0983),(_ucs2 0x0981),
(_ucs2 0x099509CD), (_ucs2 0x099609CD), (_ucs2 0x099709CD), (_ucs2 0x099809CD),
(_ucs2 0x099909CD), (_ucs2 0x099A09CD), (_ucs2 0x099B09CD), (_ucs2 0x099C09CD),
(_ucs2 0x099D09CD), (_ucs2 0x099E09CD), (_ucs2 0x099F09CD), (_ucs2 0x09A009CD),
(_ucs2 0x09A109CD), (_ucs2 0x09A209CD), (_ucs2 0x09A309CD),
(_ucs2 0x09CE), (_ucs2 0x09A409CD200D), (_ucs2 0x09A409CD),
(_ucs2 0x09A509CD),(_ucs2 0x09A609CD),
(_ucs2 0x09A709CD), (_ucs2 0x09A809CD), (_ucs2 0x09AA09CD), (_ucs2 0x09AB09CD),
(_ucs2 0x09AC09CD), (_ucs2 0x09AD09CD), (_ucs2 0x09AE09CD), (_ucs2 0x09AF09CD),
(_ucs2 0x09B009CD), (_ucs2 0x09F009CD), (_ucs2 0x09B209CD), (_ucs2 0x09F109CD),
(_ucs2 0x09B609CD), (_ucs2 0x09B709CD), (_ucs2 0x09B809CD), (_ucs2 0x09B909CD);
INSERT INTO t1 VALUES 
 (_ucs2 0x099509CD0985),(_ucs2 0x0995),
 (_ucs2 0x099509CD0986),(_ucs2 0x099509BE),
 (_ucs2 0x099509CD0987),(_ucs2 0x099509BF),
 (_ucs2 0x099509CD0988),(_ucs2 0x099509C0),
 (_ucs2 0x099509CD0989),(_ucs2 0x099509C1),
 (_ucs2 0x099509CD098A),(_ucs2 0x099509C2),
 (_ucs2 0x099509CD098B),(_ucs2 0x099509C3),
 (_ucs2 0x099509CD09E0),(_ucs2 0x099509C4),
 (_ucs2 0x099509CD098C),(_ucs2 0x099509E2),
 (_ucs2 0x099509CD09E1),(_ucs2 0x099509E3),
 (_ucs2 0x099509CD098F),(_ucs2 0x099509C7),
 (_ucs2 0x099509CD0990),(_ucs2 0x099509C8),
 (_ucs2 0x099509CD0993),(_ucs2 0x099509CB),
 (_ucs2 0x099509CD0994),(_ucs2 0x099509CC);
SELECT HEX(WEIGHT_STRING(a)), HEX(CONVERT(a USING ucs2)), HEX(a)
FROM t1 ORDER BY a, BINARY(a);
SELECT HEX(WEIGHT_STRING(a)) as wa,
GROUP_CONCAT(HEX(CONVERT(a USING ucs2)) ORDER BY LENGTH(a), BINARY a)
FROM t1 GROUP BY a ORDER BY a;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT REPEAT(' ', 10) AS a LIMIT 0;
INSERT INTO t1 VALUES ('0'),('1'),('0z'),(_ucs2 0x0030FF9D);
INSERT INTO t1 VALUES ('a'),('b'),('c'),('d'),('e'),('f'),('g'),('h'),('i');
INSERT INTO t1 VALUES ('j'),('k'),('l'),('m'),('n'),('o'),('p'),('q'),('r');
INSERT INTO t1 VALUES ('s'),('t'),('u'),('v'),('w'),('x'),('y'),('z');
INSERT INTO t1 VALUES ('aa'),('aaa');
INSERT INTO t1 VALUES ('A'),('B'),('C'),('D'),('E'),('F'),('G'),('H'),('I');
INSERT INTO t1 VALUES ('J'),('K'),('L'),('M'),('N'),('O'),('P'),('Q'),('R');
INSERT INTO t1 VALUES ('S'),('T'),('U'),('V'),('W'),('X'),('Y'),('Z');
INSERT INTO t1 VALUES ('AA'),('AAA');
SELECT a, HEX(WEIGHT_STRING(a)) FROM t1 ORDER BY a, LENGTH(a), BINARY(a);
DROP TABLE t1;
