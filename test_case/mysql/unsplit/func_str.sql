drop table if exists t1,t2;
select 'hello',"'hello'",'""hello""','''h''e''l''l''o''',"hel""lo",'hel\'lo';
select 'hello' 'monty';
select length('\n\t\r\b\0\_\%\\');
select bit_length('\n\t\r\b\0\_\%\\');
select char_length('\n\t\r\b\0\_\%\\');
select length(_latin1'\n\t\n\b\0\\_\\%\\');
select concat('monty',' was here ','again'),length('hello'),char(ascii('h')),ord('h');
select hex(char(256));
select locate('he','hello'),locate('he','hello',2),locate('lo','hello',2);
select instr('hello','HE'), instr('hello',binary 'HE'), instr(binary 'hello','HE');
select position(binary 'll' in 'hello'),position('a' in binary 'hello');
SELECT LOCATE('d', _utf8mb4'abcdef');
SELECT LOCATE(x'44', _utf8mb4'abcdef');
SELECT POSITION('d' IN _utf8mb4'abcdef');
SELECT POSITION(x'44' IN _utf8mb4'abcdef');
SELECT INSTR(_utf8mb4'abcdef', 'd');
SELECT INSTR(_utf8mb4'abcdef', x'44');
SELECT LOCATE(x'64', _utf8mb4'abcdef');
SELECT POSITION(x'64' IN _utf8mb4'abcdef');
SELECT INSTR(_utf8mb4'abcdef', x'64');
select left('hello',null), right('hello',null);
select left('hello',2),right('hello',2),substring('hello',2,2),mid('hello',1,5);
select concat('',left(right(concat('what ',concat('is ','happening')),9),4),'',substring('monty',5,1));
select substring_index('www.tcx.se','.',-2),substring_index('www.tcx.se','.',1);
select substring_index('www.tcx.se','tcx',1),substring_index('www.tcx.se','tcx',-1);
select substring_index('.tcx.se','.',-2),substring_index('.tcx.se','.tcx',-1);
select substring_index('aaaaaaaaa1','a',1);
select substring_index('aaaaaaaaa1','aa',1);
select substring_index('aaaaaaaaa1','aa',2);
select substring_index('aaaaaaaaa1','aa',3);
select substring_index('aaaaaaaaa1','aa',4);
select substring_index('aaaaaaaaa1','aa',5);
select substring_index('aaaaaaaaa1','aaa',1);
select substring_index('aaaaaaaaa1','aaa',2);
select substring_index('aaaaaaaaa1','aaa',3);
select substring_index('aaaaaaaaa1','aaa',4);
select substring_index('aaaaaaaaa1','aaaa',1);
select substring_index('aaaaaaaaa1','aaaa',2);
select substring_index('aaaaaaaaa1','1',1);
select substring_index('aaaaaaaaa1','a',-1);
select substring_index('aaaaaaaaa1','aa',-1);
select substring_index('aaaaaaaaa1','aa',-2);
select substring_index('aaaaaaaaa1','aa',-3);
select substring_index('aaaaaaaaa1','aa',-4);
select substring_index('aaaaaaaaa1','aa',-5);
select substring_index('aaaaaaaaa1','aaa',-1);
select substring_index('aaaaaaaaa1','aaa',-2);
select substring_index('aaaaaaaaa1','aaa',-3);
select substring_index('aaaaaaaaa1','aaa',-4);
select substring_index('the king of thethe hill','the',-2);
select substring_index('the king of the the hill','the',-2);
select substring_index('the king of the  the hill','the',-2);
select substring_index('the king of the  the hill',' the ',-1);
select substring_index('the king of the  the hill',' the ',-2);
select substring_index('the king of the  the hill',' ',-1);
select substring_index('the king of the  the hill',' ',-2);
select substring_index('the king of the  the hill',' ',-3);
select substring_index('the king of the  the hill',' ',-4);
select substring_index('the king of the  the hill',' ',-5);
select substring_index('the king of the.the hill','the',-2);
select substring_index('the king of thethethe.the hill','the',-3);
select substring_index('the king of thethethe.the hill','the',-1);
select substring_index('the king of the the hill','the',1);
select substring_index('the king of the the hill','the',2);
select substring_index('the king of the the hill','the',3);
select concat(':',ltrim('  left  '),':',rtrim('  right  '),':');
select concat(':',trim(leading from '  left  '),':',trim(trailing from '  right  '),':');
select concat(':',trim(LEADING FROM ' left'),':',trim(TRAILING FROM ' right '),':');
select concat(':',trim(' m '),':',trim(BOTH FROM ' y '),':',trim('*' FROM '*s*'),':');
select concat(':',trim(BOTH 'ab' FROM 'ababmyabab'),':',trim(BOTH '*' FROM '***sql'),':');
select concat(':',trim(LEADING '.*' FROM '.*my'),':',trim(TRAILING '.*' FROM 'sql.*.*'),':');
select TRIM("foo" FROM "foo"), TRIM("foo" FROM "foook"), TRIM("foo" FROM "okfoo");
select concat_ws(', ','monty','was here','again');
select concat_ws(NULL,'a'),concat_ws(',',NULL,'');
select concat_ws(',','',NULL,'a');
select insert('txs',2,1,'hi'),insert('is ',4,0,'a'),insert('txxxxt',2,4,'es');
select replace('aaaa','a','b'),replace('aaaa','aa','b'),replace('aaaa','a','bb'),replace('aaaa','','b'),replace('bbbb','a','c');
select replace(concat(lcase(concat('THIS',' ','IS',' ','A',' ')),ucase('false'),' ','test'),'FALSE','REAL');
select soundex(''),soundex('he'),soundex('hello all folks'),soundex('#3556 in bugdb');
select 'mood' sounds like 'mud';
select 'Glazgo' sounds like 'Liverpool';
select null sounds like 'null';
select 'null' sounds like null;
select null sounds like null;
select crc32("123");
select sha('abc');
select sha1('abc');
select aes_decrypt(aes_encrypt('abc','1'),'1');
select aes_decrypt(aes_encrypt('abc','1'),1);
select aes_encrypt(NULL,"a");
select aes_encrypt("a",NULL);
select aes_decrypt(NULL,"a");
select aes_decrypt("a",NULL);
select aes_decrypt("a","a");
select aes_decrypt(aes_encrypt("","a"),"a");
select repeat('monty',5),concat('*',space(5),'*');
select reverse('abc'),reverse('abcd');
select rpad('a',4,'1'),rpad('a',4,'12'),rpad('abcd',3,'12'), rpad(11, 10 , 22), rpad("ab", 10, 22);
select lpad('a',4,'1'),lpad('a',4,'12'),lpad('abcd',3,'12'), lpad(11, 10 , 22);
select rpad(741653838,17,'0'),lpad(741653838,17,'0');
select rpad('abcd',7,'ab'),lpad('abcd',7,'ab');
select rpad('abcd',1,'ab'),lpad('abcd',1,'ab');
select rpad('STRING', 20, CONCAT('p','a','d') );
select lpad('STRING', 20, CONCAT('p','a','d') );
select LEAST(NULL,'HARRY','HARRIOT',NULL,'HAROLD'),GREATEST(NULL,'HARRY','HARRIOT',NULL,'HAROLD');
select least(1,2,3) | greatest(16,32,8), least(5,4)*1,greatest(-1.0,1.0)*1,least(3,2,1)*1.0,greatest(1,1.1,1.0),least("10",9),greatest("A","B","0");
select quote('\'\"\\test');
select quote(concat('abc\'', '\\cba'));
select quote(1/0), quote('\0\Z');
select length(quote(concat(char(0),"test")));
select unhex(hex("foobar")), hex(unhex("1234567890ABCDEF")), unhex("345678"), unhex(NULL);
select hex(unhex("1")), hex(unhex("12")), hex(unhex("123")), hex(unhex("1234")), hex(unhex("12345")), hex(unhex("123456"));
select concat('a', quote(NULL));
select reverse("");
select insert("aa",100,1,"b"),insert("aa",1,3,"b"),left("aa",-1),substring("a",1,2);
select elt(2,1),field(NULL,"a","b","c"),reverse("");
select locate("a","b",2),locate("","a",1);
select ltrim("a"),rtrim("a"),trim(BOTH "" from "a"),trim(BOTH " " from "a");
select concat("1","2")|0,concat("1",".5")+0.0;
select substring_index("www.tcx.se","",3);
select length(repeat("a",100000000)),length(repeat("a",1000*64));
select position("0" in "baaa" in (1)),position("0" in "1" in (1,2,3)),position("sql" in ("mysql"));
select position(("1" in (1,2,3)) in "01");
select length(repeat("a",65500)),length(concat(repeat("a",32000),repeat("a",32000))),length(replace("aaaaa","a",concat(repeat("a",10000)))),length(insert(repeat("a",40000),1,30000,repeat("b",50000)));
select length(repeat("a",1000000)),length(concat(repeat("a",32000),repeat("a",32000),repeat("a",32000))),length(replace("aaaaa","a",concat(repeat("a",32000)))),length(insert(repeat("a",48000),1,1000,repeat("a",48000)));
create table t1 ( domain char(50) );
insert into t1 VALUES ("hello.de" ), ("test.de" );
select domain from t1 where concat('@', trim(leading '.' from concat('.', domain))) = '@hello.de';
select domain from t1 where concat('@', trim(leading '.' from concat('.', domain))) = '@test.de';
drop table t1;
CREATE TABLE t1 (i int, j int);
INSERT INTO t1 VALUES (1,1),(2,2);
SELECT DISTINCT i, ELT(j, '345', '34') FROM t1;
DROP TABLE t1;
create table t1(a char(4));
insert into t1 values ('one'),(NULL),('two'),('four');
select a, quote(a), isnull(quote(a)), quote(a) is null, ifnull(quote(a), 'n') from t1;
drop table t1;
select trim(trailing 'foo' from 'foo');
select trim(leading 'foo' from 'foo');
select quote(ltrim(concat('    ', 'a')));
select quote(trim(concat('    ', 'a')));
CREATE TABLE t1 SELECT 1 UNION SELECT 2 UNION SELECT 3;
SELECT QUOTE('A') FROM t1;
DROP TABLE t1;
select 1=_latin1'1';
select _latin1'1'=1;
select _latin2'1'=1;
select 1=_latin2'1';
select row('a','b','c') = row('a','b','c');
select row('A','b','c') = row('a','b','c');
select FIELD('b','A','B');
select FIELD('B','A','B');
select FIELD(_latin2'b','A','B');
select FIELD('b',_latin2'A','B');
select FIELD('1',_latin2'3','2',1);
select POSITION(_latin1'B' IN _latin1'abcd');
select POSITION(_latin1'B' IN _latin1'abcd' COLLATE latin1_bin);
select POSITION(_latin1'B' COLLATE latin1_bin IN _latin1'abcd');
select POSITION(_latin1'B' COLLATE latin1_general_ci IN _latin1'abcd' COLLATE latin1_bin);
select POSITION(_latin1'B' IN _latin2'abcd');
select FIND_IN_SET(_latin1'B',_latin1'a,b,c,d');
select FIND_IN_SET(_latin1'B',_latin1'a,b,c,d' COLLATE latin1_bin);
select FIND_IN_SET(_latin1'B' COLLATE latin1_bin,_latin1'a,b,c,d');
select SUBSTRING_INDEX(_latin1'abcdabcdabcd',_latin1'd',2);
select SUBSTRING_INDEX(_latin1'abcdabcdabcd' COLLATE latin1_bin,_latin1'd',2);
select SUBSTRING_INDEX(_latin1'abcdabcdabcd',_latin1'd' COLLATE latin1_bin,2);
select SUBSTRING_INDEX(_latin1'abcdabcdabcd',_latin2'd',2);
select SUBSTRING_INDEX(_latin1'abcdabcdabcd' COLLATE latin1_general_ci,_latin1'd' COLLATE latin1_bin,2);
select _latin1'B' between _latin1'a' and _latin1'c';
select _latin1'B' collate latin1_bin between _latin1'a' and _latin1'c';
select _latin1'B' between _latin1'a' collate latin1_bin and _latin1'c';
select _latin1'B' between _latin1'a' and _latin1'c' collate latin1_bin;
select _latin1'B' in (_latin1'a',_latin1'b');
select _latin1'B' collate latin1_bin in (_latin1'a',_latin1'b');
select _latin1'B' in (_latin1'a' collate latin1_bin,_latin1'b');
select _latin1'B' in (_latin1'a',_latin1'b' collate latin1_bin);
select collation(bin(130)), coercibility(bin(130));
select collation(oct(130)), coercibility(oct(130));
select collation(conv(130,16,10)), coercibility(conv(130,16,10));
select collation(hex(130)), coercibility(hex(130));
select collation(char(130)), coercibility(hex(130));
select collation(format(130,10)), coercibility(format(130,10));
select collation(lcase(_latin2'a')), coercibility(lcase(_latin2'a'));
select collation(ucase(_latin2'a')), coercibility(ucase(_latin2'a'));
select collation(left(_latin2'a',1)), coercibility(left(_latin2'a',1));
select collation(right(_latin2'a',1)), coercibility(right(_latin2'a',1));
select collation(substring(_latin2'a',1,1)), coercibility(substring(_latin2'a',1,1));
select collation(concat(_latin2'a',_latin2'b')), coercibility(concat(_latin2'a',_latin2'b'));
select collation(lpad(_latin2'a',4,_latin2'b')), coercibility(lpad(_latin2'a',4,_latin2'b'));
select collation(rpad(_latin2'a',4,_latin2'b')), coercibility(rpad(_latin2'a',4,_latin2'b'));
select collation(concat_ws(_latin2'a',_latin2'b')), coercibility(concat_ws(_latin2'a',_latin2'b'));
select collation(make_set(255,_latin2'a',_latin2'b',_latin2'c')), coercibility(make_set(255,_latin2'a',_latin2'b',_latin2'c'));
select collation(export_set(255,_latin2'y',_latin2'n',_latin2' ')), coercibility(export_set(255,_latin2'y',_latin2'n',_latin2' '));
select collation(trim(_latin2' a ')), coercibility(trim(_latin2' a '));
select collation(ltrim(_latin2' a ')), coercibility(ltrim(_latin2' a '));
select collation(rtrim(_latin2' a ')), coercibility(rtrim(_latin2' a '));
select collation(trim(LEADING _latin2' ' FROM _latin2'a')), coercibility(trim(LEADING _latin2'a' FROM _latin2'a'));
select collation(trim(TRAILING _latin2' ' FROM _latin2'a')), coercibility(trim(TRAILING _latin2'a' FROM _latin2'a'));
select collation(trim(BOTH _latin2' ' FROM _latin2'a')), coercibility(trim(BOTH _latin2'a' FROM _latin2'a'));
select collation(repeat(_latin2'a',10)), coercibility(repeat(_latin2'a',10));
select collation(reverse(_latin2'ab')), coercibility(reverse(_latin2'ab'));
select collation(quote(_latin2'ab')), coercibility(quote(_latin2'ab'));
select collation(soundex(_latin2'ab')), coercibility(soundex(_latin2'ab'));
select collation(substring(_latin2'ab',1)), coercibility(substring(_latin2'ab',1));
select collation(insert(_latin2'abcd',2,3,_latin2'ef')), coercibility(insert(_latin2'abcd',2,3,_latin2'ef'));
select collation(replace(_latin2'abcd',_latin2'b',_latin2'B')), coercibility(replace(_latin2'abcd',_latin2'b',_latin2'B'));
create table t1 charset latin1
select
  bin(130),
  oct(130),
  conv(130,16,10),
  hex(130),
  char(130),
  format(130,10),
  left(_latin2'a',1),
  right(_latin2'a',1), 
  lcase(_latin2'a'), 
  ucase(_latin2'a'),
  substring(_latin2'a',1,1),
  concat(_latin2'a',_latin2'b'),
  lpad(_latin2'a',4,_latin2'b'),
  rpad(_latin2'a',4,_latin2'b'),
  concat_ws(_latin2'a',_latin2'b'),
  make_set(255,_latin2'a',_latin2'b',_latin2'c'),
  export_set(255,_latin2'y',_latin2'n',_latin2' '),
  trim(_latin2' a '),
  ltrim(_latin2' a '),
  rtrim(_latin2' a '),
  trim(LEADING _latin2' ' FROM _latin2' a '),
  trim(TRAILING _latin2' ' FROM _latin2' a '),
  trim(BOTH _latin2' ' FROM _latin2' a '),
  repeat(_latin2'a',10),
  reverse(_latin2'ab'),
  quote(_latin2'ab'),
  soundex(_latin2'ab'),
  substring(_latin2'ab',1),
  insert(_latin2'abcd',2,3,_latin2'ef'),
  replace(_latin2'abcd',_latin2'b',_latin2'B');
