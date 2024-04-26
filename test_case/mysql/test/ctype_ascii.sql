
--
-- Bug #27562: ascii.xml invalid?
--
set names ascii;
select 'e'='`';
select 'y'='~';
create table t1 (a char(1) character set ascii);
insert into t1 (a) values (' '), ('a'), ('b'), ('c'), ('d'), ('e'), ('f'), ('g'), ('h'), ('i'), ('j'), ('k'), ('l'), ('m'), ('n'), ('o'), ('p'), ('q'), ('r'), ('s'), ('t'), ('u'), ('v'), ('w'), ('x'), ('y'), ('z'), ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H'), ('I'), ('J'), ('K'), ('L'), ('M'), ('N'), ('O'), ('P'), ('Q'), ('R'), ('S'), ('T'), ('U'), ('V'), ('W'), ('X'), ('Y'), ('Z'), ('!'), ('@'), ('--'), ('$'), ('%'), ('^'), ('&'), ('*'), ('('), (')'), ('_'), ('+'), ('`'), ('~'), ('1'), ('2'), ('3'), ('4'), ('5'), ('6'), ('7'), ('8'), ('9'), ('0'), ('['), (']'), ('\\'), ('|'), ('}'), ('{'), ('"'), (':'), (''''), (';
select t1a.a, t1b.a from t1 as t1a, t1 as t1b where t1a.a=t1b.a order by binary t1a.a, binary t1b.a;
drop table t1;

SET NAMES ascii;

CREATE TABLE t1 (v VARCHAR(10) CHARACTER SET ASCII);
INSERT INTO t1 VALUES('a');
INSERT INTO t1 VALUES(0xe5);
SELECT HEX(v) FROM t1;
DROP TABLE t1;
