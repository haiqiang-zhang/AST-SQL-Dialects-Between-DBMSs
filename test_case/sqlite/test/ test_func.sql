CREATE TABLE tbl1(t1 text);
INSERT INTO tbl1 VALUES('this');
INSERT INTO tbl1 VALUES('program');
INSERT INTO tbl1 VALUES('is');
INSERT INTO tbl1 VALUES('free');
INSERT INTO tbl1 VALUES('software');
SELECT t1 FROM tbl1 ORDER BY t1;
CREATE TABLE t2(a);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(NULL);
INSERT INTO t2 VALUES(345);
INSERT INTO t2 VALUES(NULL);
INSERT INTO t2 VALUES(67890);
SELECT * FROM t2;
SELECT length(t1) FROM tbl1 ORDER BY t1;
SELECT octet_length(t1) FROM tbl1 ORDER BY t1;
SELECT length(t1), count(*) FROM tbl1 GROUP BY length(t1)
           ORDER BY length(t1);
SELECT coalesce(length(a),-1) FROM t2;
SELECT octet_length(12345);
SELECT octet_length(NULL);
SELECT octet_length(7.5);
SELECT octet_length(x'30313233');
WITH c(x) AS (VALUES(char(350,351,352,353,354)))
  SELECT length(x), octet_length(x) FROM c;
SELECT substr(t1,1,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,2,1) FROM tbl1 ORDER BY t1;
SELECT substr(t1,3,3) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-1,1) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-1,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-2,1) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-2,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-4,2) FROM tbl1 ORDER BY t1;
SELECT t1 FROM tbl1 ORDER BY substr(t1,2,20);
SELECT substr(a,1,1) FROM t2;
SELECT substr(a,2,2) FROM t2;
DELETE FROM tbl1;
INSERT INTO tbl1 VALUES('contains');
INSERT INTO tbl1 VALUES('UTF-8');
INSERT INTO tbl1 VALUES('characters');
INSERT INTO tbl1 VALUES('hiÃÂÃÂ¡ÃÂÃÂÃÂÃÂ´ho');
SELECT t1 FROM tbl1 ORDER BY t1;
SELECT length(t1) FROM tbl1 ORDER BY t1;
SELECT substr(t1,1,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,1,3) FROM tbl1 ORDER BY t1;
SELECT substr(t1,2,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,2,3) FROM tbl1 ORDER BY t1;
SELECT substr(t1,3,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,4,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-1,1) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-3,2) FROM tbl1 ORDER BY t1;
SELECT substr(t1,-4,3) FROM tbl1 ORDER BY t1;
DELETE FROM tbl1;
INSERT INTO tbl1 VALUES('this');
INSERT INTO tbl1 VALUES('program');
INSERT INTO tbl1 VALUES('is');
INSERT INTO tbl1 VALUES('free');
INSERT INTO tbl1 VALUES('software');
SELECT t1 FROM tbl1;
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(1,2,3);
INSERT INTO t1 VALUES(2,1.2345678901234,-12345.67890);
INSERT INTO t1 VALUES(3,-2,-5);
SELECT abs(b) FROM t1 ORDER BY a;
SELECT abs(c) FROM t1 ORDER BY a;
SELECT abs(a) FROM t2;
SELECT abs(t1) FROM tbl1;
SELECT round(b,2) FROM t1 ORDER BY b;
SELECT round(b,0) FROM t1 ORDER BY a;
SELECT round(c) FROM t1 ORDER BY a;
SELECT round(c,a) FROM t1 ORDER BY a;
SELECT 'x' || round(c,a) || 'y' FROM t1 ORDER BY a;
SELECT coalesce(round(a,2),'nil') FROM t2;
SELECT round(t1,2) FROM tbl1;
SELECT typeof(round(5.1,1));
SELECT typeof(round(5.1));
SELECT round(b,2.0) FROM t1 ORDER BY b;
SELECT round(40223.4999999999);
SELECT round(40224.4999999999);
SELECT round(40225.4999999999);
SELECT round(1234567890.5);
SELECT round(12345678901.5);
SELECT round(123456789012.5);
SELECT round(1234567890123.5);
SELECT round(12345678901234.5);
SELECT round(1234567890123.35,1);
SELECT round(1234567890123.445,2);
SELECT round(99999999999994.5);
SELECT round(9999999999999.55,1);
SELECT round(9999999999999.556,2);
SELECT upper(t1) FROM tbl1;
SELECT lower(upper(t1)) FROM tbl1;
SELECT upper(a), lower(a) FROM t2;
SELECT coalesce(a,'xyz') FROM t2;
SELECT coalesce(upper(a),'nil') FROM t2;
SELECT coalesce(nullif(1,1),'nil');
SELECT coalesce(nullif(1,2),'nil');
SELECT coalesce(nullif(1,NULL),'nil');
SELECT last_insert_rowid();
EXPLAIN SELECT sum(a) FROM t2;
SELECT sum(a), count(a), round(avg(a),2), min(a), max(a), count(*) FROM t2;
SELECT max('z+'||a||'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOP') FROM t2;
CREATE TEMP TABLE t3 AS SELECT a FROM t2 ORDER BY a DESC;
SELECT min('z+'||a||'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOP') FROM t3;
SELECT max('z+'||a||'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOP') FROM t3;
SELECT sum(x) FROM (SELECT '9223372036' || '854775807' AS x
                          UNION ALL SELECT -9223372036854775807);