drop table t1;
create table t1 (a char character set latin2);
insert into t1 values (null);
select charset(a), collation(a), coercibility(a) from t1;
drop table t1;
select charset(null), collation(null), coercibility(null);
CREATE TABLE t1 (a int, b int);
CREATE TABLE t2 (a int, b int);
INSERT INTO t1 VALUES (1,1),(2,2);
INSERT INTO t2 VALUES (2,2),(3,3);
select t1.*,t2.* from t1 left join t2 on (t1.b=t2.b)
where collation(t2.a) = _utf8mb3'binary' order by t1.a,t2.a;
select t1.*,t2.* from t1 left join t2 on (t1.b=t2.b)
where charset(t2.a) = _utf8mb3'binary' order by t1.a,t2.a;
select t1.*,t2.* from t1 left join t2 on (t1.b=t2.b)
where coercibility(t2.a) = 5 order by t1.a,t2.a;
DROP TABLE t1, t2;
select SUBSTR('abcdefg',3,2);
select SUBSTRING('abcdefg',3,2);
select SUBSTR('abcdefg',-3,2) FROM DUAL;
select SUBSTR('abcdefg',-1,5) FROM DUAL;
select SUBSTR('abcdefg',0,0) FROM DUAL;
select SUBSTR('abcdefg',-1,-1) FROM DUAL;
select SUBSTR('abcdefg',1,-1) FROM DUAL;
create table t7 (s1 char) charset latin1;
drop table t7;
SELECT lpad(12345, 5, "#");
SELECT conv(71, 10, 36), conv('1Z', 36, 10);
SELECT conv(71, 10, 37), conv('1Z', 37, 10), conv(0,1,10),conv(0,0,10), conv(0,-1,10);
create table t1 (id int(1), str varchar(10)) DEFAULT CHARSET=utf8mb3;
insert into t1 values (1,'aaaaaaaaaa'), (2,'bbbbbbbbbb');
create table t2 (id int(1), str varchar(10)) DEFAULT CHARSET=utf8mb3;
insert into t2 values (1,'cccccccccc'), (2,'dddddddddd');
select substring(concat(t1.str, t2.str), 1, 15) "name" from t1, t2 
where t2.id=t1.id order by name;
drop table t1, t2;
create table t1 (c1 INT, c2 INT UNSIGNED);
insert ignore into t1 values ('21474836461','21474836461');
insert ignore into t1 values ('-21474836461','-21474836461');
select * from t1;
drop table t1;
select left(1234, 3) + 0;
create table t1 (a int not null primary key, b varchar(40), c datetime);
insert into t1 (a,b,c) values (1,'Tom','2004-12-10 12:13:14'),(2,'ball games','2004-12-10 12:13:14'), (3,'Basil','2004-12-10 12:13:14'), (4,'Dean','2004-12-10 12:13:14'),(5,'Ellis','2004-12-10 12:13:14'), (6,'Serg','2004-12-10 12:13:14'), (7,'Sergei','2004-12-10 12:13:14'),(8,'Georg','2004-12-10 12:13:14'),(9,'Salle','2004-12-10 12:13:14'),(10,'Sinisa','2004-12-10 12:13:14');
select count(*) as total, left(c,10) as reg from t1 group by reg order by reg desc limit 0,12;
drop table t1;
select trim(null from 'kate') as "must_be_null";
select trim('xyz' from null) as "must_be_null";
select trim(leading NULL from 'kate') as "must_be_null";
select trim(trailing NULL from 'xyz') as "must_be_null";
SELECT CHAR(NULL,121,83,81,'76') as my_column;
SELECT CHAR_LENGTH(CHAR(NULL,121,83,81,'76')) as my_column;
CREATE TABLE t1 (id int PRIMARY KEY, str char(255) NOT NULL) charset latin1;
CREATE TABLE t2 (id int NOT NULL UNIQUE);
INSERT INTO t2 VALUES (1),(2);
INSERT INTO t1 VALUES (1, aes_encrypt('foo', 'bar'));
INSERT INTO t1 VALUES (2, 'not valid');
SELECT t1.id, aes_decrypt(str, 'bar') FROM t1, t2 WHERE t1.id = t2.id;
SELECT t1.id, aes_decrypt(str, 'bar') FROM t1, t2 WHERE t1.id = t2.id
 ORDER BY t1.id;
DROP TABLE t1, t2;
select field(0,NULL,1,0), field("",NULL,"bar",""), field(0.0,NULL,1.0,0.0);
select field(NULL,1,2,NULL), field(NULL,1,2,0);
CREATE TABLE t1 (str varchar(20) PRIMARY KEY);
CREATE TABLE t2 (num int primary key);
INSERT INTO t1 VALUES ('notnumber');
INSERT INTO t2 VALUES (0), (1);
SELECT * FROM t1, t2 WHERE num=str;
SELECT * FROM t1, t2 WHERE num=substring(str from 1 for 6);
DROP TABLE t1,t2;
CREATE TABLE t1(
  id int(11) NOT NULL auto_increment,
  pc int(11) NOT NULL default '0',
  title varchar(20) default NULL,
  PRIMARY KEY (id)
);
INSERT INTO t1 VALUES
  (1, 0, 'Main'),
  (2, 1, 'Toys'),
  (3, 1, 'Games');
SELECT t1.id, CONCAT_WS('->', t3.title, t2.title, t1.title) as col1
  FROM t1 LEFT JOIN t1 AS t2 ON t1.pc=t2.id
          LEFT JOIN t1 AS t3 ON t2.pc=t3.id;
SELECT t1.id, CONCAT_WS('->', t3.title, t2.title, t1.title) as col1
  FROM t1 LEFT JOIN t1 AS t2 ON t1.pc=t2.id
          LEFT JOIN t1 AS t3 ON t2.pc=t3.id
    WHERE CONCAT_WS('->', t3.title, t2.title, t1.title) LIKE '%Toys%';
DROP TABLE t1;
CREATE TABLE t1(
  trackid     int(10) unsigned NOT NULL auto_increment,
  trackname   varchar(100) NOT NULL default '',
  PRIMARY KEY (trackid)
);
CREATE TABLE t2(
  artistid    int(10) unsigned NOT NULL auto_increment,
  artistname  varchar(100) NOT NULL default '',
  PRIMARY KEY (artistid)
);
CREATE TABLE t3(
  trackid     int(10) unsigned NOT NULL,
  artistid    int(10) unsigned NOT NULL,
  PRIMARY KEY (trackid,artistid)
);
INSERT INTO t1 VALUES (1, 'April In Paris'), (2, 'Autumn In New York');
INSERT INTO t2 VALUES (1, 'Vernon Duke');
INSERT INTO t3 VALUES (1,1);
SELECT CONCAT_WS(' ', trackname, artistname) trackname, artistname
  FROM t1 LEFT JOIN t3 ON t1.trackid=t3.trackid
          LEFT JOIN t2 ON t2.artistid=t3.artistid
    WHERE CONCAT_WS(' ', trackname, artistname) LIKE '%In%';
DROP TABLE t1,t2,t3;
create table t1 (b varchar(5));
insert t1 values ('ab'), ('abc'), ('abcd'), ('abcde');
select *,substring(b,1),substring(b,-1),substring(b,-2),substring(b,-3),substring(b,-4),substring(b,-5) from t1;
select * from (select *,substring(b,1),substring(b,-1),substring(b,-2),substring(b,-3),substring(b,-4),substring(b,-5) from t1) t;
drop table t1;
select hex(29223372036854775809) as hex_signed,
       hex(cast(29223372036854775809 as unsigned)) as hex_unsigned;
select conv(29223372036854775809, -10, 16) as conv_signed,
       conv(29223372036854775809, 10, 16) as conv_unsigned;
select hex(-29223372036854775809) as hex_signed,
       hex(cast(-29223372036854775809 as unsigned)) as hex_unsigned;
select conv(-29223372036854775809, -10, 16) as conv_signed,
       conv(-29223372036854775809, 10, 16) as conv_unsigned;
create table t1 (i int);
insert into t1 values (1000000000),(1);
select lpad(i, 7, ' ') as t from t1;
select rpad(i, 7, ' ') as t from t1;
drop table t1;
select load_file("lkjlkj");
select ifnull(load_file("lkjlkj"),"it is null");
CREATE TABLE t1 (a varchar(10));
INSERT INTO t1 VALUES ('abc'), ('xyz');
SELECT a, CONCAT(a,' ',a) AS c FROM t1
  HAVING LEFT(c,LENGTH(c)-INSTR(REVERSE(c)," ")) = a;