SELECT typeof(sum(x)) FROM (SELECT '9223372036' || '854775807' AS x
                          UNION ALL SELECT -9223372036854775807);
SELECT typeof(sum(x)) FROM (SELECT '9223372036' || '854775808' AS x
                          UNION ALL SELECT -9223372036854775807);
SELECT sum(x)>0.0 FROM (SELECT '9223372036' || '854775808' AS x
                          UNION ALL SELECT -9223372036850000000);
SELECT random() is not null;
SELECT typeof(random());
SELECT randomblob(32) is not null;
SELECT typeof(randomblob(32));
SELECT length(randomblob(32)), length(randomblob(-5)),
           length(randomblob(2000));
SELECT hex(x'00112233445566778899aAbBcCdDeEfF');
SELECT hex(replace('abcdefg','ef','12'));
SELECT hex(replace('abcdefg','','12'));
SELECT hex(replace('aabcdefg','a','aaa'));
WITH RECURSIVE c(x) AS (
     VALUES(1)
     UNION ALL
     SELECT x+1 FROM c WHERE x<1040
  )
  SELECT 
    count(*),
    sum(length(replace(printf('abc%.*cxyz',x,'m'),'m','nnnn'))-(6+x*4))
  FROM c;
SELECT sqlite_version(*);
CREATE TABLE t4(x);
DROP TABLE t4;
CREATE TABLE t4(a, b);
INSERT INTO t4 VALUES('abc', 'def');
INSERT INTO t4 VALUES('ghi', 'jkl');
CREATE TABLE tbl2(a, b);
SELECT quote(a), quote(b) FROM tbl2;
SELECT quote(4.2e+859), quote(-7.8e+904);
CREATE TABLE t5(x);
INSERT INTO t5 VALUES(1);
INSERT INTO t5 VALUES(-99);
INSERT INTO t5 VALUES(10000);
SELECT sum(x) FROM t5;
INSERT INTO t5 VALUES(0.0);
SELECT sum(x) FROM t5;
DELETE FROM t5;
SELECT sum(x), total(x) FROM t5;
INSERT INTO t5 VALUES(NULL);
SELECT sum(x), total(x) FROM t5;
INSERT INTO t5 VALUES(NULL);
SELECT sum(x), total(x) FROM t5;
INSERT INTO t5 VALUES(123);
SELECT sum(x), total(x) FROM t5;
CREATE TABLE t6(x INTEGER);
INSERT INTO t6 VALUES(1);
INSERT INTO t6 VALUES(1<<62);
SELECT sum(x) - ((1<<62)+1) from t6;
SELECT typeof(sum(x)) FROM t6;
INSERT INTO t6 VALUES(1<<62);
SELECT total(x) - ((1<<62)*2.0+1) FROM t6;
SELECT sum(-9223372036854775805);
SELECT sum(x) FROM 
         (SELECT 9223372036854775807 AS x UNION ALL
          SELECT -10 AS x);
SELECT sum(x) FROM 
         (SELECT -9223372036854775807 AS x UNION ALL
          SELECT 10 AS x);