SELECT a, CONCAT(a,' ',a) AS c FROM t1
  HAVING LEFT(CONCAT(a,' ',a),
              LENGTH(CONCAT(a,' ',a))-
                     INSTR(REVERSE(CONCAT(a,' ',a))," ")) = a;
DROP TABLE t1;
CREATE TABLE t1 (s varchar(10));
INSERT INTO t1 VALUES ('yadda'), ('yaddy');
DROP TABLE t1;
create table t1 (d decimal default null);
insert into t1 values (null);
select format(d, 2) from t1;
drop table t1;
create table t1 (c varchar(40));
insert into t1 values ('y,abc'),('y,abc');
select c, substring_index(lcase(c), @q:=',', -1) as res from t1;
drop table t1;
select cast(rtrim('  20.06 ') as decimal(19,2));
select cast(ltrim('  20.06 ') as decimal(19,2));
select cast(rtrim(ltrim('  20.06 ')) as decimal(19,2));
select conv("18383815659218730760",10,10) + 0;
select "18383815659218730760" + 0;
CREATE TABLE t1 (code varchar(10)) charset utf8mb4;
INSERT INTO t1 VALUES ('a12'), ('A12'), ('a13');
SELECT ASCII(code), code FROM t1 WHERE code='A12';
SELECT ASCII(code), code FROM t1 WHERE code='A12' AND ASCII(code)=65;
INSERT INTO t1 VALUES (_utf16 0x0061003100320007), (_utf16 0x00410031003200070007);
SELECT LENGTH(code), code FROM t1 WHERE code='A12';
SELECT LENGTH(code), code FROM t1 WHERE code='A12' AND LENGTH(code)=5;
ALTER TABLE t1 ADD INDEX (code);
CREATE TABLE t2 (id varchar(10) PRIMARY KEY) charset utf8mb4;
INSERT INTO t2 VALUES ('a11'), ('a12'), ('a13'), ('a14');
SELECT * FROM t1 INNER JOIN t2 ON t1.code=t2.id 
  WHERE t2.id='a12' AND (LENGTH(code)=5 OR code < 'a00');
SELECT * FROM t1 INNER JOIN t2 ON code=id 
  WHERE id='a12' AND (LENGTH(code)=5 OR code < 'a00');
DROP TABLE t1,t2;
select format(NULL, NULL);
select format(pi(), NULL);
select format(NULL, 2);
select benchmark(NULL, NULL);
select benchmark(0, NULL);
select benchmark(100, NULL);
select benchmark(NULL, 1+1);
select benchmark(-1, 1);
select format(pi(), (1+1));
select format(pi(), (select 3 from dual));
select format(pi(), @dec);
select benchmark(10, pi());
select benchmark(5+5, pi());
select benchmark((select 10 from dual), pi());
select benchmark(@bench_count, pi());
select locate('he','hello',-2);
select locate('lo','hello',-4294967295);
select locate('lo','hello',4294967295);
select locate('lo','hello',-4294967296);
select locate('lo','hello',4294967296);
select locate('lo','hello',-4294967297);
select locate('lo','hello',4294967297);
select locate('lo','hello',-18446744073709551615);
select locate('lo','hello',18446744073709551615);
select locate('lo','hello',-18446744073709551616);
select locate('lo','hello',18446744073709551616);
select locate('lo','hello',-18446744073709551617);
select locate('lo','hello',18446744073709551617);
select left('hello', 10);
select left('hello', 0);
select left('hello', -1);
select left('hello', -4294967295);
select left('hello', 4294967295);
select left('hello', -4294967296);
select left('hello', 4294967296);
select left('hello', -4294967297);
select left('hello', 4294967297);
select left('hello', -18446744073709551615);
select left('hello', 18446744073709551615);
select left('hello', -18446744073709551616);
select left('hello', 18446744073709551616);
select left('hello', -18446744073709551617);
select left('hello', 18446744073709551617);
select right('hello', 10);
select right('hello', 0);
select right('hello', -1);
select right('hello', -4294967295);
select right('hello', 4294967295);
select right('hello', -4294967296);
select right('hello', 4294967296);
select right('hello', -4294967297);
select right('hello', 4294967297);
select right('hello', -18446744073709551615);
select right('hello', 18446744073709551615);
select right('hello', -18446744073709551616);
select right('hello', 18446744073709551616);
select right('hello', -18446744073709551617);
select right('hello', 18446744073709551617);
select substring('hello', 2, -1);
select substring('hello', -1, 1);
select substring('hello', -2, 1);
select substring('hello', -4294967295, 1);
select substring('hello', 4294967295, 1);
select substring('hello', -4294967296, 1);
select substring('hello', 4294967296, 1);
select substring('hello', -4294967297, 1);
select substring('hello', 4294967297, 1);
select substring('hello', -18446744073709551615, 1);
select substring('hello', 18446744073709551615, 1);
select substring('hello', -18446744073709551616, 1);
select substring('hello', 18446744073709551616, 1);
select substring('hello', -18446744073709551617, 1);
select substring('hello', 18446744073709551617, 1);
select substring('hello', 1, -1);
select substring('hello', 1, -4294967295);
select substring('hello', 1, 4294967295);
select substring('hello', 1, -4294967296);
select substring('hello', 1, 4294967296);
select substring('hello', 1, -4294967297);
select substring('hello', 1, 4294967297);
select substring('hello', 1, -18446744073709551615);
select substring('hello', 1, 18446744073709551615);
select substring('hello', 1, -18446744073709551616);
select substring('hello', 1, 18446744073709551616);
select substring('hello', 1, -18446744073709551617);
select substring('hello', 1, 18446744073709551617);
select substring('hello', -1, -1);
select substring('hello', -4294967295, -4294967295);
select substring('hello', 4294967295, 4294967295);
select substring('hello', -4294967296, -4294967296);
select substring('hello', 4294967296, 4294967296);
select substring('hello', -4294967297, -4294967297);
select substring('hello', 4294967297, 4294967297);
select substring('hello', -18446744073709551615, -18446744073709551615);
select substring('hello', 18446744073709551615, 18446744073709551615);
select substring('hello', -18446744073709551616, -18446744073709551616);
select substring('hello', 18446744073709551616, 18446744073709551616);
select substring('hello', -18446744073709551617, -18446744073709551617);
select substring('hello', 18446744073709551617, 18446744073709551617);
select insert('hello', -1, 1, 'hi');
select insert('hello', -4294967295, 1, 'hi');
select insert('hello', 4294967295, 1, 'hi');
select insert('hello', -4294967296, 1, 'hi');
select insert('hello', 4294967296, 1, 'hi');
select insert('hello', -4294967297, 1, 'hi');
select insert('hello', 4294967297, 1, 'hi');
select insert('hello', -18446744073709551615, 1, 'hi');
select insert('hello', 18446744073709551615, 1, 'hi');
select insert('hello', -18446744073709551616, 1, 'hi');
select insert('hello', 18446744073709551616, 1, 'hi');
select insert('hello', -18446744073709551617, 1, 'hi');
select insert('hello', 18446744073709551617, 1, 'hi');
select insert('hello', 1, -1, 'hi');
select insert('hello', 1, -4294967295, 'hi');
select insert('hello', 1, 4294967295, 'hi');
select insert('hello', 1, -4294967296, 'hi');
select insert('hello', 1, 4294967296, 'hi');
select insert('hello', 1, -4294967297, 'hi');
select insert('hello', 1, 4294967297, 'hi');
select insert('hello', 1, -18446744073709551615, 'hi');
select insert('hello', 1, 18446744073709551615, 'hi');
select insert('hello', 1, -18446744073709551616, 'hi');
select insert('hello', 1, 18446744073709551616, 'hi');
select insert('hello', 1, -18446744073709551617, 'hi');
select insert('hello', 1, 18446744073709551617, 'hi');
select insert('hello', -1, -1, 'hi');
select insert('hello', -4294967295, -4294967295, 'hi');
select insert('hello', 4294967295, 4294967295, 'hi');
select insert('hello', -4294967296, -4294967296, 'hi');
select insert('hello', 4294967296, 4294967296, 'hi');
select insert('hello', -4294967297, -4294967297, 'hi');
select insert('hello', 4294967297, 4294967297, 'hi');
select insert('hello', -18446744073709551615, -18446744073709551615, 'hi');
select insert('hello', 18446744073709551615, 18446744073709551615, 'hi');
select insert('hello', -18446744073709551616, -18446744073709551616, 'hi');
select insert('hello', 18446744073709551616, 18446744073709551616, 'hi');
select insert('hello', -18446744073709551617, -18446744073709551617, 'hi');
select insert('hello', 18446744073709551617, 18446744073709551617, 'hi');
select repeat('hello', -1);
select repeat('hello', -4294967295);
select repeat('hello', 4294967295);
select repeat('hello', -4294967296);
select repeat('hello', 4294967296);
select repeat('hello', -4294967297);
select repeat('hello', 4294967297);
select repeat('hello', -18446744073709551615);
select repeat('hello', 18446744073709551615);
select repeat('hello', -18446744073709551616);
select repeat('hello', 18446744073709551616);
select repeat('hello', -18446744073709551617);
select repeat('hello', 18446744073709551617);
select space(-1);
select space(-4294967295);
select space(4294967295);
select space(-4294967296);
select space(4294967296);
select space(-4294967297);
select space(4294967297);
select space(-18446744073709551615);
select space(18446744073709551615);
select space(-18446744073709551616);
select space(18446744073709551616);
select space(-18446744073709551617);
select space(18446744073709551617);
select rpad('hello', -1, '1');
select rpad('hello', -4294967295, '1');
select rpad('hello', 4294967295, '1');
select rpad('hello', -4294967296, '1');
select rpad('hello', 4294967296, '1');
select rpad('hello', -4294967297, '1');
select rpad('hello', 4294967297, '1');
select rpad('hello', -18446744073709551615, '1');
select rpad('hello', 18446744073709551615, '1');
select rpad('hello', -18446744073709551616, '1');
select rpad('hello', 18446744073709551616, '1');
select rpad('hello', -18446744073709551617, '1');
select rpad('hello', 18446744073709551617, '1');
select lpad('hello', -1, '1');
select lpad('hello', -4294967295, '1');
select lpad('hello', 4294967295, '1');
select lpad('hello', -4294967296, '1');
select lpad('hello', 4294967296, '1');
select lpad('hello', -4294967297, '1');
select lpad('hello', 4294967297, '1');
select lpad('hello', -18446744073709551615, '1');
select lpad('hello', 18446744073709551615, '1');
select lpad('hello', -18446744073709551616, '1');
select lpad('hello', 18446744073709551616, '1');
select lpad('hello', -18446744073709551617, '1');
select lpad('hello', 18446744073709551617, '1');
SELECT CHAR(0xff,0x8f USING utf8mb3);
SELECT CHAR(0xff,0x8f USING utf8mb3) IS NULL;
select substring('abc', cast(2 as unsigned int));
select repeat('a', cast(2 as unsigned int));
select rpad('abc', cast(5 as unsigned integer), 'x');
select lpad('abc', cast(5 as unsigned integer), 'x');
create table t1(f1 longtext);
insert into t1 values ("123"),("456");
select substring(f1,1,1) from t1 group by 1;
create table t2(f1 varchar(3));
insert into t1 values ("123"),("456");
select substring(f1,4,1), substring(f1,-4,1) from t2;
drop table t1,t2;
DROP TABLE IF EXISTS t1;
CREATE TABLE `t1` (
  `id` varchar(20) NOT NULL,
  `tire` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
);
INSERT INTO `t1` (`id`, `tire`) VALUES ('A', 0), ('B', 1),('C', 2);
SELECT REPEAT( '#', tire ) AS A,
       REPEAT( '#', tire % 999 ) AS B, tire FROM `t1`;