SELECT sum(x) FROM (SELECT 9 AS x UNION ALL SELECT -10 AS x);
SELECT sum(x) FROM (SELECT -9 AS x UNION ALL SELECT 10 AS x);
SELECT sum(x) FROM (SELECT -10 AS x UNION ALL SELECT 9 AS x);
SELECT sum(x) FROM (SELECT 10 AS x UNION ALL SELECT -9 AS x);
SELECT abs(-9223372036854775807);
SELECT match(a,b) FROM t1 WHERE 0;
SELECT typeof(replace('This is the main test string', NULL, 'ALT'));
SELECT typeof(replace(NULL, 'main', 'ALT'));
SELECT typeof(replace('This is the main test string', 'main', NULL));
SELECT replace('This is the main test string', 'main', 'ALT');
SELECT replace('This is the main test string', 'main', 'larger-main');
SELECT replace('aaaaaaa', 'a', '0123456789');
SELECT typeof(replace(1,'',0));
SELECT trim('  hi  ');
SELECT ltrim('  hi  ');
SELECT rtrim('  hi  ');
SELECT trim('  hi  ','xyz');
SELECT ltrim('  hi  ','xyz');
SELECT rtrim('  hi  ','xyz');
SELECT trim('xyxzy  hi  zzzy','xyz');
SELECT ltrim('xyxzy  hi  zzzy','xyz');
SELECT rtrim('xyxzy  hi  zzzy','xyz');
SELECT trim('  hi  ','');
SELECT hex(trim(x'c280e1bfbff48fbfbf6869',x'6162e1bfbfc280'));
SELECT hex(trim(x'6869c280e1bfbff48fbfbf61',
                             x'6162e1bfbfc280f48fbfbf'));
SELECT hex(trim(x'ceb1ceb2ceb3',x'ceb1'));
SELECT typeof(trim(NULL));
SELECT typeof(trim(NULL,'xyz'));
SELECT typeof(trim('hello',NULL));
SELECT trim('xyzzy',x'c0808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080');
SELECT group_concat(t1), string_agg(t1,',') FROM tbl1;
SELECT group_concat(t1,' '), string_agg(t1,' ') FROM tbl1;
SELECT group_concat(t1,' ' || rowid || ' ') FROM tbl1;
SELECT group_concat(NULL,t1) FROM tbl1;
SELECT group_concat(t1,NULL), string_agg(t1,NULL) FROM tbl1;
SELECT 'BEGIN-'||group_concat(t1) FROM tbl1;
SELECT group_concat(CASE t1 WHEN 'this' THEN '' ELSE t1 END) FROM tbl1;
SELECT group_concat(CASE WHEN t1!='software' THEN '' ELSE t1 END) FROM tbl1;
SELECT group_concat(CASE t1 WHEN 'this' THEN null ELSE t1 END) FROM tbl1;
SELECT group_concat(CASE WHEN t1!='software' THEN null ELSE t1 END) FROM tbl1;
SELECT group_concat(CASE t1 WHEN 'this' THEN ''
                          WHEN 'program' THEN null ELSE t1 END) FROM tbl1;
SELECT typeof(group_concat(x)) FROM (SELECT '' AS x);
SELECT typeof(group_concat(x,''))
      FROM (SELECT '' AS x UNION ALL SELECT '');
SELECT coalesce(1,2);
CREATE TABLE t29b(a,b,c,d,e,f,g,h,i);
INSERT INTO t29b 
   VALUES(1, hex(randomblob(2000)), null, 0, 1, '', zeroblob(0),'x',x'01');
SELECT typeof(c), typeof(d), typeof(e), typeof(f),
         typeof(g), typeof(h), typeof(i) FROM t29b;
SELECT length(f), length(g), length(h), length(i) FROM t29b;
SELECT quote(f), quote(g), quote(h), quote(i) FROM t29b;
SELECT unicode('$');
SELECT unicode('ÃÂÃÂÃÂÃÂ¢');
SELECT unicode('ÃÂÃÂ¢ÃÂÃÂÃÂÃÂ¬');
SELECT char(36,162,8364);
SELECT char(), length(char()), typeof(char());
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a,b,c,e,f);
INSERT INTO t1 VALUES(1,2.5,'xyz',x'e0c1b2a3',null);
CREATE VIEW v33(y) AS SELECT testdirectonly(15);
CREATE TABLE t33a(a,b);
CREATE TABLE t33b(x,y);
INSERT INTO t33a VALUES(1,2);
ALTER TABLE t33a RENAME COLUMN a TO aaa;
SELECT sql FROM sqlite_master WHERE name='r1';
INSERT INTO t1(a) VALUES(1),(2);
SELECT * FROM t1;
CREATE TABLE t0(c0 CHECK(ABS(-9223372036854775808)));
PRAGMA integrity_check;
SELECT 123 -> 456;
SELECT 123 ->> 456;
WITH t1(x) AS (VALUES(9e+999)) SELECT sum(x), avg(x), total(x) FROM t1;
WITH t1(x) AS (VALUES(-9e+999)) SELECT sum(x), avg(x), total(x) FROM t1;
WITH RECURSIVE c(n) AS (VALUES(1) UNION ALL SELECT n+1 FROM c WHERE n<1)
  SELECT sum(1.7976931348623157e308),
         avg(1.7976931348623157e308),
         total(1.7976931348623157e308)
    FROM c;