SELECT REPEAT('0', CAST(0 AS UNSIGNED));
SELECT REPEAT('0', -2);
SELECT REPEAT('0', 2);
DROP TABLE t1;
SELECT UNHEX('G');
SELECT UNHEX('G') IS NULL;
select unhex('5078-04-25');
SELECT INSERT('abc', 3, 3, '1234');
SELECT INSERT('abc', 4, 3, '1234');
SELECT INSERT('abc', 5, 3, '1234');
SELECT INSERT('abc', 6, 3, '1234');
CREATE TABLE t1 (a INT);
CREATE VIEW v1 AS SELECT CRC32(a) AS C FROM t1;
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
SELECT CRC32(a), COUNT(*) FROM t1 GROUP BY 1;
SELECT CRC32(a), COUNT(*) FROM t1 GROUP BY 1 ORDER BY 1;
SELECT * FROM (SELECT CRC32(a) FROM t1) t2;
CREATE TABLE t2 SELECT CRC32(a) FROM t1;
SELECT * FROM v1;
SELECT * FROM (SELECT * FROM v1) x;
DROP TABLE t1, t2;
DROP VIEW v1;
SELECT LOCATE('foo', NULL) FROM DUAL;
SELECT LOCATE(NULL, 'o') FROM DUAL;
SELECT LOCATE(NULL, NULL) FROM DUAL;
SELECT LOCATE('foo', NULL) IS NULL FROM DUAL;
SELECT LOCATE(NULL, 'o') IS NULL FROM DUAL;
SELECT LOCATE(NULL, NULL) IS NULL FROM DUAL;
SELECT ISNULL(LOCATE('foo', NULL)) FROM DUAL;
SELECT ISNULL(LOCATE(NULL, 'o')) FROM DUAL;
SELECT ISNULL(LOCATE(NULL, NULL)) FROM DUAL;
SELECT LOCATE('foo', NULL) <=> NULL FROM DUAL;
SELECT LOCATE(NULL, 'o') <=> NULL FROM DUAL;
SELECT LOCATE(NULL, NULL) <=> NULL FROM DUAL;
CREATE TABLE t1 (id int NOT NULL PRIMARY KEY, a varchar(10), p varchar(10));
INSERT INTO t1 VALUES (1, 'foo', 'o');
INSERT INTO t1 VALUES (2, 'foo', NULL);
INSERT INTO t1 VALUES (3, NULL, 'o');
INSERT INTO t1 VALUES (4, NULL, NULL);
SELECT id, LOCATE(a,p) FROM t1;
SELECT id, LOCATE(a,p) IS NULL FROM t1;
SELECT id, ISNULL(LOCATE(a,p)) FROM t1;
SELECT id, LOCATE(a,p) <=> NULL FROM t1;
SELECT id FROM t1 WHERE LOCATE(a,p) IS NULL;
SELECT id FROM t1 WHERE LOCATE(a,p) <=> NULL;
DROP TABLE t1;
SELECT SUBSTR('foo',1,0) FROM DUAL;
SELECT SUBSTR('foo',1,CAST(0 AS SIGNED)) FROM DUAL;
SELECT SUBSTR('foo',1,CAST(0 AS UNSIGNED)) FROM DUAL;
CREATE TABLE t1 (a varchar(10), len int unsigned);
INSERT INTO t1 VALUES ('bar', 2), ('foo', 0);
SELECT SUBSTR(a,1,len) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT CHAR(0x414243) as c1;
SELECT HEX(c1) from t1;
DROP TABLE t1;
CREATE VIEW v1 AS SELECT CHAR(0x414243) as c1;
SELECT HEX(c1) from v1;
DROP VIEW v1;
create table t1(a float);
insert into t1 values (1.33);
select format(a, 2) from t1;
drop table t1;
CREATE TABLE t1 (c DATE, aa VARCHAR(30));
INSERT INTO t1 VALUES ('2008-12-31','aaaaaa');
SELECT DATE_FORMAT(c, GET_FORMAT(DATE, 'eur')) h, CONCAT(UPPER(aa),', ', aa) i FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a TINYBLOB);
INSERT INTO t1 VALUES ('aaaaaaaa');
SELECT LOAD_FILE(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (f2 VARCHAR(20));
CREATE TABLE t2 (f2 VARCHAR(20));
INSERT INTO t1 VALUES ('MIN'),('MAX');
INSERT INTO t2 VALUES ('LOAD');
SELECT CONCAT_WS('_', (SELECT t2.f2 FROM t2), t1.f2) AS concat_name FROM t1;
DROP TABLE t1, t2;
CREATE TABLE t1 (a LONGBLOB NOT NULL);
INSERT INTO t1 VALUES (''),('');
SELECT 1 FROM t1, t1 t2
ORDER BY QUOTE(t1.a);
DROP TABLE t1;
SELECT '1' IN ('1', SUBSTRING(-9223372036854775809, 1));
SELECT CONVERT(('' IN (REVERSE(CAST(('') AS DECIMAL)), '')), CHAR(3));
CREATE TABLE t1 ( a TEXT );
SELECT insert( substring_index( 'a', 'a', 'b' ), 1, 0, 'x' );
SELECT * FROM t1;
DROP TABLE t1;
SELECT SUBSTRING('1', DAY(FROM_UNIXTIME(-1)));
SELECT LEFT('1', DAY(FROM_UNIXTIME(-1)));
SELECT RIGHT('1', DAY(FROM_UNIXTIME(-1)));
SELECT REPEAT('1', DAY(FROM_UNIXTIME(-1)));
SELECT RPAD('hi', DAY(FROM_UNIXTIME(-1)),'?');
SELECT LPAD('hi', DAY(FROM_UNIXTIME(-1)),'?');
CREATE TABLE t1 charset utf8mb4
SELECT SUBSTRING('1', DAY(FROM_UNIXTIME(-1))) AS f1,
       LEFT('1', DAY(FROM_UNIXTIME(-1))) AS f2,
       RIGHT('1', DAY(FROM_UNIXTIME(-1))) AS f3,
       REPEAT('1', DAY(FROM_UNIXTIME(-1))) AS f4,
       RPAD('hi', DAY(FROM_UNIXTIME(-1)),'?') AS f5,
       LPAD('hi', DAY(FROM_UNIXTIME(-1)),'?') AS f6;
DROP TABLE t1;
CREATE TABLE t2(a INT, KEY(a));
INSERT INTO t2 VALUES (1),(2);
CREATE TABLE t1(b INT, PRIMARY KEY(b));
INSERT INTO t1 VALUES (0),(254);
SELECT 1 FROM t2 WHERE a LIKE
(SELECT  EXPORT_SET(1, b, b, b, b) FROM t1 LIMIT 1);
DROP TABLE t1, t2;
SELECT format(12345678901234567890.123, 3);
SELECT format(12345678901234567890.123, 3, NULL);
SELECT format(12345678901234567890.123, 3, 'ar_AE');
SELECT format(12345678901234567890.123, 3, 'ar_SA');
SELECT format(12345678901234567890.123, 3, 'be_BY');
SELECT format(12345678901234567890.123, 3, 'de_DE');
SELECT format(12345678901234567890.123, 3, 'en_IN');
SELECT format(12345678901234567890.123, 3, 'en_US');
SELECT format(12345678901234567890.123, 3, 'it_CH');
SELECT format(12345678901234567890.123, 3, 'ru_RU');
SELECT format(12345678901234567890.123, 3, 'ta_IN');
CREATE TABLE t1 (fmt CHAR(5) NOT NULL);
INSERT INTO t1 VALUES ('ar_AE');
INSERT INTO t1 VALUES ('ar_SA');
INSERT INTO t1 VALUES ('be_BY');
INSERT INTO t1 VALUES ('de_DE');
INSERT INTO t1 VALUES ('en_IN');
INSERT INTO t1 VALUES ('en_US');
INSERT INTO t1 VALUES ('it_CH');
INSERT INTO t1 VALUES ('ru_RU');
INSERT INTO t1 VALUES ('ta_IN');
SELECT fmt, format(12345678901234567890.123, 3, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(12345678901234567890.123, 0, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(12345678901234567890,     3, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(-12345678901234567890,    3, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(-02345678901234567890,    3, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(-00345678901234567890,    3, fmt) FROM t1 ORDER BY fmt;
SELECT fmt, format(-00045678901234567890,    3, fmt) FROM t1 ORDER BY fmt;
DROP TABLE t1;
SELECT format(123, 1, 'Non-existent-locale');
SELECT FORMAT(123.33, 2, 'no_NO'), FORMAT(1123.33, 2, 'no_NO');
SELECT FORMAT(12333e-2, 2, 'no_NO'), FORMAT(112333e-2, 2, 'no_NO');
CREATE TABLE t1 charset utf8mb4 AS SELECT format(123,2,'no_NO');
SELECT * FROM t1;
DROP TABLE t1;
SELECT CONV(1,-2147483648,-2147483648);
SELECT (rpad(1.0,2048,1)) IS NOT FALSE;
SELECT ((+0) IN
((0b111111111111111111111111111111111111111111111111111),(rpad(1.0,2048,1)),
(32767.1)));
SELECT ((rpad(1.0,2048,1)) = ('4(') ^ (0.1));
SELECT ((rpad(1.0,2048,1)) + (0) ^ ('../'));
SELECT stddev_samp(rpad(1.0,2048,1));
SELECT ((127.1) not in ((rpad(1.0,2048,1)),(''),(-1.1)));
SELECT ((0xf3) * (rpad(1.0,2048,1)) << (0xcc));
SELECT @tmp_max:= @@global.max_allowed_packet;
SELECT @@global.max_allowed_packet;
CREATE TABLE t1 (a VARBINARY(64));
INSERT INTO t1 VALUES (0x00), (0x0000), (0x000000), (0x00000000);
INSERT INTO t1 VALUES (0x00010203040506070809);
SELECT TO_BASE64(a), hex(a) FROM t1 ORDER BY a;
DROP TABLE t1;
SELECT TO_BASE64(NULL);
SELECT FROM_BASE64(NULL);
SELECT @b:= TO_BASE64(''), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('f'), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('fo'), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('foo'), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('foob'), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('fooba'), FROM_BASE64(@b);
SELECT @b:= TO_BASE64('foobar'), FROM_BASE64(@b);
SELECT hex(FROM_BASE64('#'));
SELECT hex(FROM_BASE64('A#'));
SELECT hex(FROM_BASE64('AB#'));
SELECT hex(FROM_BASE64('ABC#'));
SELECT hex(FROM_BASE64('ABCD#'));
SELECT hex(FROM_BASE64('='));
SELECT hex(FROM_BASE64('A='));
SELECT hex(FROM_BASE64('ABCD='));
SELECT hex(FROM_BASE64('ABCDE='));
SELECT hex(FROM_BASE64('A'));
SELECT hex(FROM_BASE64('AB'));
SELECT hex(FROM_BASE64('ABC'));
SELECT hex(FROM_BASE64('AAA=x'));
SELECT hex(FROM_BASE64('AA==x'));
SELECT hex(FROM_BASE64('  A B C D  '));
SELECT hex(FROM_BASE64('  A A = = '));
SELECT hex(FROM_BASE64('  A A A = '));
SELECT hex(FROM_BASE64('  A  \n  B  \r  C  \t D  '));
SELECT LENGTH(TO_BASE64(REPEAT('a', @@max_allowed_packet-10)));
CREATE TABLE t1 (
  i1 INT, 
  f1 FLOAT,
  dc1 DECIMAL(10,5),
  e1 ENUM('enum11','enum12','enum13'),
  s1 SET('set1','set2','set3'),
  t1 TIME,
  d1 DATE,
  dt1 DATETIME
);
INSERT INTO t1 VALUES
(-12345, -456.789, 123.45, 'enum13', 'set1,set3',
'01:02:03', '2010-01-01', '2011-01-01 02:03:04');
SELECT FROM_BASE64(TO_BASE64(i1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(f1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(dc1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(e1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(s1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(t1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(d1)) FROM t1;
SELECT FROM_BASE64(TO_BASE64(dt1)) FROM t1;
DROP TABLE t1;
SELECT @tmp_max:= @@global.max_allowed_packet;
SELECT @@global.max_allowed_packet;
SELECT CHAR_LENGTH(EXPORT_SET(1,1,1,REPEAT(1,100000000)));
SELECT SPACE(@@global.max_allowed_packet*2);
PREPARE stmt FROM "SELECT COLLATION(space(2))";
SELECT LOWER(SUBSTRING_INDEX(@user_at_host, '@', -1));
CREATE TABLE t (i INT NOT NULL, c CHAR(255) NOT NULL);
SELECT i, SUBSTRING_INDEX(c, '.', -2) FROM t WHERE i = 1;
SELECT i, SUBSTRING_INDEX(c, '.', -2) FROM t;
DROP TABLE t;
CREATE TABLE t1 (a varchar(1));
SELECT * FROM t1 WHERE a=hex('a');
SELECT * FROM t1 WHERE a=to_base64('a');
DROP TABLE t1;
create table t1(a varchar(20));
insert into t1 values(''), (' '), ('xxxxxxxxxxxxxxx');
create table t2(a int);
insert into t2 values(0),(0),(1),(0),(10),(-2),(30),(NULL);
select t1.a as str, length(t1.a) as str_length, t2.a as pos, t2.a + 10 as length, insert(t1.a, t2.a, t2.a + 10, '1234567') as 'insert' from t1, t2;
drop table t1,t2;
CREATE TABLE t1(a TIMESTAMP(5)) ENGINE=INNODB;
INSERT INTO t1 VALUES('1978-01-03 00:00:00'),('2000-001-02 00:00:00');
SELECT 1 FROM t1 GROUP BY insert(a,'1','11','1');
SELECT insert(a,1,1,1) FROM t1;
DROP TABLE t1;
select length(repeat("",1)) as a;
select length(repeat("",1024*1024*1024)) as a;
select length(repeat("1",1024*1024)) as a;
select length(repeat("1",1024*1024*1024)) as a;
CREATE TABLE t1(a TIME);
INSERT INTO t1 VALUES ();
SELECT (SELECT (SELECT 1 FROM t1 a WHERE t1.a <_ucs2'a')) AS d5 FROM t1 GROUP BY 1;
DROP TABLE t1;
SELECT length(rpad(_utf8mb3 0xD0B1, 65536, _utf8mb3 0xD0B2)) AS data;
SELECT length(data) AS len FROM (
  SELECT rpad(_utf8mb3 0xD0B1, 65536, _utf8mb3 0xD0B2) AS data
) AS sub;
SELECT length(rpad(_utf8mb3 0xD0B1, 65535, _utf8mb3 0xD0B2)) AS data;
SELECT length(data) AS len FROM (
  SELECT rpad(_utf8mb3 0xD0B1, 65535, _utf8mb3 0xD0B2) AS data
) AS sub;
SELECT length(repeat(_utf8mb4 0xE29883, 21844)) AS data;
SELECT length(data) AS len
FROM ( SELECT repeat(_utf8mb4 0xE29883, 21844) AS data ) AS sub;
SELECT length(repeat(_utf8mb4 0xE29883, 21846)) AS data;
SELECT length(data) AS len
FROM ( SELECT repeat(_utf8mb4 0xE29883, 21846) AS data ) AS sub;
SELECT TRIM(BOTH 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥' FROM 'aÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¦aÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥');
SELECT HEX(TRIM(CONVERT(_gb18030 0x20202081408141208144202020 USING utf32)));
CREATE TABLE t1 (COUNTRY char(100));
INSERT INTO t1 VALUES ("Norway"), ("Australia");
SELECT COUNTRY FROM t1 
WHERE trim(leading 'A' FROM  COUNTRY) = 'ustralia';
SELECT  COUNTRY  FROM t1 
WHERE  trim(trailing 'a' FROM COUNTRY)= 'Australi';
SELECT COUNTRY FROM t1 
WHERE trim(leading  'A' FROM COUNTRY) = 'ustralia'  
  AND trim(trailing 'a' FROM COUNTRY) = 'Australi';
DROP TABLE t1;
CREATE DATABASE testt CHARACTER SET utf8mb4;
CREATE TABLE t1(c1 CHAR(20));
INSERT INTO t1 VALUES('11');
SELECT c1 <=  REPEAT( SUBSTR( UPPER('Rdlpikti') , 1 , 2 ), 8 ) FROM t1;
SELECT * FROM t1 WHERE c1 <=  REPEAT( SUBSTR( UPPER('Rdlpikti') , 1 , 2 ), 8);
SELECT * FROM t1 WHERE c1 <=  REPEAT( SUBSTR( UPPER('Rdlpikti') , 1 , 2 ), 8);
DROP TABLE t1;
DROP DATABASE testt;
select hex(cast(9007199254740992 as decimal(30,0)));
select hex(cast(9007199254740993 as decimal(30,0)));
select hex(cast(9007199254740994 as decimal(30,0)));
select hex(cast(0x20000000000000 as unsigned) + 1);
select hex(cast(0x20000000000000 as decimal(30,0)) + 1);
select hex(cast(0x20000000000000 as decimal(30,0)) + 2);
SELECT REPLACE( 'a', binary 'b', NULL ) as xxx;
SELECT REPLACE( 'a', binary '', NULL ) as xxx;
SELECT REPLACE( 'a', 'b', NULL ) as xxx;
SELECT REPLACE( 'a', '', NULL ) as xxx;
SELECT REPLACE( NULL, 'b', 'bravo' ) as xxx;
SELECT REPLACE( NULL, '', 'bravo' ) as xxx;
SELECT REPLACE( 'a', NULL, 'bravo' ) as xxx;
SELECT REPLACE( 'a', binary NULL, 'bravo' ) as xxx;
CREATE TABLE t1(c1 CHAR(30));
INSERT INTO t1 VALUES('111'),('222');
SELECT DISTINCT substr(c1, 1, 2147483647) FROM t1;
SELECT DISTINCT substr(c1, 1, 2147483648) FROM t1;
SELECT DISTINCT substr(c1, -1, 2147483648) FROM t1;
SELECT DISTINCT substr(c1, -2147483647, 2147483648) FROM t1;
SELECT DISTINCT substr(c1, 9223372036854775807, 23) FROM t1;
SELECT DISTINCT left(c1, 3) FROM t1;
SELECT DISTINCT left(c1, 2147483647) FROM t1;
SELECT DISTINCT left(c1, 2147483648) FROM t1;
SELECT DISTINCT right(c1, 3) FROM t1;
SELECT DISTINCT right(c1, 2147483647) FROM t1;
SELECT DISTINCT right(c1, 2147483648) FROM t1;
DROP TABLE t1;
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 9223372036854775807 );
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 9223372036854775808 );
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 18446744073709551615 );
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 9223372036854775807 );
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 9223372036854775808 );
SELECT SUBSTRING_INDEX( 'xyz', 'abc', 18446744073709551615 );
SELECT BIN(MID(REPEAT('b',64),21,229));
SELECT BIN(MID(1.051098E+308,9,99));
SELECT BIN(RIGHT(REPEAT('b',64),30));
SELECT BIN(SUBSTRING(REPEAT('b',64),9));
SELECT OCT(LEFT(REPEAT('b',64),15));
CREATE TABLE t(a INT) engine=innodb;
INSERT INTO t VALUES(1);
SELECT 1 FROM t WHERE WEIGHT_STRING(CONCAT_WS('1',''));
SELECT 1 FROM t WHERE WEIGHT_STRING(CONCAT('',''));
DROP TABLE t;
CREATE TABLE dd_table (name VARCHAR(64) COLLATE utf8mb3_tolower_ci, UNIQUE KEY(name));
INSERT INTO dd_table VALUES('t1'), ('t2');
CREATE VIEW view1 AS SELECT name AS table_name FROM dd_table;
CREATE VIEW view2 AS SELECT name COLLATE utf8mb3_tolower_ci AS table_name FROM dd_table;
DROP VIEW view1;
DROP VIEW view2;
DROP TABLE dd_table;
select locate('he','hello',null),locate('he',null,2),locate(null,'hello',2);
select locate(null,'hello',null),locate('he',null,null);
select left('hello',null),left(null,1),left(null,null);
select right('hello',null),right(null,1),right(null,null);
select mid('hello',1,null),mid('hello',null,1),mid(null,1,1);
select substr('hello',null,2),substr('hello',2,null),substr(null,1,2);
select substr(null,null,null),mid(null,null,null);
select substring_index('the king of the the null','the',null);
select substring_index('the king of the the null',null,3);
select substring_index(null,'the',3);
select substring_index(null,null,3);
select substring_index(null,null,null);
select insert(null,2,1,'hi'),insert('txs',null,1,'hi');
select insert('txs',2,null,'hi'),insert('txs',2,1,null);
select insert('txs',null,null,'hi'),insert(null,null,null,null);
SELECT REPEAT(0x1111, 40000000) >> 1;
SELECT (~(REPEAT(0xb822, 0x5C9C380)));
CREATE TABLE t(x VARCHAR(10) NOT NULL);
DROP TABLE t;
CREATE TABLE t1 AS SELECT quote('a');
CREATE TABLE t2 AS SELECT quote('a');
CREATE TABLE t3 AS SELECT quote('a');
DROP TABLE t1, t2, t3;
CREATE TABLE t1(c1 VARCHAR(10));
INSERT INTO t1 VALUES ('Alaska');
SELECT LPAD('', 42, REPLACE(SHA2(c1, 0),c1,'')) FROM t1;
DROP TABLE t1;
SELECT TRIM(BOTH x'F09F8DA3' FROM _utf8mb4 x'F09F8DA3F09F8DA3');
SELECT TRIM(leading _utf8mb4 x'F09F8DA3' from _gb18030 x'9439B9376181308B33');
SELECT SUBSTRING_INDEX(_utf8mb4 x'C3A6C3B8F09F8DA361C3A6C3B8F09F8DA362',
                       _gb18030 x'81308B339439B937', 2);
SELECT REPLACE('ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¦ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¸ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¦ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¸ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥',_utf16 x'00e5', _gb18030 x'9439B937');
SELECT REPLACE(_latin1 x'E6F8E5E6F8E5',_utf16 x'00e5', _utf32 x'00000061');
CREATE TABLE t1 (
  id INT NOT NULL,
  c1 VARCHAR(10)
);
INSERT INTO t1 VALUES (111,'111');
SELECT
RPAD(id, 11, _utf8mb4 x'E4B8ADE69687') as rpad_id,
LPAD(id, 11, _utf8mb4 x'E4B8ADE69687') as lpad_id,
RPAD(c1, 11, _utf8mb4 x'E4B8ADE69687') as rpad_c1,
LPAD(c1, 11, _utf8mb4 x'E4B8ADE69687') as lpad_c1
FROM t1;
DROP TABLE t1;
SELECT INSERT(1, 1, 2, _utf8mb4 x'E4B8ADE69687');
SELECT 'a' + 0;
SELECT CAST('a' as DOUBLE);
SELECT CAST(CONCAT('a') as DOUBLE);
SELECT '2005-01-01' - 100;
SELECT CONCAT('2005' , '-01-01') - 100;
CREATE TABLE t1(id INTEGER NOT NULL PRIMARY KEY);
INSERT INTO t1 VALUES(0);
SELECT ISNULL(LOAD_FILE("$file")) AS "is null";
DROP TABLE t1;
CREATE TABLE t(x LONGTEXT);
SELECT UNHEX(x) FROM t;
DROP TABLE t;
CREATE TABLE t1(a CHAR(1) CHARACTER SET utf8mb4);
INSERT INTO t1 VALUES('a');
DROP TABLE t1;
CREATE TABLE t1(a VARCHAR(3), b VARCHAR(3));
INSERT INTO t1 VALUES('on','off');
DROP TABLE t1;
CREATE TABLE t(a INTEGER);
INSERT INTO t VALUES (1),(2);
SELECT (SELECT 1
        FROM t
        WHERE CONVERT(1 USING utf32) <> GROUP_CONCAT(1)
       );
DROP TABLE t;
SELECT INSERT('a', 1, 1, YEAR(UNHEX('w')));
CREATE VIEW v AS SELECT LPAD('x', 1 NOT IN (0), 1) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT RPAD('x', 1 NOT IN (0), 1) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT SHA2('x', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT SUBSTR('x', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT SUBSTR('x', 1, 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT REPEAT('x', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT SPACE(1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT LEFT('x', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE VIEW v AS SELECT RIGHT('x', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
CREATE TABLE t(s SET('0', '1'));
CREATE VIEW v AS SELECT FIND_IN_SET(1 NOT IN (0), s) AS c FROM t;
SELECT * FROM v;
DROP VIEW v;
DROP TABLE t;
CREATE VIEW v AS SELECT STR_TO_DATE('2020', 1 NOT IN (0)) AS c;
SELECT * FROM v;
DROP VIEW v;
SELECT space(9223372036854775808);
SELECT length(space(9223372036854775809));
CREATE TABLE t(i BIGINT UNSIGNED);
INSERT INTO t values(9223372036854775808);
SELECT space(i) FROM t;
DROP TABLE t;
SELECT space(1073741824);
CREATE TABLE locale_format(locale VARCHAR(10), formatted_string VARCHAR(100));
SELECT * FROM locale_format;
DROP TABLE locale_format;
CREATE TABLE t (
  a INT,
  b BLOB,
  c INT GENERATED ALWAYS AS (1) VIRTUAL,
  d INT,
  e INT GENERATED ALWAYS AS (LPAD('111', b, '1')) VIRTUAL,
  UNIQUE KEY (e),
  KEY(b(1),a,e),
  KEY(e,b(1))
);
INSERT IGNORE INTO t(a,b,d) VALUES (1, '1536999167', 1);
DROP TABLE t;
CREATE TABLE t1(c VARCHAR(10));
INSERT INTO t1 VALUES(NULL), ('pad');
SELECT RPAD(c, 4, 'x') FROM t1;
SELECT RPAD(c, 3, 'x') FROM t1;
SELECT LPAD(c, 4, 'x') FROM t1;
SELECT LPAD(c, 3, 'x') FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  col_varchar_key VARCHAR(1),
  pk INT,
  col_datetime_key DATETIME
);
INSERT INTO t1 VALUES
('A',NULL,'2007-02-13 18:06:37'),
('A',620107048,'1970-03-31 03:32:33'),
('o',1818429552,'2012-10-20 12:37:31'),
('1',-400273832,'1983-12-21 12:07:34'),
('0',-1712505984,'2012-06-18 11:56:20'),
('A',374506608,'2033-03-09 05:26:16'),
('O',-1889503289,NULL),
('w',1560969033,'1972-09-08 05:19:31'),
(NULL,1521527768,'2010-02-04 14:20:22');
SELECT
CONCAT_WS(
  REPEAT(CONCAT(col_varchar_key COLLATE utf8mb4_roman_ci), -1330441018),
    CONCAT_WS('',
      CONCAT(HEX(STRCMP('9', col_varchar_key))),
      (col_datetime_key - INTERVAL -1941528800 DAY_MINUTE))
)
AS field1
FROM t1
GROUP BY field1 WITH ROLLUP;
DROP TABLE t1;
CREATE TABLE t1 AS SELECT HEX(-1) AS f;
DROP TABLE t1;
CREATE TABLE t0(c0 DECIMAL);
INSERT INTO t0 VALUES(NULL);
DROP TABLE t0;
CREATE TABLE t0(c0 DECIMAL);
INSERT INTO t0 VALUES(NULL);
DROP TABLE t0;
SELECT _utf8mb4 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' COLLATE utf8mb4_0900_ai_ci = _utf8mb4 'ss' COLLATE utf8mb4_0900_ai_ci AS c;
SELECT _latin1 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' COLLATE latin1_general_ci = _latin1 'ss' COLLATE latin1_general_ci AS c;
SELECT _latin1 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' = _utf8mb4 'ss' AS c;
SELECT _utf8mb4 'ss' = _latin1 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' AS c;
SELECT _utf8mb4 'ss' = _utf8mb3 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' AS c;
SELECT _utf8mb3 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' = _utf8mb4 'ss' AS c;
CREATE TABLE t1 (
  c1 varchar(255)
);
INSERT INTO t1 VALUES('m'),('u'),('i');
DROP TABLE t1;
CREATE TABLE t1 (
  col_varchar_255_utf8_key varchar(255),
  col_int int DEFAULT NULL,
  pk int NOT NULL AUTO_INCREMENT,

  PRIMARY KEY (pk),
  KEY col_varchar_255_utf8_key (col_varchar_255_utf8_key)
);
INSERT INTO t1 VALUES
('that',4,1),
('r',-1153105920,2);
CREATE VIEW v1 AS SELECT * FROM t1;
SELECT
pk FROM v1
ORDER BY  "cant"  IN ( ( FORMAT(  LAST_INSERT_ID( pk ) , 42 ) ) );
SELECT
STDDEV_POP( ( LAST_INSERT_ID( ( - 2313724308561592320 ) ) ) ) AS field5
FROM t1
GROUP BY HEX( col_varchar_255_utf8_key )
ORDER BY SPACE( LAST_INSERT_ID() );
DROP VIEW v1;
DROP TABLE t1;
CREATE TABLE t (a VARCHAR(10) NOT NULL);
INSERT INTO t
WITH RECURSIVE seq AS (
   SELECT 1 AS n UNION ALL SELECT n + 1 FROM seq WHERE n < 200
)
SELECT 'abc' FROM seq;
SELECT LPAD(a, ASCII(RANDOM_BYTES(1)) - 10, 'abc') FROM t;
DROP TABLE t;
SELECT QUOTE(CAST(NULL AS CHAR CHARSET utf16));
SELECT QUOTE(CAST(NULL AS CHAR CHARSET utf32));
SELECT QUOTE(CAST(NULL AS CHAR CHARSET utf8mb4));
CREATE TABLE t1 (
  c1 date NOT NULL,
  c2 datetime NOT NULL,
  KEY(c2)
);
INSERT INTO t1 VALUES
('2004-01-22','1900-01-01 23:32:52');
SELECT
1
FROM t1
WHERE REPEAT(
        INSTR(t1.c1, t1.c2),
        CONCAT( ~ UNIX_TIMESTAMP()));
DROP TABLE t1;
CREATE TABLE t1 (
  c1 datetime NOT NULL
);
INSERT INTO t1 VALUES
('2001-11-04 19:07:55');
SELECT 1 FROM t1
WHERE REPEAT( c1, LTRIM( -42 ^ ( 4 XOR -2023620608 ) ) );
DROP TABLE t1;
SELECT QUOTE(x'01');
SELECT QUOTE(NULL);